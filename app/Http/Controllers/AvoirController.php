<?php

namespace App\Http\Controllers;

use App\Models\Avoir;
use App\Models\Client;
use App\Models\BonLivraison;
use App\Models\Facture;
use App\Models\Entreprise;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class AvoirController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Avoir::with('client', 'bonLivraison', 'facture');

        // Search by numero_avoir
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_avoir', 'like', '%' . $request->search . '%');
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        // Filter by source type
        if ($request->has('source_type') && !empty($request->source_type)) {
            if ($request->source_type == 'bon_livraison') {
                $query->whereNotNull('bon_livraison_id');
            } elseif ($request->source_type == 'facture') {
                $query->whereNotNull('facture_id');
            }
        }

        // Filter by date range
        if ($request->has('date_from') && !empty($request->date_from)) {
            $query->whereDate('date_avoir', '>=', $request->date_from);
        }
        if ($request->has('date_to') && !empty($request->date_to)) {
            $query->whereDate('date_avoir', '<=', $request->date_to);
        }

        $avoirs = $query->paginate(15);
        return view('avoirs.index', compact('avoirs'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $clients = Client::all();
        $bonLivraisons = BonLivraison::where('status', 'livre')->get();
        $factures = Facture::where('status', 'payee')->get();

        $sourceType = $request->get('source_type'); // 'bon_livraison' or 'facture'
        $sourceId = $request->get('source_id');

        $source = null;
        if ($sourceType === 'bon_livraison' && $sourceId) {
            $source = BonLivraison::with('products')->findOrFail($sourceId);
        } elseif ($sourceType === 'facture' && $sourceId) {
            $source = Facture::with('products')->findOrFail($sourceId);
        }

        return view('avoirs.create', compact('clients', 'bonLivraisons', 'factures', 'source', 'sourceType', 'sourceId'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:clients,id',
            'bon_livraison_id' => 'nullable|exists:bon_livraisons,id',
            'facture_id' => 'nullable|exists:factures,id',
            'date_avoir' => 'required|date',
            'tva' => 'required|numeric',
            'motif' => 'nullable|string',
            'notes' => 'nullable|string',
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
            'products.*.motif_retour' => 'nullable|string',
            'products.*.add_to_stock' => 'nullable|in:on',
        ]);

        $total_ht = 0;
        foreach ($request->products as $product) {
            $total_ht += $product['quantity'] * $product['unit_price'];
        }
        $tva = $request->tva;
        $total_ttc = $total_ht * (1 + $tva / 100);

        // Generate numero_avoir
        $annee = date('Y');
        $nextNum = Avoir::count() + 1;
        $numero_avoir = 'AV' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);

        $avoir = Avoir::create([
            'numero_avoir' => $numero_avoir,
            'client_id' => $request->client_id,
            'bon_livraison_id' => $request->bon_livraison_id,
            'facture_id' => $request->facture_id,
            'date_avoir' => $request->date_avoir,
            'total_ht' => $total_ht,
            'tva' => $tva,
            'total_ttc' => $total_ttc,
            'status' => 'en_cours',
            'motif' => $request->motif,
            'notes' => $request->notes,
        ]);

        foreach ($request->products as $product) {
            $avoir->products()->attach($product['product_id'], [
                'quantity' => $product['quantity'],
                'unit_price' => $product['unit_price'],
                'total' => $product['quantity'] * $product['unit_price'],
                'motif_retour' => $product['motif_retour'] ?? null,
            ]);

            // Add quantity back to product stock if checkbox is checked
            if (isset($product['add_to_stock']) && $product['add_to_stock'] === 'on') {
                \App\Models\Product::find($product['product_id'])->increment('quantity', $product['quantity']);
            }
        }

        return redirect()->route('avoirs.index')->with('success', 'Avoir créé avec succès!');
    }

    /**
     * Display the specified resource.
     */
    public function show(Avoir $avoir)
    {
        $avoir->load('client', 'bonLivraison', 'facture', 'products');
        return view('avoirs.show', compact('avoir'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Avoir $avoir)
    {
        $clients = Client::all();
        $bonLivraisons = BonLivraison::where('status', 'livre')->get();
        $factures = Facture::where('status', 'payee')->get();

        return view('avoirs.edit', compact('avoir', 'clients', 'bonLivraisons', 'factures'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Avoir $avoir)
    {
        $request->validate([
            'client_id' => 'required|exists:clients,id',
            'bon_livraison_id' => 'nullable|exists:bon_livraisons,id',
            'facture_id' => 'nullable|exists:factures,id',
            'date_avoir' => 'required|date',
            'tva' => 'required|numeric',
            'motif' => 'nullable|string',
            'notes' => 'nullable|string',
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'products.*.unit_price' => 'required|numeric|min:0',
            'products.*.motif_retour' => 'nullable|string',
            'products.*.add_to_stock' => 'nullable|in:on',
        ]);

        // Get old products before updating
        $oldProducts = $avoir->products()->get();
        $oldProductIds = $oldProducts->pluck('id')->toArray();
        $oldProductQties = $oldProducts->pluck('pivot.quantity', 'id')->toArray();

        // Calculate totals from products
        $total_ht = 0;
        foreach ($request->products as $product) {
            $total_ht += $product['quantity'] * $product['unit_price'];
        }
        $tva = $request->tva;
        $total_ttc = $total_ht * (1 + $tva / 100);

        // Update avoir
        $avoir->update([
            'client_id' => $request->client_id,
            'bon_livraison_id' => $request->bon_livraison_id,
            'facture_id' => $request->facture_id,
            'date_avoir' => $request->date_avoir,
            'total_ht' => $total_ht,
            'tva' => $tva,
            'total_ttc' => $total_ttc,
            'motif' => $request->motif,
            'notes' => $request->notes,
        ]);

        // Track new product IDs
        $newProductIds = [];

        // Remove old products and add new ones
        $avoir->products()->detach();
        
        foreach ($request->products as $product) {
            $newProductIds[] = $product['product_id'];
            $avoir->products()->attach($product['product_id'], [
                'quantity' => $product['quantity'],
                'unit_price' => $product['unit_price'],
                'total' => $product['quantity'] * $product['unit_price'],
                'motif_retour' => $product['motif_retour'] ?? null,
            ]);

            // Handle stock adjustments if checkbox is checked
            if (isset($product['add_to_stock']) && $product['add_to_stock'] === 'on') {
                \App\Models\Product::find($product['product_id'])->increment('quantity', $product['quantity']);
            }
        }

        // Handle products that were deleted from the avoir
        $deletedProductIds = array_diff($oldProductIds, $newProductIds);
        foreach ($deletedProductIds as $deletedProductId) {
            // Quantity was removed from avoir, so if user wants to adjust stock, reverse the transaction
            // This is optional - users can decide if they want to reverse stock for deleted products
            // You may want to add a checkbox for this as well
        }
    
        

        return redirect()->route('avoirs.index')->with('success', 'Avoir mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Avoir $avoir)
    {
        $avoir->delete();

        return redirect()->route('avoirs.index')->with('success', 'Avoir supprimé avec succès!');
    }

    /**
     * Generate PDF for avoir
     */
    public function pdf(Avoir $avoir)
    {
        $avoir->load(['client', 'bonLivraison', 'facture', 'products']);
        $entreprise = Entreprise::first();
        $client = $avoir->client;

        $pdf = Pdf::loadView('avoirs.pdf.pdf', compact('avoir', 'entreprise', 'client'))
            ->setPaper('A4');

        return $pdf->stream('avoir_' . $avoir->id . '.pdf');
    }

    /**
     * Get articles from a document (Bon de Livraison or Facture) for AJAX
     */
    public function getDocumentArticles(Request $request)
    {
        $documentId = $request->input('document_id');
        $documentType = $request->input('document_type');

        if ($documentType === 'bon_livraison') {
            $document = BonLivraison::with('products')->find($documentId);
        } elseif ($documentType === 'facture') {
            $document = Facture::with('products')->find($documentId);
        } else {
            return response()->json(['error' => 'Invalid document type'], 400);
        }

        if (!$document) {
            return response()->json(['error' => 'Document not found'], 404);
        }

        return response()->json(['products' => $document->products]);
    }

    /**
     * Get client documents (Bon de Livraison and Facture) for filtering
     */
    public function getClientDocuments(Request $request)
    {
        $clientId = $request->input('client_id');

        if (!$clientId) {
            return response()->json(['bonLivraisons' => [], 'factures' => []]);
        }

        $bonLivraisons = BonLivraison::where('client_id', $clientId)
            ->where('status', 'livre')
            ->get(['id', 'numero_bon_livraison', 'client_id']);

        $factures = Facture::where('client_id', $clientId)
            ->where('status', 'payee')
            ->get(['id', 'numero_facture', 'client_id']);

        return response()->json([
            'bonLivraisons' => $bonLivraisons,
            'factures' => $factures
        ]);
    }
}
