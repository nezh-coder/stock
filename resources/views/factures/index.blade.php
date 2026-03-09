@extends('adminlte::page')

@section('title', 'Factures')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
       
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $factures->where('status', 'payee')->count() }}</h3>
                    <p>Factures Payées</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#factures-table" class="small-box-footer">Voir les payées <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $factures->where('status', 'partiellement_paye')->count() }}</h3>
                    <p>Partiellement Payées</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#factures-table" class="small-box-footer">Voir partiellement payées <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
         <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $factures->where('status', 'non_payee')->count() }}</h3>
                    <p>En Attente</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#factures-table" class="small-box-footer">Voir en attente <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $factures->where('status', 'annulee')->count() }}</h3>
                    <p>Factures Annulées</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="#factures-table" class="small-box-footer">Voir les annulées <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('factures.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="annulee" {{ request('status') == 'annulee' ? 'selected' : '' }}>Annulée</option>
                               
                                <option value="non_payee" {{ request('status') == 'non_payee' ? 'selected' : '' }}>En attente</option>
                             <option value="partiellement_paye" {{ request('status') == 'partiellement_paye' ? 'selected' : '' }}>Partiellement Payée</option>
                             <option value="payee" {{ request('status') == 'payee' ? 'selected' : '' }}>Payée</option>
                            </select>
                        </div>
                        <div class="form-group mr-3">
                            <input type="date" name="date_from" class="form-control" placeholder="Date début" value="{{ request('date_from') }}">
                        </div>
                        <div class="form-group mr-3">
                            <input type="date" name="date_to" class="form-control" placeholder="Date fin" value="{{ request('date_to') }}">
                        </div>
                        <button type="submit" class="btn btn-primary mr-2">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                        <a href="{{ route('factures.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Factures Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="factures-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-file-invoice-dollar mr-2"></i>Liste des Factures
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('factures.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouvelle Facture
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="fas fa-hashtag mr-1"></i>Numéro</th>
                                <th><i class="fas fa-user mr-1"></i>Client</th>
                                <th><i class="fas fa-calendar mr-1"></i>Date</th>
                                <th><i class="fas fa-calendar-check mr-1"></i>Échéance</th>
                                <th><i class="fas fa-money-bill-wave mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($factures as $facture)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $facture->numero_facture }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $facture->client->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar text-muted mr-1"></i>{{ $facture->date_facture ? \Carbon\Carbon::parse($facture->date_facture)->format('d/m/Y') : 'N/A' }}
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar-check text-muted mr-1"></i>{{ $facture->date_echeance ? \Carbon\Carbon::parse($facture->date_echeance)->format('d/m/Y') : 'N/A' }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($facture->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($facture->status == 'payee')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Payée
                                            </span>
                                        @elseif($facture->status == 'non_payee')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En attente
                                            </span>
                                        @elseif($facture->status == 'annulee')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulée
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $facture->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('factures.show', $facture) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                             <a href="{{ route('factures.pdf', $facture) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-print"></i>
                                            </a>
                                            <a href="{{ route('factures.edit', $facture) }}" class="btn btn-warning mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="POST" action="{{ route('factures.destroy', $facture) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette facture ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8" class="text-center py-4">
                                        <i class="fas fa-file-invoice-dollar fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucune facture trouvée</h5>
                                        <p class="text-muted">Il n'y a actuellement aucune facture dans le système.</p>
                                        <a href="{{ route('factures.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer la première facture
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($factures->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $factures->firstItem() }} à {{ $factures->lastItem() }} sur {{ $factures->total() }} factures
                                    </small>
                                </div>
                                <div>
                                    {{ $factures->links() }}
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