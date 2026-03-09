@extends('adminlte::page')

@section('title', 'Statistiques - Gestion Stock')

@section('content')
<div class="container-fluid">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h3 mb-0 text-gray-800">
                        <i class="fas fa-tachometer-alt mr-2 text-primary"></i>Tableau de bord
                    </h1>
                    <p class="text-muted mb-0">Bienvenue dans votre système de gestion de stock</p>
                </div>
                <div>
                    <small class="text-muted">
                        <i class="fas fa-calendar mr-1"></i>{{ \Carbon\Carbon::now()->format('l, d F Y') }}
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards Row 1 -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $stats['products'] ?? 0 }}</h3>
                    <p class="mb-0">Total Produits</p>
                    <small class="text-white-50">Articles en inventaire</small>
                </div>
                <div class="icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <a href="{{ route('products.index') }}" class="small-box-footer">
                    Voir tous les produits <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $stats['clients'] ?? 0 }}</h3>
                    <p class="mb-0">Clients Actifs</p>
                    <small class="text-white-50">Base de clients</small>
                </div>
                <div class="icon">
                    <i class="fas fa-users"></i>
                </div>
                <a href="{{ route('clients.index') }}" class="small-box-footer">
                    Gérer les clients <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $stats['fournisseurs'] ?? 0 }}</h3>
                    <p class="mb-0">Fournisseurs</p>
                    <small class="text-white-50">Partenaires commerciaux</small>
                </div>
                <div class="icon">
                    <i class="fas fa-truck"></i>
                </div>
                <a href="{{ route('fournisseurs.index') }}" class="small-box-footer">
                    Voir les fournisseurs <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $stats['factures'] ?? 0 }}</h3>
                    <p class="mb-0">Factures</p>
                    <small class="text-white-50">Documents de vente</small>
                </div>
                <div class="icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <a href="{{ route('factures.index') }}" class="small-box-footer">
                    Consulter les factures <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Statistics Cards Row 2 -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-primary">
                <div class="inner">
                    <h3>{{ $stats['devis'] ?? 0 }}</h3>
                    <p class="mb-0">Devis en Cours</p>
                    <small class="text-white-50">Offres commerciales</small>
                </div>
                <div class="icon">
                    <i class="fas fa-file-contract"></i>
                </div>
                <a href="{{ route('devis.index') }}" class="small-box-footer">
                    Gérer les devis <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-secondary">
                <div class="inner">
                    <h3>{{ $stats['bon_commandes'] ?? 0 }}</h3>
                    <p class="mb-0">Bons de Commande</p>
                    <small class="text-white-50">Commandes fournisseurs</small>
                </div>
                <div class="icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <a href="{{ route('bon-commandes.index') }}" class="small-box-footer">
                    Voir les commandes <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-dark">
                <div class="inner">
                    <h3>{{ $stats['bon_livraisons'] ?? 0 }}</h3>
                    <p class="mb-0">Bons de Livraison</p>
                    <small class="text-white-50">Livraisons effectuées</small>
                </div>
                <div class="icon">
                    <i class="fas fa-truck-loading"></i>
                </div>
                <a href="{{ route('bon-livraisons.index') }}" class="small-box-footer">
                    Suivre les livraisons <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>

        <div class="col-lg-3 col-6">
            <div class="small-box bg-light">
                <div class="inner">
                    <h3 class="text-dark">{{ $stats['avoirs'] ?? 0 }}</h3>
                    <p class="mb-0 text-dark">Avoirs</p>
                    <small class="text-muted">Retours & avoirs</small>
                </div>
                <div class="icon">
                    <i class="fas fa-undo text-dark"></i>
                </div>
                <a href="{{ route('avoirs.index') }}" class="small-box-footer bg-dark">
                    Gérer les avoirs <i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Quick Actions & Recent Activity -->
    <div class="row">
        <!-- Quick Actions -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-bolt mr-2"></i>Actions Rapides
                    </h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6 mb-3">
                            <a href="{{ route('products.create') }}" class="btn btn-primary btn-block">
                                <i class="fas fa-plus mr-2"></i>Nouveau Produit
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="{{ route('clients.create') }}" class="btn btn-success btn-block">
                                <i class="fas fa-user-plus mr-2"></i>Nouveau Client
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="{{ route('devis.create') }}" class="btn btn-warning btn-block">
                                <i class="fas fa-file-contract mr-2"></i>Créer Devis
                            </a>
                        </div>
                        <div class="col-6 mb-3">
                            <a href="{{ route('factures.create') }}" class="btn btn-danger btn-block">
                                <i class="fas fa-file-invoice-dollar mr-2"></i>Nouvelle Facture
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- System Status -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-info-circle mr-2"></i>État du Système
                    </h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="info-box">
                                <span class="info-box-icon bg-success">
                                    <i class="fas fa-server"></i>
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Statut</span>
                                    <span class="info-box-number">En Ligne</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="info-box">
                                <span class="info-box-icon bg-info">
                                    <i class="fas fa-database"></i>
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Base de Données</span>
                                    <span class="info-box-number">Connectée</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="progress-group">
                                <span class="float-left">Utilisation Stock</span>
                                <span class="float-right">Activité Récente

                                    <strong>{{ $stats['products'] ?? 0 }}</strong>/{{ $stats['products'] ?? 0 }}
                                </span>
                                <div class="progress progress-sm">
                                    <div class="progress-bar bg-primary" style="width: 100%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity & Alerts -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-history mr-2"></i>Activité Récente
                    </h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="timeline timeline-inverse">
                        <div class="time-label">
                            <span class="bg-danger">
                                {{ \Carbon\Carbon::now()->format('d M Y') }}
                            </span>
                        </div>
                        <div>
                            <i class="fas fa-user-plus bg-success"></i>
                            <div class="timeline-item">
                                <span class="time"><i class="fas fa-clock"></i> {{ \Carbon\Carbon::now()->format('H:i') }}</span>
                                <h3 class="timeline-header">
                                    <a href="#">Système de Gestion Stock</a> initialisé avec succès
                                </h3>
                                <div class="timeline-body">
                                    Toutes les fonctionnalités sont opérationnelles. Vous pouvez commencer à gérer vos produits, clients et documents.
                                </div>
                            </div>
                        </div>
                        <div>
                            <i class="fas fa-clock bg-gray"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <a href="#" class="text-muted">Voir toute l'activité</a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
