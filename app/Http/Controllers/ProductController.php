<?php

namespace App\Http\Controllers;
use App\Models\Product;
use App\Exports\ProductsExport;
use App\Imports\ProductsImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Models\Category;
use App\Models\AchatProduct;
use App\Models\Unite;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Product::withCount('category');

        // Search by name
        if ($request->has('search') && !empty($request->search)) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }
        $productsInStock = Product::where('quantity', '>', 0)->count();
       $productsLowStock = Product::whereColumn('quantity', '<', 'min_qte')
                                    ->where('quantity', '>', 0)
                                    ->count();
        $productsOutOfStock = Product::where('quantity', 0)->count();
        // Filter by stock status
        if ($request->has('stock_status') && !empty($request->stock_status)) {
            switch ($request->stock_status) {
                case 'in_stock':
                    $query->where('quantity', '>', 0);
                    break;
                case 'low_stock':
                    $query->whereColumn('quantity', '<', 'min_qte')->where('quantity', '>', 0);
                    break;
                case 'out_of_stock':
                    $query->where('quantity', 0);
                    break;
            }
        }

        $products = $query->paginate(20)->withQueryString();
        return view('products.index', compact('products','productsInStock','productsLowStock','productsOutOfStock'));
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:csv,txt|max:5120',
        ]);

        try {
            DB::transaction(function () use ($request) {
                Excel::import(new ProductsImport, $request->file('file'));
            });
        } catch (InvalidArgumentException $exception) {
            return redirect()->back()
                ->withInput()
                ->withErrors(['file' => $exception->getMessage()]);
        }

        return redirect()->route('products.index')
            ->with('success', 'Produits importés avec succès. Les catégories et unités manquantes ont été créées.');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
         $categories = Category::all();
         $unites = Unite::all();
         return view('products.create', compact('categories', 'unites'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|unique:products,name',
            'description' => 'nullable|string',
            'min_qte' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'unite_id' => 'required|exists:unites,id',
             'quantity' => ['required', 'numeric'],
           'unit_price' => ['required', 'numeric'],
        ]);

        Product::create([
            'name' => $request->name,
            'description' => $request->description,
            'min_qte' => $request->min_qte,
            'category_id' => $request->category_id,
            'quantity' => $request->quantity,
            'unit_price' => $request->unit_price,
            'unite_id' => $request->unite_id,
        ]);
       ///  dd($request->all()); // ✅ test if the request is received
        return redirect()->route('products.index')->with('success', 'Product created successfully!');
    
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::findOrFail($id);
        return view('products.show', compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $categories = Category::all();
        $unites = Unite::all();
        $product = Product::findOrFail($id);
        return view('products.edit', compact('product', 'categories', 'unites'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'name' => 'required|unique:products,name,' . $id,
            'description' => 'nullable|string',
            'min_qte' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'unite_id' => 'required|exists:unites,id',
            'quantity' => ['required', 'numeric'],
            'unit_price' => ['required', 'numeric'],
        ]);

        $product = Product::findOrFail($id);
        $product->update([
            'name' => $request->name,
            'description' => $request->description,
            'quantity' => $request->quantity,
            'min_qte' => $request->min_qte,
            'category_id' => $request->category_id,
            'unit_price' => $request->unit_price,
            'unite_id' => $request->unite_id,
                ]);

        return redirect()->route('products.index')->with('success', 'Produit mis à jour avec succès!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $product = Product::findOrFail($id);
        $product->delete();

        return redirect()->route('products.index')->with('success', 'Produit supprimé avec succès!');
    }

    /**
     * Display the inventory.
     */
    public function inventaire(Request $request)
    {
       $query = Product::with(['Category','Unite'])  
                ->withSum('achatProducts as quantity_achetee', 'quantity')
                ->withSum('achatProducts as total_achat', \DB::raw('quantity * unit_price'));

        // Search by name
        if ($request->has('search') && !empty($request->search)) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        // Filter by stock status
        if ($request->has('stock_status') && !empty($request->stock_status)) {
            switch ($request->stock_status) {
                case 'in_stock':
                    $query->where('quantity', '>', 10);
                    break;
                case 'low_stock':
                    $query->where('quantity', '>', 0)->where('quantity', '<=', 10);
                    break;
                case 'out_of_stock':
                    $query->where('quantity', 0);
                    break;
            }
        }

        $products = $query->paginate(15);

        // Statistics
        $totalProducts = Product::count();
        $totalValue = Product::sum(\DB::raw('quantity * unit_price'));
        $lowStockCount = Product::where('quantity', '>', 0)->where('quantity', '<=', 10)->count();
        $outOfStockCount = Product::where('quantity', 0)->count();

        // Handle export
       /* if ($request->has('export') && $request->export == 'excel') {
            return Excel::download(new ProductsExport, 'inventaire.xlsx');
        }*/

         if ($request->get('export') === 'excel') {
        return Excel::download(new ProductsExport, 'inventaire.xlsx');
    }

        return view('products.inventaire', compact('products', 'totalProducts', 'totalValue', 'lowStockCount', 'outOfStockCount'));
    }

    /**
     * Affiche les mouvements du produit.
     */
    public function movement(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $dateDeb = $request->input('date_deb');
        $dateFin = $request->input('date_fin');

        $movements = collect();

        // Devis Accepté
        $devis = \App\Models\Devis::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })
        ->where('status', 'accepte')
        ->when($dateDeb, fn($q) => $q->whereDate('date_devis', '>=', $dateDeb))
        ->when($dateFin, fn($q) => $q->whereDate('date_devis', '<=', $dateFin))
        ->with('client', 'products')
        ->get();
        foreach ($devis as $d) {
            $pivot = $d->products->firstWhere('id', $product->id)?->pivot;
            $movements->push((object)[
                'date' => $d->date_devis,
                'type' => 'Devis Accepté',
                'numero' => $d->numero_devis,
                'quantity' => $pivot?->quantity ?? '-',
                'price' => $pivot?->unit_price ?? '-',
                'partner' => $d->client->name ?? '-',
            ]);
        }

        // Bon de Réception
        $br = \App\Models\Achat::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })
        ->when($dateDeb, fn($q) => $q->whereDate('date_livraison', '>=', $dateDeb))
        ->when($dateFin, fn($q) => $q->whereDate('date_livraison', '<=', $dateFin))
        ->with('fournisseur', 'products')
        ->get();
        foreach ($br as $b) {
            $pivot = $b->products->firstWhere('id', $product->id)?->pivot;
            $movements->push((object)[
                'date' => $b->date_livraison,
                'type' => 'Bon de Réception',
                'numero' => $b->numero_achat ?? $b->id,
                'quantity' => $pivot?->quantity ?? '-',
                'price' => $pivot?->unit_price ?? '-',
                'partner' => $b->fournisseur->name ?? '-',
            ]);
        }

        // Bon de Livraison
        $bl = \App\Models\BonLivraison::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })
        ->when($dateDeb, fn($q) => $q->whereDate('date_livraison', '>=', $dateDeb))
        ->when($dateFin, fn($q) => $q->whereDate('date_livraison', '<=', $dateFin))
        ->with('client',  'products')
        ->get();
        foreach ($bl as $b) {
            $pivot = $b->products->firstWhere('id', $product->id)?->pivot;
            $movements->push((object)[
                'date' => $b->date_livraison,
                'type' => 'Bon de Livraison',
                'numero' => $b->numero_bon_livraison ?? $b->id,
                'quantity' => $pivot?->quantity ?? '-',
                'price' => $pivot?->unit_price ?? '-',
                'partner' => ($b->client->name ?? '-'),
            ]);
        }

        // Tri par date
        $movements = $movements->sortByDesc('date');

        return view('products.movement', compact('product', 'movements'));
    }
}
