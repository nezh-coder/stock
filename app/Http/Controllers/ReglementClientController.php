<?php

namespace App\Http\Controllers;

use App\Models\ReglementClient;
use App\Models\Client;
use App\Models\Facture;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;
class ReglementClientController extends Controller
{
    public function index(Request $request)
    {
        $query = ReglementClient::with(['client','factures','user']);

    // 🔎 FILTRES
    if ($request->date_debut) {
        $query->whereDate('date_reglement', '>=', $request->date_debut);
    }

    if ($request->date_fin) {
        $query->whereDate('date_reglement', '<=', $request->date_fin);
    }

    if ($request->client_id) {
        $query->where('client_id', $request->client_id);
    }

    $reglements = $query->latest()->get();

    // 📊 CARDS STATS
    $totalReglements = $reglements->count();
    $totalMontant = $reglements->sum('montant');
    $totalPaye = DB::table('factures')->sum('montant_paye');
    $totalReste = DB::table('factures')
        ->selectRaw('SUM(total_ttc - montant_paye) as reste')
        ->value('reste');

    $clientsCount = $reglements->pluck('client_id')->unique()->count();

    $clients = Client::all();

    return view('paiements.index', compact(
        'reglements',
        'totalReglements',
        'totalMontant',
        'totalPaye',
        'totalReste',
        'clientsCount',
        'clients'
    ));
    }

    public function create()
    {
        $clients = Client::all();
        return view('paiements.create', compact('clients'));
    }

    public function store(Request $request)
    {
        DB::transaction(function() use ($request){
            $reglement = ReglementClient::create([
                'numero' => 'RC'.date('YmdHis'),
                'client_id' => $request->client_id,
                'date_reglement' => $request->date_reglement,
                'montant' => $request->montant,
                'mode_paiement' => $request->mode_paiement,
                'reference' => $request->reference,
                'notes' => $request->notes,
                'user_id' => auth()->id(),
            ]);

            foreach ($request->montants as $factureId => $montantPaye) {
                if($montantPaye <= 0) continue;

                $facture = Facture::lockForUpdate()->find($factureId);
                if(!$facture) continue;

                $facture->montant_paye += $montantPaye;
                $facture->status = ($facture->montant_paye >= $facture->total_ttc) ? 'payee' : 'partiellement_payee';
                $facture->save();

                $reglement->factures()->attach($factureId, ['montant_paye' => $montantPaye]);
            }
        });

        return redirect()->route('paiements.index')
            ->with('success','Règlement client enregistré avec succès !');
    }
    
    public function edit($id)
    { 
        $clients = Client::all();
        $reglement = ReglementClient::with('factures')
        ->findOrFail($id);
        if ($reglement->status == 'annule') {
        return redirect()->route('paiements.index')
            ->with('error','Impossible de modifier un règlement annulé');
        }
        return view('paiements.edit', compact('reglement','clients'));
    }
    public function facturesForEdit($clientId, $reglementId)
{
    $reglement = ReglementClient::with('factures')
        ->findOrFail($reglementId);

    $bons = Facture::where('client_id', $clientId)
        ->where(function($q){
            $q->where('status','non_paye')
              ->orWhere('status','partiellement_payee');
        })
        ->orWhereIn('id', $reglement->factures->pluck('id'))
        ->get();

    $bons = $bons->map(function($bon) use ($reglement){

        $pivot = $reglement->factures->firstWhere('id',$bon->id);

        $montantDejaPaye = $pivot ? $pivot->pivot->mont_paye : 0;

        return [
            'id' => $bon->id,
            'numero_facture' => $bon->numero_facture,
            'reste_a_payer' =>
                ($bon->total_ttc - $bon->montant_paye) + $montantDejaPaye,
            'montant_deja_paye' => $montantDejaPaye
        ];
    });

    return response()->json($bons);
}
    public function update(Request $request, $id)
{
         $reglement = ReglementClient::with('factures')
            ->lockForUpdate()
            ->findOrFail($id);

        if ($reglement->status == 'annulee') {
            abort(403, 'Règlement annulé non modifiable');
        }

        // 🔁 1. Restaurer anciens montants
        foreach ($reglement->factures as $bon) {

            $facture = Facture::lockForUpdate()->find($bon->id);

            $facture->montant_paye -= $bon->pivot->mont_paye;

            $reste = $facture->total_ttc - $facture->montant_paye;

            if ($facture->montant_paye <= 0) {
                $facture->status = 'non_payee';
            } elseif ($reste > 0) {
                $facture->status = 'partiellement_payee';
            } else {
                $facture->status = 'payee';
            }

            $facture->save();
        }

        // 🔁 2. Supprimer pivots
        DB::table('reglement_bon_reception')
            ->where('reglement_id', $reglement->id)
            ->delete();

        // 🔁 3. Mettre à jour règlement
        $reglement->update([
            'montant' => $request->montant,
            'date_reglement' => $request->date_reglement,
            'mode_paiement' => $request->mode_paiement,
            'reference' => $request->reference,
            'notes' => $request->notes,
        ]);

        // 🔁 4. Réappliquer nouveaux montants
        foreach ($request->montants as $bonId => $montantPaye) {

            if ($montantPaye <= 0) continue;

            $bon = Facture::lockForUpdate()->find($bonId);

            $bon->montant_paye += $montantPaye;

            $reste = $bon->total_ttc - $bon->montant_paye;

            $bon->status = $reste <= 0 ? 'payee' : 'partiellement_payee';

            $bon->save();

            DB::table('reglement_facture')->insert([
                'reglement_id' => $reglement->id,
                'facture_id' => $bonId,
                'mont_paye' => $montantPaye,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

    return redirect()->route('paiements.index')
        ->with('success','Règlement modifié avec succès');
}

    public function destroy(ReglementClient $reglement)
    {
        DB::transaction(function() use ($reglement){
            foreach($reglement->factures as $facture){
                $facture->montant_paye -= $facture->pivot->montant_paye;
                $facture->status = ($facture->montant_paye <= 0) ? 'non_payee' : 'partiellement_payee';
                $facture->save();
            }

            $reglement->factures()->detach();
            $reglement->delete();
        });

        return redirect()->route('paiements.index')
            ->with('success','Règlement client supprimé avec succès !');
    }

    public function facturesNonPayees($id)
    {
        
        $facture = Facture::where('client_id', $id)
            ->whereNotIn('status', ['payee', 'annulee'])
            ->get()
            ->map(function($facture){
                $facture->reste_a_payer = $facture->total_ttc - $facture->montant_paye;
                return $facture;
            });
    
    return response()->json($facture);
}

public function show($id)
{
    $reglement = ReglementClient::with(['client','factures'])
        ->findOrFail($id);

    return view('paiements.show', compact('reglement'));
}

public function exportPdf(Request $request)
{
    $query = ReglementClient::with(['client','factures']);

    if ($request->date_debut) {
        $query->whereDate('date_reglement', '>=', $request->date_debut);
    }

    if ($request->date_fin) {
        $query->whereDate('date_reglement', '<=', $request->date_fin);
    }

    if ($request->client_id) {
        $query->where('client_id', $request->client_id);
    }

    $reglements = $query->latest()->get();

    $totalGeneral = $reglements->sum('montant');

    $pdf = Pdf::loadView('paiements.pdf', compact(
        'reglements',
        'totalGeneral',
        'request'
    ))->setPaper('a4', 'landscape'); // ✅ paysage

    return $pdf->stream('etat_reglements_clients.pdf');
}


}