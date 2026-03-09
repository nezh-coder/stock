<?php
namespace App\Http\Controllers;
use App\Models\ReglementFournisseur;
use App\Models\Achat;
use App\Models\Fournisseur;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Barryvdh\DomPDF\Facade\Pdf;

class ReglementFournisseurController extends Controller
{


public function exportPdf(Request $request)
{
    $query = ReglementFournisseur::with(['fournisseur','achats','user']);

    if ($request->date_debut) {
        $query->whereDate('date_reglement', '>=', $request->date_debut);
    }

    if ($request->date_fin) {
        $query->whereDate('date_reglement', '<=', $request->date_fin);
    }

    if ($request->fournisseur_id) {
        $query->where('fournisseur_id', $request->fournisseur_id);
    }

    $reglements = $query->latest()->get();

    $totalGeneral = $reglements->sum('montant');

    $pdf = Pdf::loadView('reglements.pdf', compact(
        'reglements',
        'totalGeneral',
        'request'
    ))->setPaper('a4', 'landscape'); // ✅ paysage

    return $pdf->stream('etat_reglements.pdf');
}

public function show($id)
{
    $reglement = ReglementFournisseur::with(['fournisseur','achats'])
        ->findOrFail($id);

    return view('reglements.show', compact('reglement'));
}



public function index(Request $request)
{
    $query = ReglementFournisseur::with(['fournisseur','user','achats']);

    // 🔎 FILTRES
    if ($request->date_debut) {
        $query->whereDate('date_reglement', '>=', $request->date_debut);
    }

    if ($request->date_fin) {
        $query->whereDate('date_reglement', '<=', $request->date_fin);
    }

    if ($request->fournisseur_id) {
        $query->where('fournisseur_id', $request->fournisseur_id);
    }

    $reglements = $query->latest()->get();

    // 📊 CARDS STATS
    $totalReglements = $reglements->count();
    $totalMontant = $reglements->sum('montant');
    $totalPaye = DB::table('achats')->sum('montant_paye');
    $totalReste = DB::table('achats')
        ->selectRaw('SUM(total_ttc - montant_paye) as reste')
        ->value('reste');

    $fournisseursCount = $reglements->pluck('fournisseur_id')->unique()->count();

    $fournisseurs = Fournisseur::all();

    return view('reglements.index', compact(
        'reglements',
        'totalReglements',
        'totalMontant',
        'totalPaye',
        'totalReste',
        'fournisseursCount',
        'fournisseurs'
    ));
}
 public function create()
    {  
      
        $fournisseurs = Fournisseur::all();
         
        return view('reglements.create', compact('fournisseurs'));
        
    }
public function store(Request $request)
{
    $totalFromBons = array_sum($request->montants ?? []);

if ($totalFromBons != $request->montant) {
    return back()->with('error',
        'Le montant total ne correspond pas à la somme des bons');
}
    DB::transaction(function () use ($request) {
        $reglement = ReglementFournisseur::create([
            'fournisseur_id' => $request->fournisseur_id,
            'montant' => $request->montant,
            'date_reglement' => $request->date_reglement,
            'mode_paiement' => $request->mode_paiement,
            'reference' => $request->reference,
            'user_id' => auth()->user()->id,
            'notes' => $request->notes,
        ]);

        foreach ($request->montants as $bonId => $montantPaye) {

            if ($montantPaye <= 0) continue;

            $bon = Achat::lockForUpdate()->find($bonId);

            if (!$bon) continue;

            $bon->montant_paye += $montantPaye;

            $reste = $bon->total_ttc - $bon->montant_paye;

            $bon->status = $reste <= 0 ? 'paye' : 'partiellement_paye';

            $bon->save();

            DB::table('reglement_bon_reception')->insert([
                'reglement_id' => $reglement->id,
                'bon_reception_id' => $bonId,
                'mont_paye' => $montantPaye,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

    });

    return redirect()->route('reglements.index')
        ->with('success', 'Règlement enregistré avec succès');
}

   public function bonsNonPayes($id)
{
    $bons = Achat::where('fournisseur_id', $id)
        ->whereNotIn('status', ['paye','annule'])
        ->get()
        ->map(function($bon){
            $bon->reste_a_payer = $bon->total_ttc - $bon->montant_paye;
            return $bon;
        });
    
    return response()->json($bons);
}

/**
     * Remove the specified resource from storage.
     */
/*** 
   public function destroy(string $id)
{
    DB::transaction(function () use ($id) {

        $reglement = ReglementFournisseur::with('achats')
            ->lockForUpdate()
            ->findOrFail($id);

        foreach ($reglement->achats as $bon) {

            // 🔒 Lock bon
            $achat = Achat::lockForUpdate()->find($bon->id);

            if (!$achat) continue;

            // 🔁 Récupérer montant payé depuis pivot
            $montantPaye = $bon->pivot->mont_paye;

            // ➖ Soustraire le montant
            $achat->montant_paye -= $montantPaye;

            // 🧮 Recalcul du status
            $reste = $achat->total_ttc - $achat->montant_paye;

            if ($achat->montant_paye <= 0) {
                $achat->status = 'non_paye';
            } elseif ($reste > 0) {
                $achat->status = 'partiellement_paye';
            } else {
                $achat->status = 'paye';
            }

            $achat->save();
        }

        // 🗑 Supprimer pivot
        DB::table('reglement_bon_reception')
            ->where('reglement_id', $reglement->id)
            ->delete();

        // 🗑 Supprimer règlement
        $reglement->delete();
    });

    return redirect()
        ->route('reglements.index')
        ->with('success', 'Règlement annulé et montants restaurés avec succès');
}
**/
/***edit reglement */
public function edit($id)
{
    $reglement = ReglementFournisseur::with('achats')
        ->findOrFail($id);

    if ($reglement->status == 'annule') {
        return redirect()->route('reglements.index')
            ->with('error','Impossible de modifier un règlement annulé');
    }

    $fournisseurs = Fournisseur::all();

    return view('reglements.edit', compact('reglement','fournisseurs'));
}
public function bonsForEdit($fournisseurId, $reglementId)
{
    $reglement = ReglementFournisseur::with('achats')
        ->findOrFail($reglementId);

    $bons = Achat::where('fournisseur_id', $fournisseurId)
        ->where(function($q){
            $q->where('status','non_paye')
              ->orWhere('status','partiellement_paye');
        })
        ->orWhereIn('id', $reglement->achats->pluck('id'))
        ->get();

    $bons = $bons->map(function($bon) use ($reglement){

        $pivot = $reglement->achats->firstWhere('id',$bon->id);

        $montantDejaPaye = $pivot ? $pivot->pivot->mont_paye : 0;

        return [
            'id' => $bon->id,
            'numero_achat' => $bon->numero_achat,
            'reste_a_payer' =>
                ($bon->total_ttc - $bon->montant_paye) + $montantDejaPaye,
            'montant_deja_paye' => $montantDejaPaye
        ];
    });

    return response()->json($bons);
}
public function destroy($id)
{
    DB::transaction(function () use ($id) {

        $reglement = ReglementFournisseur::with('achats')
            ->lockForUpdate()
            ->findOrFail($id);

        if ($reglement->status == 'annule') {
            abort(403,'Déjà annulé');
        }

        foreach ($reglement->achats as $bon) {

            $achat = Achat::lockForUpdate()->find($bon->id);

            $achat->montant_paye -= $bon->pivot->mont_paye;

            $reste = $achat->total_ttc - $achat->montant_paye;

            if ($achat->montant_paye <= 0) {
                $achat->status = 'non_paye';
            } elseif ($reste > 0) {
                $achat->status = 'partiellement_paye';
            } else {
                $achat->status = 'paye';
            }

            $achat->save();
        }

        $reglement->status = 'annule';
        $reglement->save();
    });

    return redirect()->route('reglements.index')
        ->with('success','Règlement annulé avec succès');
}
public function update(Request $request, $id)
{
    DB::transaction(function () use ($request, $id) {

        $reglement = ReglementFournisseur::with('achats')
            ->lockForUpdate()
            ->findOrFail($id);

        if ($reglement->status == 'annule') {
            abort(403, 'Règlement annulé non modifiable');
        }

        // 🔁 1. Restaurer anciens montants
        foreach ($reglement->achats as $bon) {

            $achat = Achat::lockForUpdate()->find($bon->id);

            $achat->montant_paye -= $bon->pivot->mont_paye;

            $reste = $achat->total_ttc - $achat->montant_paye;

            if ($achat->montant_paye <= 0) {
                $achat->status = 'non_paye';
            } elseif ($reste > 0) {
                $achat->status = 'partiellement_paye';
            } else {
                $achat->status = 'paye';
            }

            $achat->save();
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

            $bon = Achat::lockForUpdate()->find($bonId);

            $bon->montant_paye += $montantPaye;

            $reste = $bon->total_ttc - $bon->montant_paye;

            $bon->status = $reste <= 0 ? 'paye' : 'partiellement_paye';

            $bon->save();

            DB::table('reglement_bon_reception')->insert([
                'reglement_id' => $reglement->id,
                'bon_reception_id' => $bonId,
                'mont_paye' => $montantPaye,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

    });

    return redirect()->route('reglements.index')
        ->with('success','Règlement modifié avec succès');
}
}
