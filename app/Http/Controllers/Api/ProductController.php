<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    // Retourne le dernier prix d'achat pour un produit
    public function lastPurchasePrice($productId)
    {
        $row = DB::table('achat_products')
            ->where('product_id', $productId)
            ->orderByDesc('id')
            ->first();
        return response()->json([
            'prix_achat' => $row ? $row->unit_price : null
        ]);
    }
}
