@extends('adminlte::page')

@section('content')
<div class="container-fluid">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h3 mb-0 text-gray-800">{{ $fournisseur->name }}</h1>
                    <p class="text-muted mb-0">Détails du fournisseur et statistiques</p>
                </div>
                <div>
                    <a href="{{ route('fournisseurs.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                    <a href="{{ route('fournisseurs.edit', $fournisseur) }}" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Modifier
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Bons de Commande
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ $fournisseur->total_bon_commandes }}
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Commandes Reçues
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ $fournisseur->received_orders }}
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                En Cours
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ $fournisseur->pending_orders }}
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                Crédit
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ number_format($fournisseur->credit ?? 0, 2) }} DH
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-credit-card fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Financial Summary -->
    <div class="row mb-4">
        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-chart-line"></i> Résumé Financier
                    </h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <span class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                            Total Commandé
                        </span>
                        <div class="h3 mb-0 font-weight-bold text-primary">
                            {{ number_format($fournisseur->total_ordered, 2) }} DH
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-info-circle"></i> Informations Fournisseur
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <strong>Nom:</strong><br>
                            {{ $fournisseur->name }}
                        </div>
                        <div class="col-sm-6">
                            <strong>Téléphone:</strong><br>
                            {{ $fournisseur->tel ?: 'N/A' }}
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-6">
                            <strong>Email:</strong><br>
                            {{ $fournisseur->email ?: 'N/A' }}
                        </div>
                        <div class="col-sm-6">
                            <strong>ICE:</strong><br>
                            {{ $fournisseur->ice ?: 'N/A' }}
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-12">
                            <strong>Adresse:</strong><br>
                            {{ $fournisseur->adresse ?: 'N/A' }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Orders -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-history"></i> Commandes Récentes
                    </h6>
                </div>
                <div class="card-body">
                    <div class="timeline timeline-inverse">
                        @forelse($fournisseur->achats()->latest()->take(5) as $achat)
                        <div class="time-label">
                            <span class="bg-blue">{{ $achat->date_achat->format('d/m/Y') }}</span>
                        </div>
                        <div>
                            <i class="fas fa-shopping-cart bg-blue"></i>
                            <div class="timeline-item">
                                <span class="time"><i class="fas fa-clock"></i> {{ $achat->created_at->diffForHumans() }}</span>
                                <h3 class="timeline-header">
                                    <a href="#">BC {{ $achat->numero_achat }}</a> créé
                                </h3>
                                <div class="timeline-body">
                                    Total: {{ number_format($achat->total_ttc, 2) }} DH - Statut: {{ ucfirst(str_replace('_', ' ', $achat->status)) }}
                                </div>
                            </div>
                        </div>
                        @empty
                        <div class="text-center text-muted">
                            <i class="fas fa-info-circle fa-2x mb-3"></i>
                            <p>Aucune commande récente trouvée</p>
                        </div>
                        @endforelse
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Sidebar -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow">
                <div class="card-header">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-cogs"></i> Actions Rapides
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <a href="{{ route('bon-commandes.create', ['fournisseur' => $fournisseur->name]) }}" class="btn btn-primary btn-block mb-2">
                                <i class="fas fa-plus"></i> Nouvelle Commande
                            </a>
                        </div>
                        <div class="col-md-4">
                            <button type="button" class="btn btn-info btn-block mb-2" data-toggle="modal" data-target="#contactModal">
                                <i class="fas fa-phone"></i> Contacter
                            </button>
                        </div>
                        <div class="col-md-4">
                            <button type="button" class="btn btn-warning btn-block mb-2" data-toggle="modal" data-target="#creditModal">
                                <i class="fas fa-credit-card"></i> Modifier Crédit
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Danger Zone -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card border-left-danger">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-danger">
                        <i class="fas fa-exclamation-triangle"></i> Zone de Danger
                    </h6>
                </div>
                <div class="card-body">
                    <p class="text-muted">Ces actions sont irréversibles. Soyez prudent.</p>
                    <form method="POST" action="{{ route('fournisseurs.destroy', $fournisseur) }}" class="d-inline" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce fournisseur ? Cette action est irréversible.')">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Supprimer le Fournisseur
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Contact Modal -->
<div class="modal fade" id="contactModal" tabindex="-1" role="dialog" aria-labelledby="contactModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contactModalLabel">Contacter {{ $fournisseur->name }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-12">
                        <strong>Téléphone:</strong><br>
                        <a href="tel:{{ $fournisseur->tel }}">{{ $fournisseur->tel ?: 'N/A' }}</a>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-12">
                        <strong>Email:</strong><br>
                        <a href="mailto:{{ $fournisseur->email }}">{{ $fournisseur->email ?: 'N/A' }}</a>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
</div>

<!-- Credit Modal -->
<div class="modal fade" id="creditModal" tabindex="-1" role="dialog" aria-labelledby="creditModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="creditModalLabel">Modifier le Crédit</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="POST" action="{{ route('fournisseurs.update', $fournisseur) }}">
                @csrf
                @method('PUT')
                <div class="modal-body">
                    <div class="form-group">
                        <label for="credit">Crédit (DH)</label>
                        <input type="number" step="0.01" class="form-control" id="credit" name="credit" value="{{ $fournisseur->credit ?? 0 }}" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection