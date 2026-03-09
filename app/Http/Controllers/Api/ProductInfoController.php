<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Product;
use App\Models\Devis;
use App\Models\Achat;
use App\Models\BonReception;
use App\Models\BonLivraison;

class ProductInfoController extends Controller
{
    public function info($id)
    {
        // Devis Accepté
        $devis = Devis::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })->where('status', 'accepte')->with(['client'])->orderByDesc('date_devis')->get();

        $devisHtml = $devis->isEmpty() ? null : view('partials.product.devis', compact('devis'))->render();

        // Bon de Réception
        $br = Achat::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })->with(['fournisseur'])->orderByDesc('date_livraison')->get();
        $brHtml = $br->isEmpty() ? null : view('partials.product.br', compact('br'))->render();

        // Bon de Livraison
        $bl = BonLivraison::whereHas('products', function($q) use ($id) {
            $q->where('product_id', $id);
        })->with(['client'])->orderByDesc('date_livraison')->get();
        $blHtml = $bl->isEmpty() ? null : view('partials.product.bl', compact('bl'))->render();

        return response()->json([
            'devisHtml' => $devisHtml,
            'brHtml' => $brHtml,
            'blHtml' => $blHtml,
        ]);
    }
}
