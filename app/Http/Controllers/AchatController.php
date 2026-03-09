<?php

namespace App\Http\Controllers;

use App\Models\Achat;
use Illuminate\Http\Request;
use App\Models\Fournisseur;
use App\Models\Entreprise;
use App\Models\Product;
use App\Models\Facture;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;

class AchatController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Achat::with('fournisseur', 'products');

        // Search by numero_achat
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_achat', 'like', '%' . $request->search . '%');
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

        $achats = $query->paginate(15);
         return view('achats.index', compact('achats'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {  
      
        $fournisseurs = Fournisseur::all();
        $products = Product::all();
       
        return view('achats.create', compact('fournisseurs', 'products'));
        
    }

   

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    { 
        
        $request->validate([
            'numero_achat' => 'required|string',
            'fournisseur_id' => 'required|exists:fournisseurs,id',
             'date_livraison' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:en_cours,partiellement_paye,paye,annule',
            'montant_paye' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        // Validate montant_paye if status requires it
        if (in_array($request->status, ['partiellement_paye', 'paye'])) {
            $request->validate([
                'montant_paye' => 'required|numeric|min:0|max:' . $request->total_ttc,
            ]);
        }

        $bon = Achat::create([
               'numero_achat' => $request->numero_achat,
            'fournisseur_id' => $request->fournisseur_id,
             'date_livraison' => $request->date_livraison,
            'total_ht' => $request->total_ht,
            'tva' => $request->tva,
            'total_ttc' => $request->total_ttc,
            'status' => $request->status,
            'montant_paye' => $request->montant_paye  ?? 0,
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

        return redirect()->route('achats.index')->with('success', 'Bon de Récéption créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $Achat = Achat::with('fournisseur', 'products')->findOrFail($id);
        return view('achats.show', compact('Achat'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $Achat = Achat::with('products')->findOrFail($id);
        $fournisseurs = Fournisseur::all();
        $products = Product::all();
        return view('achats.edit', compact('Achat', 'fournisseurs', 'products'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'numero_achat' => 'required|unique:achats,numero_achat,' . $id,
          'fournisseur_id' => 'required|exists:fournisseurs,id',
             'date_livraison' => 'required|date',
            'total_ht' => 'required|numeric',
            'tva' => 'required|numeric',
            'total_ttc' => 'required|numeric',
            'status' => 'required|in:en_cours,partiellement_paye,paye,annule',
            'montant_paye' => 'nullable|numeric|min:0',
            'notes' => 'nullable|string',
            'products' => 'nullable|array',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|numeric|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
        ]);

        // Validate montant_paye if status requires it
        if (in_array($request->status, ['partiellement_paye', 'paye'])) {
            $request->validate([
                'montant_paye' => 'required|numeric|min:0|max:' . $request->total_ttc,
            ]);
        }

        $Achat = Achat::with('products')->findOrFail($id);

        // Restore old product quantities
        foreach ($Achat->products as $product) {
            $product->increment('quantity', $product->pivot->quantity);
        }

        // Detach old products
        $Achat->products()->detach();

        // Update bon fields
        $Achat->update($request->only([
            'numero_achat', 'fournisseur_id', 'bon_commande_id', 'date_livraison',
            'total_ht', 'tva', 'total_ttc', 'status', 'montant_paye', 'notes'
        ]));

        // Attach new products and decrease quantities
        if ($request->has('products')) {
            foreach ($request->products as $productData) {
                $Achat->products()->attach($productData['product_id'], [
                    'quantity' => $productData['quantity'],
                    'unit_price' => $productData['unit_price'],
                    'total' => $productData['quantity'] * $productData['unit_price'],
                ]);
                // Decrease product quantity
                $product = Product::find($productData['product_id']);
                $product->decrement('quantity', $productData['quantity']);
            }
        }

        return redirect()->route('achats.index')->with('success', 'Bon de livraison mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $Achat = Achat::with('products')->findOrFail($id);
        
        // Restore product quantities
        foreach ($Achat->products as $product) {
            $product->increment('quantity', $product->pivot->quantity);
        }
        
        $Achat->delete();

        return redirect()->route('achats.index')->with('success', 'Bon de livraison supprimé avec succès!');
    }

    public function transfer(Achat $Achat)
    {
        $Achat->load('products');

        $annee = Carbon::now()->year;
        $nextNum = Facture::count() + 1;
        $numero_facture = 'F' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);

        $facture = Facture::create([
            'num'=>$nextNum,
            'annee' => $annee,
            'numero_facture' => $numero_facture,
            'fournisseur_id' => $Achat->fournisseur_id,
            'bon_livraison_id' => $Achat->id,
            'date_facture' => $Achat->date_livraison,
            'date_echeance' => Carbon::parse($Achat->date_livraison)->addDays(30),
            'total_ht' => $Achat->total_ht,
            'tva' => $Achat->tva,
            'total_ttc' => $Achat->total_ttc,
            'status' => 'non_payee',
            'notes' => $Achat->notes,
        ]);

        foreach ($Achat->products as $product) {
            $facture->products()->attach($product->id, [
                'quantity' => $product->pivot->quantity,
                'unit_price' => $product->pivot->unit_price,
                'total' => $product->pivot->total,
            ]);
        }

        $Achat->update(['status' => 'livre']);

        return redirect()->route('factures.index')->with('success', 'Bon de livraison transféré en facture avec succès!');
    }

    public function pdf(Achat $Achat)
        { 
           $entreprise = Entreprise::first();
            // Charger le fournisseur avec le devis
            $Achat->load('fournisseur');
            $fournisseur = $Achat->fournisseur;
           
            $pdf = Pdf::loadView('achats.pdf.bl', compact('Achat',  'fournisseur', 'entreprise'))
    ->setPaper('a4', 'portrait')
    ->setOptions([
        'isRemoteEnabled' => true,
    ]);

        return $pdf->stream('BL_'.$Achat->id.'.pdf');
             }
}
