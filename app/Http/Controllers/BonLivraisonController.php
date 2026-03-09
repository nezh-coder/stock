<?php

namespace App\Http\Controllers;

use App\Models\BonLivraison;
use Illuminate\Http\Request;
use App\Models\Client;
use App\Models\Entreprise;
use App\Models\Product;
use App\Models\BonCommande;
use App\Models\Facture;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;

class BonLivraisonController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BonLivraison::with('client');

        // Search by numero_bon_livraison
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_bon_livraison', 'like', '%' . $request->search . '%');
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        // Filter by date range
        if ($request->has('date_from') && !empty($request->date_from)) {
            $query->whereDate('date_livraison', '>=', $request->date_from);
        }
        if ($request->has('date_to') && !empty($request->date_to)) {
            $query->whereDate('date_livraison', '<=', $request->date_to);
        }

        $bonLivraisons = $query->paginate(15);
        $transferredBonLivraisonIds = Facture::pluck('bon_livraison_id')->filter()->toArray();
        return view('bon-livraisons.index', compact('bonLivraisons', 'transferredBonLivraisonIds'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {  
         $annee = Carbon::now()->year;
            // Dernier numéro pour l'année courante
        $lastNum = BonLivraison::where('annee', $annee)->max('num');
        $nextNum = $lastNum ? $lastNum + 1 : 1;
        $Num=str_pad($nextNum, 2, '0', STR_PAD_LEFT);
            // Format 01/25
        $numBon = str_pad($nextNum, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($annee, -2);
        $clients = Client::all();
        $products = Product::all();
        $bonCommandes = BonCommande::all();

        return view('bon-livraisons.create', compact('clients', 'products', 'bonCommandes', 'annee',"Num"));
        
    }

    public function getBonCommandeProducts($bon_commande_id)
    {
        $bonCommande = BonCommande::with('products')->findOrFail($bon_commande_id);
        $products = $bonCommande->products->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ];
        });
        return response()->json($products);
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
            'bon_commande_id' => 'nullable|exists:bon_commandes,id',
            'date_livraison' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:En attente,livré,annulé',
            'notes' => 'nullable|string',
        ]);
         $numero_bon_livraison = str_pad('BL'.$request->num, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($request->annee, -2);
        $bon = BonLivraison::create([
            'annee' =>$request->annee,
            'num' => $request->num,
             'numero_bon_livraison' => $numero_bon_livraison,
            'client_id' => $request->client_id,
            'bon_commande_id' => $request->bon_commande_id,
            'date_livraison' => $request->date_livraison,
            'total_ht' => $request->total_ht,
            'tva' => $request->tva,
            'total_ttc' => $request->total_ttc,
            'status' => $request->status,
            'notes' => $request->notes,
        ]);

        // Attach products
        if ($request->has('products')) {
            foreach ($request->products as $productData) {
                $bon->products()->attach($productData['product_id'], [
                    'quantity' => $productData['quantity'],
                    'unit_price' => $productData['unit_price'],
                    'total' => $productData['quantity'] * $productData['unit_price'],
                ]);
                // Decrease product quantity
                $product = Product::find($productData['product_id']);
                $product->decrement('quantity', $productData['quantity']);
            }
        }

        return redirect()->route('bon-livraisons.index')->with('success', 'Bon de livraison créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $bonLivraison = BonLivraison::with('client', 'bonCommande', 'products')->findOrFail($id);
        return view('bon-livraisons.show', compact('bonLivraison'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $bonLivraison = BonLivraison::with('products')->findOrFail($id);
        $clients = Client::all();
        $products = Product::all();
        $bonCommandes = BonCommande::all();
        return view('bon-livraisons.edit', compact('bonLivraison', 'clients', 'products', 'bonCommandes'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'numero_bon_livraison' => 'required|unique:bon_livraisons,numero_bon_livraison,' . $id,
            'client_id' => 'required|exists:clients,id',
            'bon_commande_id' => 'nullable|exists:bon_commandes,id',
            'date_livraison' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:En attente,livré,annulé',
            'notes' => 'nullable|string',
            'products' => 'nullable|array',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|numeric|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
        ]);

        $bonLivraison = BonLivraison::with('products')->findOrFail($id);

        // Restore old product quantities
        foreach ($bonLivraison->products as $product) {
            $product->increment('quantity', $product->pivot->quantity);
        }

        // Detach old products
        $bonLivraison->products()->detach();

        // Update bon fields
        $bonLivraison->update($request->only([
            'numero_bon_livraison', 'client_id', 'bon_commande_id', 'date_livraison',
            'total_ht', 'tva', 'total_ttc', 'status', 'notes'
        ]));

        // Attach new products and decrease quantities
        if ($request->has('products')) {
            foreach ($request->products as $productData) {
                $bonLivraison->products()->attach($productData['product_id'], [
                    'quantity' => $productData['quantity'],
                    'unit_price' => $productData['unit_price'],
                    'total' => $productData['quantity'] * $productData['unit_price'],
                ]);
                // Decrease product quantity
                $product = Product::find($productData['product_id']);
                $product->decrement('quantity', $productData['quantity']);
            }
        }

        return redirect()->route('bon-livraisons.index')->with('success', 'Bon de livraison mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $bonLivraison = BonLivraison::with('products')->findOrFail($id);
        
        // Restore product quantities
        foreach ($bonLivraison->products as $product) {
            $product->increment('quantity', $product->pivot->quantity);
        }
        
        $bonLivraison->delete();

        return redirect()->route('bon-livraisons.index')->with('success', 'Bon de livraison supprimé avec succès!');
    }

    public function transfer(BonLivraison $bonLivraison)
    {
        $bonLivraison->load('products');

        $annee = Carbon::now()->year;
        $nextNum = Facture::count() + 1;
        $numero_facture = 'F' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);

        $facture = Facture::create([
            'num'=>$nextNum,
            'annee' => $annee,
            'numero_facture' => $numero_facture,
            'client_id' => $bonLivraison->client_id,
            'bon_livraison_id' => $bonLivraison->id,
            'date_facture' => $bonLivraison->date_livraison,
            'date_echeance' => Carbon::parse($bonLivraison->date_livraison)->addDays(30),
            'total_ht' => $bonLivraison->total_ht,
            'tva' => $bonLivraison->tva,
            'total_ttc' => $bonLivraison->total_ttc,
            'status' => 'non_payee',
            'notes' => $bonLivraison->notes,
        ]);

        foreach ($bonLivraison->products as $product) {
            $facture->products()->attach($product->id, [
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ]);
        }

        $bonLivraison->update(['status' => 'livre']);

        return redirect()->route('factures.index')->with('success', 'Bon de livraison transféré en facture avec succès!');
    }

    public function pdf(BonLivraison $BonLivraison)
        { 
           $entreprise = Entreprise::first();
            // Charger le client avec le devis
            $BonLivraison->load('client');
            $client = $BonLivraison->client;
           
            $pdf = Pdf::loadView('bon-livraisons.pdf.bl', compact('BonLivraison',  'client', 'entreprise'))
    ->setPaper('a4', 'portrait')
    ->setOptions([
        'isRemoteEnabled' => true,
    ]);

        return $pdf->stream('BL_'.$BonLivraison->id.'.pdf');
             }
}
