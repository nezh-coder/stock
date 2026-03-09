@extends('adminlte::page')
@php
use Illuminate\Support\Str;
@endphp
@section('title', 'Clients')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $clients->count() }}</h3>
                    <p>Total Clients</p>
                </div>
                <div class="icon">
                    <i class="fas fa-users"></i>
                </div>
                <a href="#clients-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $clients->where('credit', '>', 0)->count() }}</h3>
                    <p>Clients Créditeurs</p>
                </div>
                <div class="icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <a href="#clients-table" class="small-box-footer">Voir les crédits <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $clients->where('credit', '>', 1000)->count() }}</h3>
                    <p>Crédits Élevés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <a href="#clients-table" class="small-box-footer">Voir les alertes <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-primary">
                <div class="inner">
                    <h3>{{ $clients->where('credit', 0)->count() }}</h3>
                    <p>Clients Soldés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#clients-table" class="small-box-footer">Voir les comptes <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('clients.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par nom..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="credit_status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="no_credit" {{ request('credit_status') == 'no_credit' ? 'selected' : '' }}>Aucun crédit</option>
                                <option value="has_credit" {{ request('credit_status') == 'has_credit' ? 'selected' : '' }}>Avec crédit</option>
                                <option value="high_credit" {{ request('credit_status') == 'high_credit' ? 'selected' : '' }}>Crédit élevé (>1000€)</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary mr-2">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                        <a href="{{ route('clients.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Clients Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="clients-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-users mr-2"></i>Liste des Clients
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('clients.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Client
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="mr-1"></i>N°</th>
                                <th><i class="fas fa-user mr-1"></i>Nom</th>
                                <th><i class="fas fa-phone mr-1"></i>Téléphone</th>
                                <th><i class="fas fa-envelope mr-1"></i>Email</th>
                                <th><i class="fas fa-id-card mr-1"></i>ICE</th>
                                <th><i class="fas fa-map-marker-alt mr-1"></i>Adresse</th>
                                <th><i class="fas fa-euro-sign mr-1"></i>Crédit</th>
                               <!--- <th><i class="fas fa-calendar mr-1"></i>Créé le</th>
                               --> <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($clients as $k=>$client)
                                <tr>
                                    <td>{{ $k+1 }}</td>
                                    <td>
                                        <strong>{{ $client->name }}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-phone text-muted mr-1"></i>{{ $client->tel }}
                                    </td>
                                    <td>
                                        @if($client->email)
                                            <a href="mailto:{{ $client->email }}" class="text-primary">
                                                <i class="fas fa-envelope mr-1"></i>{{ $client->email }}
                                            </a>
                                        @else
                                            <span class="text-muted">-</span>
                                        @endif
                                    </td>
                                    <td>
                                        <span class="badge badge-secondary">{{ $client->ice }}</span>
                                    </td>
                                    <td>
                                        <span title="{{ $client->adresse }}">
                                            <i class="fas fa-map-marker-alt text-muted mr-1"></i>{{ Str::limit($client->adresse, 30) }}
                                        </span>
                                    </td>
                                    <td>
                                        @if($client->credit > 1000)
                                            <span class="badge badge-danger">{{ number_format($client->credit, 2) }} €</span>
                                        @elseif($client->credit > 0)
                                            <span class="badge badge-warning">{{ number_format($client->credit, 2) }} €</span>
                                        @else
                                            <span class="badge badge-success">{{ number_format($client->credit, 2) }} €</span>
                                        @endif
                                    </td>
                                   <!-- <td>{{ $client->created_at->format('d/m/Y') }}</td>
                                   --> <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('clients.show', $client) }}" class="btn btn-info" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="{{ route('clients.edit', $client) }}" class="btn btn-warning" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="POST" action="{{ route('clients.destroy', $client) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="9" class="text-center py-4">
                                        <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun client trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun client dans le système.</p>
                                        <a href="{{ route('clients.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Ajouter le premier client
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($clients->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $clients->firstItem() }} à {{ $clients->lastItem() }} sur {{ $clients->total() }} clients
                                    </small>
                                </div>
                                <div>
                                    {{ $clients->links() }}
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