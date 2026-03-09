<?php

namespace App\Http\Controllers;

use App\Models\Devis;
use App\Models\Client;
use App\Models\Product;
use App\Models\BonCommande;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Helpers\ChiffresEnLettres;

class DevisController extends Controller
{

        public function print(Devis $devi)
        {
            return view('devis.print', compact('devi'));
        }

        public function pdf(Devis $devi)
        {
            $entreprise = Entreprise::first();
            // Charger le client avec le devis
            $devi->load('client');
            $client = $devi->client;
            $pdf = Pdf::loadView('devis.pdf.devis', compact('devi', 'entreprise', 'client'))
    ->setPaper('a4', 'portrait')
    ->setOptions([
        'isRemoteEnabled' => true,
    ]);

        return $pdf->stream('devis_'.$devi->id.'.pdf');
             }
    public function a5(Devis $devi)
        {
            $entreprise = Entreprise::first();
            // Charger le client avec le devis
            $devi->load('client');
            $client = $devi->client;
            $pdf = Pdf::loadView('devis.pdf.a5', compact('devi', 'entreprise', 'client'))
    ->setPaper('a5', 'portrait')
    ->setOptions([
        'isRemoteEnabled' => true,
    ]);

        return $pdf->stream('devis_'.$devi->id.'.pdf');
             }
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Devis::with('client');

        // Search by numero_devis
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_devis', 'like', '%' . $request->search . '%');
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        // Filter by date range
        if ($request->has('date_from') && !empty($request->date_from)) {
            $query->whereDate('date_devis', '>=', $request->date_from);
        }
        if ($request->has('date_to') && !empty($request->date_to)) {
            $query->whereDate('date_devis', '<=', $request->date_to);
        }

        $devis = $query->paginate(15);
        $transferredDevisIds = BonCommande::pluck('devis_id')->filter()->toArray();
        return view('devis.index', compact('devis', 'transferredDevisIds'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $annee = Carbon::now()->year;
            // Dernier numéro pour l'année courante
        $lastNum = Devis::where('annee', $annee)->max('num');
        $nextNum = $lastNum ? $lastNum + 1 : 1;
        $Num=str_pad($nextNum, 2, '0', STR_PAD_LEFT);
            // Format 01/25
        $numDevis = str_pad($nextNum, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($annee, -2);
        $clients = Client::all();
        $products = Product::all();
        return view('devis.create', compact('clients', 'products', 'annee',"Num"));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
       
        $request->validate([
            'num' => 'required|numeric',
             'annee' => 'required|integer',
            'client_id' => 'required|exists:clients,id',
            'date_devis' => 'required|date',
            'tva' => 'required|numeric',
            'status' => 'required|in:brouillon,envoye,accepte,refuse',
            'notes' => 'nullable|string',
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
        ]);

        $total_ht = 0;
        foreach ($request->products as $product) {
            $total_ht += $product['quantity'] * $product['unit_price'];
        }
        $tva = $request->tva;
        $total_ttc = $total_ht * (1 + $tva / 100);
        $numero_devis = str_pad($request->num, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($request->annee, -2);
        $devis = Devis::create([
            'annee' =>$request->annee,
            'num' => $request->num,
             'numero_devis' => $numero_devis,
            'client_id' => $request->client_id,
            'date_devis' => $request->date_devis,
            'total_ht' => $total_ht,
            'tva' => $tva,
            'total_ttc' => $total_ttc,
            'status' => $request->status,
            'notes' => $request->notes,
        ]);

        foreach ($request->products as $product) {
            $devis->products()->attach($product['product_id'], [
                'quantity' => $product['quantity'],
                'unit_price' => $product['unit_price'],
                'total' => $product['quantity'] * $product['unit_price'],
            ]);
        }

        return redirect()->route('devis.index')->with('success', 'Devis créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $devi = Devis::with('client', 'products')->findOrFail($id);
        return view('devis.show', compact('devi'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $devi = Devis::findOrFail($id);
         $products = Product::all();
          $clients = Client::all();
        return view('devis.edit', compact('devi', 'products', 'clients'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
          $request->validate([
            'numero_devis' => 'required',
            'client_id' => 'required|exists:clients,id',
            'date_devis' => 'required',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:brouillon,envoye,accepte,refuse',
            'notes' => 'nullable|string',
            'products' => 'nullable|array',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|numeric|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
        ]);
            // 🔁 Conversion d-m-Y → Y-m-d
        $data = $request->except('products');
        $data['date_devis'] = Carbon::createFromFormat('d-m-Y', $request->date_devis)
                                    ->format('Y-m-d');
        $devi = Devis::findOrFail($id);
         $devi->update($data);
         // 🔄 Sync produits
    $syncData = [];

    foreach ($request->products as $product) {
        $syncData[$product['product_id']] = [
            'quantity' => $product['quantity'],
            'unit_price' => $product['unit_price'],
            'total' => $product['quantity'] * $product['unit_price'],
        ];
    }
        $devi->products()->sync($syncData);

        return redirect()->route('devis.index')->with('success', 'Devis mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $devi = Devis::findOrFail($id);
        $devi->delete();

        return redirect()->route('devis.index')->with('success', 'Devis supprimé avec succès!');
    }

    public function transfer(Devis $devis)
    {
        $devis->load('products');

        $annee = Carbon::now()->year;
        $nextNum = BonCommande::count() + 1;
        $numero_bon_commande = 'BC' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);

        $bonCommande = BonCommande::create([
            'num' => $nextNum,
            'annee' => $annee,
            'numero_bon_commande' => $numero_bon_commande,
            'devis_id' => $devis->id,
            'client_id' => $devis->client_id,
            'date_commande' => $devis->date_devis,
            'total_ht' => $devis->total_ht,
            'tva' => $devis->tva,
            'total_ttc' => $devis->total_ttc,
            'status' => 'en_cours',
            'notes' => $devis->notes,
        ]);

        foreach ($devis->products as $product) {
            $bonCommande->products()->attach($product->id, [
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ]);
        }

        $devis->update(['status' => 'Accepté']);

        return redirect()->route('bon-commandes.index')->with('success', 'Devis transféré en bon de commande avec succès!');
    }
}
