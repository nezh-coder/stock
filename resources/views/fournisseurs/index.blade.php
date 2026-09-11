@extends('adminlte::page')
@php
use Illuminate\Support\Str;
@endphp
@section('title', 'Fournisseurs')

@section('content')
@if (session('success'))
    <div class="alert alert-success alert-dismissible">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        {{ session('success') }}
    </div>
@endif

<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $fournisseurs->count() }}</h3>
                    <p>Total Fournisseurs</p>
                </div>
                <div class="icon">
                    <i class="fas fa-truck"></i>
                </div>
                <a href="#fournisseurs-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $fournisseurs->where('credit', '>', 0)->count() }}</h3>
                    <p>Fournisseurs Créditeurs</p>
                </div>
                <div class="icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <a href="#fournisseurs-table" class="small-box-footer">Voir les crédits <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $fournisseurs->where('credit', '>', 1000)->count() }}</h3>
                    <p>Crédits Élevés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <a href="#fournisseurs-table" class="small-box-footer">Voir les alertes <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-primary">
                <div class="inner">
                    <h3>{{ $fournisseurs->where('credit', 0)->count() }}</h3>
                    <p>Fournisseurs Soldés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#fournisseurs-table" class="small-box-footer">Voir les comptes <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="row mb-3">
        <div class="col-12">
            <div class="card card-outline card-primary">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-search mr-2"></i>Recherche et Filtres
                    </h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <form method="GET" action="{{ route('fournisseurs.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par nom..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="credit_status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="no_credit" {{ request('credit_status') == 'no_credit' ? 'selected' : '' }}>Aucun crédit</option>
                                <option value="has_credit" {{ request('credit_status') == 'has_credit' ? 'selected' : '' }}>Avec crédit</option>
                                <option value="high_credit" {{ request('credit_status') == 'high_credit' ? 'selected' : '' }}>Crédit élevé (>1000DH)</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary mr-2">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                        <a href="{{ route('fournisseurs.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
  <div class="card card-outline card-success mb-3">
        <div class="card-header">
            <h3 class="card-title"><i class="fas fa-file-csv mr-2"></i>Importer les fournisseurs depuis un CSV</h3>
        </div>
        <div class="card-body">
            <form action="{{ route('fournisseurs.import') }}" method="POST" enctype="multipart/form-data" class="form-inline">
                @csrf
                <input type="file" name="file" class="form-control mr-2" accept=".csv,.txt" required>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-upload mr-1"></i>Importer le CSV
                </button>
            </form>
            <small class="form-text text-muted mt-2">
                Colonnes attendues : Nom, Description, Catégorie, Unité, Prix unitaire, Qté en stock et Qté seuil.
                Les catégories et unités absentes seront créées automatiquement.
            </small>
        </div>
    </div>
    <!-- Fournisseurs Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="fournisseurs-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-truck mr-2"></i>Liste des Fournisseurs
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('fournisseurs.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Fournisseur
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="mr-1"></i>N°</th>
                                <th><i class="fas fa-building mr-1"></i>Nom</th>
                                <th><i class="fas fa-phone mr-1"></i>Téléphone</th>
                                <th><i class="fas fa-envelope mr-1"></i>Email</th>
                                <th><i class="fas fa-id-card mr-1"></i>ICE</th>
                                <th><i class="fas fa-map-marker-alt mr-1"></i>Adresse</th>
                                <th><i class="fas fa-money-bill-wave mr-1"></i>Crédit</th>
                               <!--  <th><i class="fas fa-calendar mr-1"></i>Créé le</th>
                             ---> <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($fournisseurs as $k=>$fournisseur)
                                <tr>
                                    <td>{{ $k+1 }}</td>
                                    <td>
                                        <strong>{{ $fournisseur->name }}</strong>
                                    </td>
                                    <td>
                                        {{ $fournisseur->tel }}
                                    </td>
                                    <td>
                                        @if($fournisseur->email)
                                            <a href="mailto:{{ $fournisseur->email }}" class="text-primary">
                                                {{ $fournisseur->email }}
                                            </a>
                                        @else
                                            <span class="text-muted">-</span>
                                        @endif
                                    </td>
                                    <td>
                                        <span class="badge badge-secondary">{{ $fournisseur->ice }}</span>
                                    </td>
                                    <td>
                                        <span title="{{ $fournisseur->adresse }}">
                                           {{ Str::limit($fournisseur->adresse, 30) }}
                                        </span>
                                    </td>
                                    <td>
                                        @if($fournisseur->credit > 1000)
                                            <span class="badge badge-danger">{{ number_format($fournisseur->credit, 2) }} DH</span>
                                        @elseif($fournisseur->credit > 0)
                                            <span class="badge badge-warning">{{ number_format($fournisseur->credit, 2) }} DH</span>
                                        @else
                                            <span class="badge badge-success">{{ number_format($fournisseur->credit, 2) }} DH</span>
                                        @endif
                                    </td>
                                  <!--   <td>{{ $fournisseur->created_at->format('d/m/Y') }}</td>
                                  --> <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('fournisseurs.show', $fournisseur) }}" class="btn btn-info" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="{{ route('fournisseurs.edit', $fournisseur) }}" class="btn btn-warning" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="POST" action="{{ route('fournisseurs.destroy', $fournisseur) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce fournisseur ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="9" class="text-center py-4">
                                        <i class="fas fa-truck fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun fournisseur trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun fournisseur dans le système.</p>
                                        <a href="{{ route('fournisseurs.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Ajouter le premier fournisseur
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($fournisseurs->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $fournisseurs->firstItem() }} à {{ $fournisseurs->lastItem() }} sur {{ $fournisseurs->total() }} fournisseurs
                                    </small>
                                </div>
                                <div>
                                    {{ $fournisseurs->links() }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection