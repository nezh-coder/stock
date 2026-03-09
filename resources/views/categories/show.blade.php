@extends('adminlte::page')

@section('title', 'Détails du Produit - ' . $product->name)

@section('content')
<div class="container-fluid">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h3 mb-0 text-gray-800">
                        <i class="fas fa-box mr-2 text-primary"></i>Détails du Produit
                    </h1>
                    <p class="text-muted mb-0">{{ $product->name }}</p>
                </div>
                <div>
                    <a href="{{ route('products.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-1"></i>Retour à la liste
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Product Information -->
        <div class="col-lg-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-info-circle mr-2"></i>Informations du Produit
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">NOM DU PRODUIT</label>
                                <p class="h5 mb-0">{{ $product->name }}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">RÉFÉRENCE/ID</label>
                                <p class="h5 mb-0 text-primary">#{{ $product->id }}</p>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">PRIX UNITAIRE</label>
                                <p class="h4 mb-0 text-success">{{ number_format($product->unit_price, 2) }} €</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">QUANTITÉ EN STOCK</label>
                                <p class="h4 mb-0">
                                    @if($product->quantity > 10)
                                        <span class="badge badge-success badge-lg">{{ $product->quantity }}</span>
                                    @elseif($product->quantity > 0)
                                        <span class="badge badge-warning badge-lg">{{ $product->quantity }}</span>
                                    @else
                                        <span class="badge badge-danger badge-lg">{{ $product->quantity }}</span>
                                    @endif
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <label class="text-muted small">DESCRIPTION</label>
                                <p class="mb-0">{{ $product->description ?: 'Aucune description disponible.' }}</p>
                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">CRÉÉ LE</label>
                                <p class="mb-0">
                                    <i class="fas fa-calendar-plus text-muted mr-1"></i>
                                    {{ $product->created_at->format('d/m/Y à H:i') }}
                                </p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-muted small">DERNIÈRE MODIFICATION</label>
                                <p class="mb-0">
                                    <i class="fas fa-edit text-muted mr-1"></i>
                                    {{ $product->updated_at->format('d/m/Y à H:i') }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stock Status Card -->
            <div class="card shadow-sm mt-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-chart-bar mr-2"></i>État du Stock
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <div class="progress-group">
                                <span class="float-left">
                                    <strong>{{ $product->quantity }}</strong> unités en stock
                                </span>
                                <span class="float-right">
                                    @if($product->quantity > 10)
                                        <span class="badge badge-success">Stock normal</span>
                                    @elseif($product->quantity > 0)
                                        <span class="badge badge-warning">Stock faible</span>
                                    @else
                                        <span class="badge badge-danger">Rupture de stock</span>
                                    @endif
                                </span>
                            </div>
                            <div class="progress progress-sm">
                                <div class="progress-bar
                                    @if($product->quantity > 10) bg-success
                                    @elseif($product->quantity > 0) bg-warning
                                    @else bg-danger
                                    @endif"
                                    style="width: {{ $product->quantity > 0 ? min(100, ($product->quantity / 20) * 100) : 0 }}%">
                                </div>
                            </div>
                            <small class="text-muted">
                                Seuil recommandé: 10 unités minimum
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions Sidebar -->
        <div class="col-lg-4">
            <!-- Quick Actions -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-bolt mr-2"></i>Actions Rapides
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="{{ route('products.edit', $product) }}" class="btn btn-warning btn-block">
                            <i class="fas fa-edit mr-2"></i>Modifier le Produit
                        </a>

                        <button class="btn btn-info btn-block" onclick="window.print()">
                            <i class="fas fa-print mr-2"></i>Imprimer
                        </button>

                        <a href="{{ route('products.create') }}" class="btn btn-success btn-block">
                            <i class="fas fa-plus mr-2"></i>Créer un Nouveau Produit
                        </a>
                    </div>
                </div>
            </div>

            <!-- Danger Zone -->
            <div class="card shadow-sm mt-4 border-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-exclamation-triangle mr-2"></i>Zone de Danger
                    </h5>
                </div>
                <div class="card-body">
                    <p class="text-muted small mb-3">
                        Cette action est irréversible. Assurez-vous de vouloir supprimer ce produit.
                    </p>
                    <form method="POST" action="{{ route('products.destroy', $product) }}" class="d-inline">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger btn-block"
                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer définitivement ce produit ? Cette action est irréversible.')">
                            <i class="fas fa-trash mr-2"></i>Supprimer le Produit
                        </button>
                    </form>
                </div>
            </div>

            <!-- Product Statistics -->
            <div class="card shadow-sm mt-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-chart-pie mr-2"></i>Statistiques
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6">
                            <div class="info-box">
                                <span class="info-box-icon bg-primary">
                                    <i class="fas fa-hashtag"></i>
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">ID</span>
                                    <span class="info-box-number">{{ $product->id }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="info-box">
                                <span class="info-box-icon bg-success">
                                    <i class="fas fa-euro-sign"></i>
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Valeur</span>
                                    <span class="info-box-number">{{ number_format($product->unit_price * $product->quantity, 2) }} €</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection