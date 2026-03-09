<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Client;
use App\Models\Fournisseur;
use App\Models\Devis;
use App\Models\BonCommande;
use App\Models\BonLivraison;
use App\Models\Facture;
use App\Models\Avoir;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        $stats = [
            'products' => Product::count(),
            'clients' => Client::count(),
            'fournisseurs' => Fournisseur::count(),
            'devis' => Devis::count(),
            'bon_commandes' => BonCommande::count(),
            'bon_livraisons' => BonLivraison::count(),
            'factures' => Facture::count(),
            'avoirs' => Avoir::count(),
        ];

        return view('dashboard', compact('stats'));
    }
}
