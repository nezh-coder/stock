<?php

namespace App\Http\Controllers;

use App\Models\BonCommande;
use Illuminate\Http\Request;
use App\Models\Client;
use App\Models\Product;
use App\Models\BonLivraison;
use Carbon\Carbon;
class BonCommandeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BonCommande::with('client');

        // Search by numero_bon_commande
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_bon_commande', 'like', '%' . $request->search . '%');
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        // Filter by date range
        if ($request->has('date_from') && !empty($request->date_from)) {
            $query->whereDate('date_commande', '>=', $request->date_from);
        }
        if ($request->has('date_to') && !empty($request->date_to)) {
            $query->whereDate('date_commande', '<=', $request->date_to);
        }

        $bonCommandes = $query->paginate(15);
        $transferredBonCommandeIds = BonLivraison::pluck('bon_commande_id')->filter()->toArray();
        return view('bon-commandes.index', compact('bonCommandes', 'transferredBonCommandeIds'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        
        $clients = Client::all();
        $products = Product::all();
        return view('bon-commandes.create', compact('clients', 'products'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $annee = Carbon::now()->year;
        $nextNum = BonCommande::count() + 1;
        $numero_bon_commande = 'BC' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);
        $request->validate([
            'numero_bon_commande' => 'required|unique:bon_commandes,numero_bon_commande',
              'client_id' => 'required|exists:clients,id',
            'date_commande' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:en_cours,recu,annule',
            'notes' => 'nullable|string',
        ]);

        $bonCommande = BonCommande::create([
            'num' => $nextNum,
            'annee' => $annee,
            'numero_bon_commande' => $numero_bon_commande,
            'client_id' => $request->client_id,
            'date_commande' => $request->date_commande,
            'total_ht' => $request->total_ht,
            'tva' => $request->tva,
            'total_ttc' => $request->total_ttc,
            'status' => $request->status,
            'notes' => $request->notes,
        ]);
          foreach ($request->products as $product) {
            $bonCommande->products()->attach($product['product_id'], [
                'quantity' => $product['quantity'],
                'unit_price' => $product['unit_price'],
                'total' => $product['quantity'] * $product['unit_price'],
            ]);
        }

        return redirect()->route('bon-commandes.index')->with('success', 'Bon de commande créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $bonCommande = BonCommande::with('client', 'products')->findOrFail($id);
        return view('bon-commandes.show', compact('bonCommande'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $bonCommande = BonCommande::findOrFail($id);
          $products = Product::all();
          $clients = Client::all();
        return view('bon-commandes.edit', compact('bonCommande', 'products', 'clients'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'numero_bon_commande' => 'required|unique:bon_commandes,numero_bon_commande,' . $id,
             'client_id' => 'required|exists:clients,id',
            'date_commande' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:en_cours,recu,annule',
            'notes' => 'nullable|string',
            // products are optional on update but if present must be valid
            'products' => 'nullable|array',
            'products.*.product_id' => 'required_with:products|exists:products,id',
            'products.*.quantity' => 'required_with:products|integer|min:1',
            'products.*.unit_price' => 'required_with:products|numeric|min:0',
        ]);
        

        $bonCommande = BonCommande::findOrFail($id);
         // If products provided, recalculate totals from products to keep data consistent
        if ($request->has('products') && is_array($request->products) && count($request->products) > 0) {
            $computedTotalHt = 0;
            foreach ($request->products as $p) {
                $computedTotalHt += ($p['quantity'] ?? 0) * ($p['unit_price'] ?? 0);
            }
            $tva = $request->tva;
            $computedTotalTtc = $computedTotalHt * (1 + ($tva / 100));

            // Merge computed totals into request data for update
            $updateData = $request->all();
            $updateData['total_ht'] = $computedTotalHt;
            $updateData['total_ttc'] = $computedTotalTtc;

            $bonCommande->update($updateData);

            // Sync products: detach then attach with pivot data
            $bonCommande->products()->detach();
            foreach ($request->products as $p) {
                $bonCommande->products()->attach($p['product_id'], [
                    'quantity' => $p['quantity'],
                    'unit_price' => $p['unit_price'],
                    'total' => ($p['quantity'] * $p['unit_price']),
                ]);
            }
        } else {
            // No products provided — update other fields as-is
            $bonCommande->update($request->all());
        }
       
        return redirect()->route('bon-commandes.index')->with('success', 'Bon de commande mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $bonCommande = BonCommande::findOrFail($id);
        $bonCommande->delete();

        return redirect()->route('bon-commandes.index')->with('success', 'Bon de commande supprimé avec succès!');
    }

    public function transfer(BonCommande $bonCommande)
    {
        $bonCommande->load('products');

        // Check if all products have sufficient quantity
        foreach ($bonCommande->products as $product) {
            if ($product->quantity < $product->pivot->quantity) {
                return redirect()->back()->with('error', "Stock insuffisant pour le produit: {$product->name}");
            }
        }

        $annee = Carbon::now()->year;
        $nextNum = BonLivraison::count() + 1;
        $numero_bon_livraison = 'BL' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);

        $bonLivraison = BonLivraison::create([
            'num'=>$nextNum,
            'annee' => $annee,
            'numero_bon_livraison' => $numero_bon_livraison,
            'client_id' => $bonCommande->client_id,
            'bon_commande_id' => $bonCommande->id,
            'date_livraison' => $bonCommande->date_commande,
            'total_ht' => $bonCommande->total_ht,
            'tva' => $bonCommande->tva,
            'total_ttc' => $bonCommande->total_ttc,
            'status' => 'en_cours',
            'notes' => $bonCommande->notes,
        ]);

        foreach ($bonCommande->products as $product) {
            $bonLivraison->products()->attach($product->id, [
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ]);

            // Subtract quantity from product stock
            $product->decrement('quantity', $product->pivot->quantity);
        }

        $bonCommande->update(['status' => 'recu']);

        return redirect()->route('bon-livraisons.index')->with('success', 'Bon de commande transféré en bon de livraison avec succès!');
    }
}
