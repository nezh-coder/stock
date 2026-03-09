@extends('adminlte::page')')

@section('title', 'Avoirs')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $avoirs->count() }}</h3>
                    <p>Total Avoirs</p>
                </div>
                <div class="icon">
                    <i class="fas fa-undo"></i>
                </div>
                <a href="#avoirs-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $avoirs->where('status', 'valide')->count() }}</h3>
                    <p>Avoirs Validés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#avoirs-table" class="small-box-footer">Voir les validés <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $avoirs->where('status', 'en_cours')->count() }}</h3>
                    <p>En Cours</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#avoirs-table" class="small-box-footer">Voir en cours <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $avoirs->where('status', 'annule')->count() }}</h3>
                    <p>Avoirs Annulés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="#avoirs-table" class="small-box-footer">Voir les annulés <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('avoirs.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="en_cours" {{ request('status') == 'en_cours' ? 'selected' : '' }}>En cours</option>
                                <option value="valide" {{ request('status') == 'valide' ? 'selected' : '' }}>Validé</option>
                                <option value="annule" {{ request('status') == 'annule' ? 'selected' : '' }}>Annulé</option>
                            </select>
                        </div>
                        <div class="form-group mr-3">
                            <select name="source_type" class="form-control">
                                <option value="">Toutes les sources</option>
                                <option value="bon_livraison" {{ request('source_type') == 'bon_livraison' ? 'selected' : '' }}>Bon de Livraison</option>
                                <option value="facture" {{ request('source_type') == 'facture' ? 'selected' : '' }}>Facture</option>
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
                        <a href="{{ route('avoirs.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Avoirs Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="avoirs-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-undo mr-2"></i>Liste des Avoirs
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('avoirs.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Créer un Avoir
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="fas fa-hashtag mr-1"></i>N°</th>
                                <th><i class="fas fa-user mr-1"></i>Client</th>
                                <th><i class="fas fa-link mr-1"></i>Source</th>
                                <th><i class="fas fa-calendar mr-1"></i>Date</th>
                                <th><i class="fas fa-billing-sign mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($avoirs as $avoir)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $avoir->numero_avoir }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $avoir->client->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        @if($avoir->bon_livraison_id)
                                            <span class="badge badge-info">
                                                <i class="fas fa-truck mr-1"></i>BL: {{ $avoir->bonLivraison->numero_bon_livraison ?? 'N/A' }}
                                            </span>
                                        @elseif($avoir->facture_id)
                                            <span class="badge badge-warning">
                                                <i class="fas fa-file-invoice-dollar mr-1"></i>F: {{ $avoir->facture->numero_facture ?? 'N/A' }}
                                            </span>
                                        @else
                                            <span class="text-muted">-</span>
                                        @endif
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar text-muted mr-1"></i>{{ \Carbon\Carbon::parse($avoir->date_avoir)->format('d/m/Y') }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($avoir->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($avoir->status == 'valide')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Validé
                                            </span>
                                        @elseif($avoir->status == 'en_cours')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En cours
                                            </span>
                                        @elseif($avoir->status == 'annule')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulé
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $avoir->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('avoirs.show', $avoir) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="{{ route('avoirs.pdf', $avoir) }}" class="btn btn-primary  mr-1" title="Télécharger PDF" target="_blank">
                                                <i class="fas fa-file-pdf"></i>
                                            </a>
                                            <a href="{{ route('avoirs.edit', $avoir) }}" class="btn btn-warning  mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="POST" action="{{ route('avoirs.destroy', $avoir) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger  mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet avoir ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8" class="text-center py-4">
                                        <i class="fas fa-undo fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun avoir trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun avoir dans le système.</p>
                                        <a href="{{ route('avoirs.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer le premier avoir
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($avoirs->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $avoirs->firstItem() }} à {{ $avoirs->lastItem() }} sur {{ $avoirs->total() }} avoirs
                                    </small>
                                </div>
                                <div>
                                    {{ $avoirs->links() }}
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