<?php

namespace App\Http\Controllers;

use App\Models\Avoir;
use App\Models\BonCommande;
use App\Models\BonLivraison;
use App\Models\Client;
use App\Models\Devis;
use App\Models\Entreprise;
use App\Models\Facture;
use App\Models\Fournisseur;
use App\Models\Product;
use App\Services\SaasLimitService;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index(SaasLimitService $limits)
    {
        $user = auth()->user();
        $entrepriseId = $user?->entreprise_id;

        if ($entrepriseId === null) {
            return view('dashboard', [
                'entreprise' => null,
                'stats' => [],
                'stockValue' => 0,
                'stockAlerts' => collect(),
                'recentProducts' => collect(),
                'recentDocuments' => collect(),
                'summary' => [],
                'activities' => collect(),
                'saasUsage' => [],
            ]);
        }

        $entreprise = Entreprise::find($entrepriseId);
        $products = Product::where('entreprise_id', $entrepriseId);

        $stats = [
            'products' => (clone $products)->count(),
            'stock_total' => (clone $products)->sum('quantity'),
            'stock_faible' => (clone $products)->where('quantity', '>', 0)->whereNotNull('min_qte')->whereColumn('quantity', '<=', 'min_qte')->count(),
            'ruptures' => (clone $products)->where('quantity', 0)->count(),
            'clients' => Client::where('entreprise_id', $entrepriseId)->count(),
            'fournisseurs' => Fournisseur::where('entreprise_id', $entrepriseId)->count(),
        ];

        $stockValue = (clone $products)->selectRaw('COALESCE(SUM(quantity * unit_price), 0) as value')->value('value');
        $stockAlerts = (clone $products)
            ->with('category:id,name')
            ->whereNotNull('min_qte')
            ->whereColumn('quantity', '<=', 'min_qte')
            ->orderByRaw('CASE WHEN quantity = 0 THEN 0 ELSE 1 END')
            ->orderByRaw('(min_qte - quantity) DESC')
            ->limit(8)
            ->get(['id', 'name', 'marque', 'quantity', 'min_qte', 'category_id']);

        $recentProducts = (clone $products)
            ->with('category:id,name')
            ->latest()
            ->limit(6)
            ->get(['id', 'name', 'quantity', 'unit_price', 'category_id', 'created_at']);

        $documentDefinitions = [
            [Devis::class, 'numero_devis', 'date_devis', 'Devis', 'devis.index'],
            [BonCommande::class, 'numero_bon_commande', 'date_commande', 'Bon de commande', 'bon-commandes.index'],
            [BonLivraison::class, 'numero_bon_livraison', 'date_livraison', 'Bon de livraison', 'bon-livraisons.index'],
            [Facture::class, 'numero_facture', 'date_facture', 'Facture', 'factures.index'],
            [Avoir::class, 'numero_avoir', 'date_avoir', 'Avoir', 'avoirs.index'],
        ];

        $recentDocuments = collect();
        foreach ($documentDefinitions as [$model, $numberColumn, $dateColumn, $label, $route]) {
            $documents = $model::where('entreprise_id', $entrepriseId)
                ->with('client:id,name')
                ->latest($dateColumn)
                ->limit(3)
                ->get(['id', $numberColumn, 'client_id', $dateColumn, 'total_ttc', 'status']);

            foreach ($documents as $document) {
                $date = $document->{$dateColumn} ? Carbon::parse($document->{$dateColumn}) : null;
                $recentDocuments->push([
                    'type' => $label,
                    'number' => $document->{$numberColumn},
                    'client' => $document->client?->name,
                    'date' => $date,
                    'date_label' => $date?->format('d/m/Y'),
                    'total' => $document->total_ttc,
                    'status' => $document->status,
                    'route' => $route,
                ]);
            }
        }
        $recentDocuments = $recentDocuments->sortByDesc(fn ($document) => $document['date']?->timestamp ?? 0)->take(8)->values();

        $monthStart = now()->startOfMonth();
        $monthEnd = now()->endOfMonth();
        $summary = [
            'ca' => Facture::where('entreprise_id', $entrepriseId)->whereBetween('date_facture', [$monthStart, $monthEnd])->sum('total_ttc'),
            'factures' => Facture::where('entreprise_id', $entrepriseId)->whereBetween('date_facture', [$monthStart, $monthEnd])->count(),
            'devis' => Devis::where('entreprise_id', $entrepriseId)->whereBetween('date_devis', [$monthStart, $monthEnd])->count(),
            'commandes' => BonCommande::where('entreprise_id', $entrepriseId)->whereBetween('date_commande', [$monthStart, $monthEnd])->count(),
            'livraisons' => BonLivraison::where('entreprise_id', $entrepriseId)->whereBetween('date_livraison', [$monthStart, $monthEnd])->count(),
        ];

        $activities = collect();
        $activityDefinitions = [
            [Product::class, 'Produit ajouté', 'fa-box', 'products.index', 'name'],
            [Client::class, 'Client ajouté', 'fa-user', 'clients.index', 'name'],
            [Fournisseur::class, 'Fournisseur ajouté', 'fa-truck', 'fournisseurs.index', 'name'],
            [Devis::class, 'Devis créé', 'fa-file-signature', 'devis.index', 'numero_devis'],
            [Facture::class, 'Facture créée', 'fa-file-invoice-dollar', 'factures.index', 'numero_facture'],
            [BonLivraison::class, 'Bon de livraison créé', 'fa-dolly', 'bon-livraisons.index', 'numero_bon_livraison'],
            [Avoir::class, 'Avoir créé', 'fa-rotate-left', 'avoirs.index', 'numero_avoir'],
        ];

        foreach ($activityDefinitions as [$model, $label, $icon, $route, $displayColumn]) {
            $items = $model::where('entreprise_id', $entrepriseId)
                ->latest('created_at')
                ->limit(2)
                ->get(['id', $displayColumn, 'created_at']);

            foreach ($items as $item) {
                $date = $item->created_at ? Carbon::parse($item->created_at) : null;
                $activities->push([
                    'label' => $label,
                    'name' => $item->{$displayColumn},
                    'icon' => $icon,
                    'route' => $route,
                    'date_label' => $date?->diffForHumans(),
                    'date' => $date,
                ]);
            }
        }
        $activities = $activities->sortByDesc(fn ($activity) => $activity['date']?->timestamp ?? 0)->take(7)->values();
        $saasUsage = $limits->usage();

        return view('dashboard', compact(
            'entreprise',
            'stats',
            'stockValue',
            'stockAlerts',
            'recentProducts',
            'recentDocuments',
            'summary',
            'activities',
            'saasUsage'
        ));
    }
}
