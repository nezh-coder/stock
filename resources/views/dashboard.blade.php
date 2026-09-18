@extends('adminlte::page')

@section('title', 'Tableau de bord')

@section('css')
<style>
    .dashboard-page { --ink: #172033; --muted: #718096; --line: #e8edf3; --blue: #2563eb; background: #f5f7fb; margin: -15px; padding: 28px 15px; color: var(--ink); }
    .dashboard-page .card { border: 1px solid var(--line); border-radius: 12px; box-shadow: 0 5px 18px rgba(23, 32, 51, .04); }
    .dashboard-page .card-header { background: #fff; border-bottom: 1px solid var(--line); padding: 18px 20px; }
    .dashboard-page .card-title { font-weight: 700; margin: 0; }
    .dashboard-page .muted { color: var(--muted); }
    .dashboard-hero { background: linear-gradient(118deg, #172033 0%, #243b67 100%); border-radius: 14px; color: #fff; padding: 28px 30px; position: relative; overflow: hidden; }
    .dashboard-hero:after { content: ''; position: absolute; width: 240px; height: 240px; right: -70px; top: -110px; border: 35px solid rgba(255,255,255,.08); border-radius: 50%; }
    .dashboard-hero h1 { font-size: 1.8rem; font-weight: 700; margin-bottom: 6px; }
    .dashboard-hero p { color: rgba(255,255,255,.72); margin: 0; }
    .company-pill { background: rgba(255,255,255,.1); border: 1px solid rgba(255,255,255,.14); border-radius: 8px; display: inline-block; font-size: .85rem; margin-top: 18px; padding: 8px 12px; }
    .kpi-card { align-items: center; background: #fff; border: 1px solid var(--line); border-radius: 12px; display: flex; min-height: 112px; padding: 18px; transition: transform .15s ease, box-shadow .15s ease; }
    .kpi-card:hover { box-shadow: 0 8px 22px rgba(23,32,51,.1); transform: translateY(-2px); }
    .kpi-icon { align-items: center; border-radius: 10px; display: flex; flex: 0 0 46px; height: 46px; justify-content: center; margin-right: 14px; }
    .kpi-label { color: var(--muted); font-size: .78rem; font-weight: 600; text-transform: uppercase; }
    .kpi-value { color: var(--ink); font-size: 1.65rem; font-weight: 700; line-height: 1.1; }
    .bg-soft-blue { background: #e8f0ff; color: #2563eb; } .bg-soft-green { background: #e6f7ef; color: #15945e; }
    .bg-soft-orange { background: #fff3df; color: #d88308; } .bg-soft-red { background: #ffeaeb; color: #d63946; }
    .bg-soft-purple { background: #f0ebff; color: #7357c7; } .bg-soft-cyan { background: #e5f7fa; color: #16899a; }
    .dashboard-table td, .dashboard-table th { border-top: 1px solid #f0f2f5; padding: 12px 10px; vertical-align: middle; }
    .dashboard-table th { border-top: 0; color: var(--muted); font-size: .72rem; font-weight: 700; text-transform: uppercase; }
    .status-dot { border-radius: 50%; display: inline-block; height: 8px; margin-right: 6px; width: 8px; }
    .quick-action { align-items: center; border: 1px solid var(--line); border-radius: 9px; color: var(--ink); display: flex; font-weight: 600; min-height: 58px; padding: 12px; transition: background .15s ease, border-color .15s ease; }
    .quick-action:hover { background: #f5f8ff; border-color: #b9cdfb; color: var(--blue); text-decoration: none; }
    .quick-action i { font-size: 1.05rem; margin-right: 10px; width: 22px; }
    .activity-item { align-items: center; border-bottom: 1px solid #f0f2f5; display: flex; padding: 12px 0; }
    .activity-item:last-child { border-bottom: 0; }
    .activity-icon { align-items: center; background: #edf3ff; border-radius: 50%; color: var(--blue); display: flex; flex: 0 0 34px; height: 34px; justify-content: center; margin-right: 11px; }
    .empty-state { color: var(--muted); padding: 28px 12px; text-align: center; }
    @media (max-width: 575.98px) { .dashboard-page { margin: -7.5px; padding: 18px 10px; } .dashboard-hero { padding: 22px 20px; } .dashboard-hero h1 { font-size: 1.4rem; } .kpi-card { min-height: 96px; padding: 13px; } .kpi-value { font-size: 1.35rem; } }
</style>
@endsection

@section('content')
<div class="dashboard-page">
    <div class="container-fluid px-0">
        <div class="dashboard-hero mb-4">
            <div class="position-relative" style="z-index: 1;">
                <div class="small text-uppercase font-weight-bold text-white-50 mb-2">Tableau de bord</div>
                <h1>Bonjour {{ auth()->user()->name }} <span aria-hidden="true">&#128075;</span></h1>
                <p>Voici un aperçu de l'activité de votre entreprise.</p>
                @if($entreprise)
                    <span class="company-pill"><i class="fas fa-building mr-2"></i>Entreprise : {{ $entreprise->name }}</span>
                @endif
            </div>
        </div>

        @if(!$entreprise)
            <div class="alert alert-warning"><i class="fas fa-exclamation-triangle mr-2"></i>Votre compte n'est associé à aucune entreprise.</div>
        @else
            <div class="card mb-4 border-left-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center flex-wrap mb-3">
                        <div><h3 class="h5 mb-1"><i class="fas fa-crown text-primary mr-2"></i>{{ config('saas.plans.'.$entreprise->plan.'.name', 'Essai gratuit') }}</h3><small class="muted">@if($entreprise->hasActiveTrial()){{ $entreprise->getDaysRemainingInTrial() }} jours restants dans votre essai gratuit@else Votre période d'essai gratuit est terminée.@endif</small></div>
                        <a class="btn btn-sm btn-outline-primary mt-2 mt-md-0" href="{{ route('subscription.show') }}">Voir le forfait</a>
                    </div>
                    <div class="row">
                        @foreach($saasUsage as $item)
                            @if(in_array($item['resource'], ['products', 'clients', 'fournisseurs', 'devis', 'factures']))
                                <div class="col-md mb-3 mb-md-0"><div class="d-flex justify-content-between small mb-1"><span>{{ ucfirst($item['resource']) }}</span><strong>{{ $item['used'] }} / {{ $item['limit'] ?? '∞' }}</strong></div>@if($item['limit'])<div class="progress progress-sm"><div class="progress-bar {{ $item['used'] >= $item['limit'] ? 'bg-danger' : 'bg-primary' }}" style="width: {{ min(100, ($item['used'] / max(1, $item['limit'])) * 100) }}%"></div></div>@endif</div>
                            @endif
                        @endforeach
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                @php($kpis = [
                    ['products', 'Produits', 'fa-boxes', 'bg-soft-blue', 'products.index'],
                    ['stock_total', 'Stock total', 'fa-layer-group', 'bg-soft-cyan', 'products.index'],
                    ['stock_faible', 'Stock faible', 'fa-triangle-exclamation', 'bg-soft-orange', 'products.index'],
                    ['ruptures', 'Ruptures de stock', 'fa-circle-xmark', 'bg-soft-red', 'products.index'],
                    ['clients', 'Clients', 'fa-users', 'bg-soft-purple', 'clients.index'],
                    ['fournisseurs', 'Fournisseurs', 'fa-truck', 'bg-soft-green', 'fournisseurs.index'],
                ])
                @foreach($kpis as [$key, $label, $icon, $color, $route])
                    <div class="col-6 col-xl-2 mb-3">
                        <a href="{{ route($route) }}" class="text-decoration-none">
                            <div class="kpi-card"><span class="kpi-icon {{ $color }}"><i class="fas {{ $icon }}"></i></span><div><div class="kpi-label">{{ $label }}</div><div class="kpi-value">{{ number_format($stats[$key] ?? 0, 0, ',', ' ') }}</div></div></div>
                        </a>
                    </div>
                @endforeach
            </div>

            <div class="row mb-4">
                <div class="col-lg-7 mb-4 mb-lg-0"><div class="card h-100"><div class="card-header d-flex justify-content-between align-items-center"><h3 class="card-title"><i class="fas fa-bell text-warning mr-2"></i>Alertes stock</h3><a href="{{ route('products.index') }}" class="small font-weight-bold">Voir tous les produits <i class="fas fa-arrow-right ml-1"></i></a></div><div class="card-body p-0">@if($stockAlerts->isEmpty())<div class="empty-state"><i class="fas fa-circle-check text-success fa-2x mb-2"></i><div>Aucun produit en rupture ou sous le seuil minimum.</div></div>@else<div class="table-responsive"><table class="table dashboard-table mb-0"><thead><tr><th>Produit</th><th>Catégorie</th><th>Stock</th><th>Minimum</th></tr></thead><tbody>@foreach($stockAlerts as $product)<tr><td><a href="{{ route('products.show', $product) }}" class="font-weight-bold text-dark">{{ $product->name }}</a>@if($product->marque)<small class="d-block muted">{{ $product->marque }}</small>@endif</td><td class="muted">{{ $product->category?->name ?? 'Sans catégorie' }}</td><td><span class="status-dot {{ $product->quantity == 0 ? 'bg-danger' : 'bg-warning' }}"></span><span class="font-weight-bold">{{ rtrim(rtrim(number_format($product->quantity, 2, ',', ' '), '0'), ',') }}</span></td><td class="muted">{{ rtrim(rtrim(number_format($product->min_qte, 2, ',', ' '), '0'), ',') }}</td></tr>@endforeach</tbody></table></div>@endif</div></div></div>
                <div class="col-lg-5"><div class="card h-100"><div class="card-header"><h3 class="card-title"><i class="fas fa-chart-line text-primary mr-2"></i>Activité du mois</h3><small class="muted">Depuis le {{ now()->startOfMonth()->format('d/m/Y') }}</small></div><div class="card-body"><div class="d-flex justify-content-between border-bottom pb-3 mb-3"><span class="muted">Chiffre d'affaires</span><strong class="h5 mb-0">{{ number_format($summary['ca'] ?? 0, 2, ',', ' ') }} DH</strong></div><div class="row text-center"><div class="col-6 border-right"><strong class="h4 d-block">{{ $summary['factures'] ?? 0 }}</strong><small class="muted">Factures</small></div><div class="col-6"><strong class="h4 d-block">{{ $summary['devis'] ?? 0 }}</strong><small class="muted">Devis</small></div></div><div class="row text-center mt-4"><div class="col-6 border-right"><strong class="h4 d-block">{{ $summary['commandes'] ?? 0 }}</strong><small class="muted">Commandes</small></div><div class="col-6"><strong class="h4 d-block">{{ $summary['livraisons'] ?? 0 }}</strong><small class="muted">Livraisons</small></div></div><div class="mt-4 pt-3 border-top"><span class="muted">Valeur du stock</span><strong class="float-right">{{ number_format($stockValue ?? 0, 2, ',', ' ') }} DH</strong></div></div></div></div>
            </div>

            <div class="row mb-4">
                <div class="col-lg-6 mb-4 mb-lg-0"><div class="card h-100"><div class="card-header d-flex justify-content-between align-items-center"><h3 class="card-title"><i class="fas fa-box-open text-info mr-2"></i>Derniers produits ajoutés</h3><a href="{{ route('products.index') }}" class="small font-weight-bold">Tout voir</a></div><div class="card-body p-0">@forelse($recentProducts as $product)<div class="d-flex align-items-center px-3 py-3 border-bottom"><span class="kpi-icon bg-soft-blue mr-3"><i class="fas fa-box"></i></span><div class="flex-grow-1"><a href="{{ route('products.show', $product) }}" class="font-weight-bold text-dark">{{ $product->name }}</a><small class="d-block muted">{{ $product->category?->name ?? 'Sans catégorie' }} · {{ $product->created_at?->format('d/m/Y') }}</small></div><div class="text-right"><strong>{{ number_format($product->quantity, 0, ',', ' ') }}</strong><small class="d-block muted">{{ number_format($product->unit_price, 2, ',', ' ') }} DH</small></div></div>@empty<div class="empty-state">Aucun produit récemment ajouté.</div>@endforelse</div></div></div>
                <div class="col-lg-6"><div class="card h-100"><div class="card-header"><h3 class="card-title"><i class="fas fa-bolt text-warning mr-2"></i>Actions rapides</h3></div><div class="card-body"><div class="row">@foreach([['products.create','Nouveau produit','fa-plus','text-primary'],['clients.create','Nouveau client','fa-user-plus','text-success'],['fournisseurs.create','Nouveau fournisseur','fa-truck','text-info'],['devis.create','Nouveau devis','fa-file-signature','text-warning'],['factures.create','Nouvelle facture','fa-file-invoice-dollar','text-danger'],['bon-commandes.create','Bon de commande','fa-cart-shopping','text-secondary']] as [$route, $label, $icon, $color])<div class="col-6 mb-3"><a href="{{ route($route) }}" class="quick-action"><i class="fas {{ $icon }} {{ $color }}"></i><span>{{ $label }}</span></a></div>@endforeach</div></div></div></div>
            </div>

            <div class="row mb-4"><div class="col-12"><div class="card"><div class="card-header"><h3 class="card-title"><i class="fas fa-file-lines text-primary mr-2"></i>Derniers documents</h3></div><div class="card-body p-0">@if($recentDocuments->isEmpty())<div class="empty-state">Aucun document récent.</div>@else<div class="table-responsive"><table class="table dashboard-table mb-0"><thead><tr><th>Document</th><th>Client</th><th>Date</th><th>Total</th><th>Statut</th></tr></thead><tbody>@foreach($recentDocuments as $document)<tr><td><a href="{{ route($document['route']) }}" class="font-weight-bold text-dark">{{ $document['number'] ?: $document['type'] }}</a><small class="d-block muted">{{ $document['type'] }}</small></td><td>{{ $document['client'] ?: 'Client non renseigné' }}</td><td class="muted">{{ $document['date_label'] ?: '-' }}</td><td class="font-weight-bold">{{ number_format($document['total'] ?? 0, 2, ',', ' ') }} DH</td><td>@if($document['status'])<span class="badge badge-light">{{ ucfirst(str_replace('_', ' ', $document['status'])) }}</span>@else<span class="muted">-</span>@endif</td></tr>@endforeach</tbody></table></div>@endif</div></div></div></div>

            <div class="row"><div class="col-lg-7 mb-4 mb-lg-0"><div class="card"><div class="card-header"><h3 class="card-title"><i class="fas fa-clock-rotate-left text-secondary mr-2"></i>Dernières activités</h3></div><div class="card-body py-1">@forelse($activities as $activity)<div class="activity-item"><span class="activity-icon"><i class="fas {{ $activity['icon'] }}"></i></span><div class="flex-grow-1"><a href="{{ route($activity['route']) }}" class="font-weight-bold text-dark">{{ $activity['label'] }}</a><small class="d-block muted">{{ $activity['name'] }}</small></div><small class="muted">{{ $activity['date_label'] ?: '-' }}</small></div>@empty<div class="empty-state">Aucune activité récente.</div>@endforelse</div></div></div><div class="col-lg-5"><div class="card"><div class="card-header"><h3 class="card-title"><i class="fas fa-chart-pie text-success mr-2"></i>Navigation rapide</h3></div><div class="card-body"><a href="{{ route('products.inventaire') }}" class="btn btn-outline-primary btn-block text-left"><i class="fas fa-clipboard-list mr-2"></i>Consulter l'inventaire</a><a href="{{ route('factures.index') }}" class="btn btn-outline-secondary btn-block text-left"><i class="fas fa-file-invoice mr-2"></i>Suivre les factures</a></div></div></div></div>
        @endif
    </div>
</div>
@endsection
