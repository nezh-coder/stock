<?php

namespace App\Http\Controllers;

use App\Models\BonComAchat;
use Illuminate\Http\Request;
use App\Models\Fournisseur;
use App\Models\Product;
use App\Models\BonLivraison;
use Carbon\Carbon;
class BonComAchatController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = BonComAchat::with('fournisseur', 'products');

        // Search by numero_bc_achat
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_bc_achat', 'like', '%' . $request->search . '%');
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

        $BonComAchats = $query->paginate(15);
        $transferredBonComAchatIds = BonLivraison::pluck('bon_commande_id')->filter()->toArray();
        return view('Bon-com-achats.index', compact('BonComAchats', 'transferredBonComAchatIds'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
          $annee = Carbon::now()->year;
            // Dernier numéro pour l'année courante
        $lastNum = BonComAchat::where('annee', $annee)->max('num');
        $nextNum = $lastNum ? $lastNum + 1 : 1;
        $Num=str_pad($nextNum, 2, '0', STR_PAD_LEFT);
            // Format 01/25
        $numBon = str_pad($nextNum, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($annee, -2);
        $fournisseurs = Fournisseur::all();
        $products = Product::all();
        return view('Bon-com-achats.create', compact('fournisseurs', 'products', 'annee',"Num"));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
     $numero_bc_achat= str_pad('BC'.$request->num, 2, '0', STR_PAD_LEFT)
                    . '/' .
                    substr($request->annee, -2);   
       
        
        $BonComAchat = BonComAchat::create([
            'num' => $request->num,
            'annee' => $request->annee,
            'numero_bc_achat' => $numero_bc_achat,
            'fournisseur_id' => $request->fournisseur_id,
            'date_bc_achat' => $request->date_bc_achat,
            'total_ht' => $request->total_ht,
            'tva' => $request->tva,
            'total_ttc' => $request->total_ttc,
            'status' => $request->status,
            'notes' => $request->notes,
        ]);
          foreach ($request->products as $product) {
            $BonComAchat->products()->attach($product['product_id'], [
                'quantity' => $product['quantity'],
                'unit_price' => $product['unit_price'],
                'total' => $product['quantity'] * $product['unit_price'],
            ]);
        }

        return redirect()->route('bon-com-achats.index')->with('success', 'Bon de commande créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $BonComAchat = BonComAchat::with('fournisseur', 'products')->findOrFail($id);
        return view('bon-com-achats.show', compact('BonComAchat'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $BonComAchat = BonComAchat::findOrFail($id);
          $products = Product::all();
          $fournisseurs = Fournisseur::all();
        return view('Bon-com-achats.edit', compact('BonComAchat', 'products', 'fournisseurs'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'numero_bc_achat' => 'required|unique:bon_com_achats,numero_bc_achat,' . $id,
            'fournisseur_id' => 'required|exists:fournisseurs,id',
            'date_livraison' => 'nullable|date',
            'date_bc_achat' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:brouillon,envoye,livre,annule',
            'notes' => 'nullable|string',
            // products are optional on update but if present must be valid
            'products' => 'nullable|array',
            'products.*.product_id' => 'required_with:products|exists:products,id',
            'products.*.quantity' => 'required_with:products|integer|min:1',
            'products.*.unit_price' => 'required_with:products|numeric|min:0',
        ]);

        $BonComAchat = BonComAchat::findOrFail($id);

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

            $BonComAchat->update($updateData);

            // Sync products: detach then attach with pivot data
            $BonComAchat->products()->detach();
            foreach ($request->products as $p) {
                $BonComAchat->products()->attach($p['product_id'], [
                    'quantity' => $p['quantity'],
                    'unit_price' => $p['unit_price'],
                    'total' => ($p['quantity'] * $p['unit_price']),
                ]);
            }
        } else {
            // No products provided — update other fields as-is
            $BonComAchat->update($request->all());
        }

        return redirect()->route('bon-com-achats.index')->with('success', 'Bon de commande mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $BonComAchat = BonComAchat::findOrFail($id);
        $BonComAchat->delete();

        return redirect()->route('Bon-com-achats.index')->with('success', 'Bon de commande supprimé avec succès!');
    }

    public function transfer(BonComAchat $BonComAchat)
    {
        $BonComAchat->load('products');

        // Check if all products have sufficient quantity
        foreach ($BonComAchat->products as $product) {
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
            'fournisseur_id' => $BonComAchat->fournisseur_id,
            'bon_commande_id' => $BonComAchat->id,
            'date_livraison' => $BonComAchat->date_commande,
            'total_ht' => $BonComAchat->total_ht,
            'tva' => $BonComAchat->tva,
            'total_ttc' => $BonComAchat->total_ttc,
            'status' => 'en_cours',
            'notes' => $BonComAchat->notes,
        ]);

        foreach ($BonComAchat->products as $product) {
            $bonLivraison->products()->attach($product->id, [
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ]);

            // Subtract quantity from product stock
            $product->decrement('quantity', $product->pivot->quantity);
        }

        $BonComAchat->update(['status' => 'recu']);

        return redirect()->route('bon-livraisons.index')->with('success', 'Bon de commande transféré en bon de livraison avec succès!');
    }
}
