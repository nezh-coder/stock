@extends('adminlte::page')

@section('title', 'Bons de Livraison')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $bonLivraisons->count() }}</h3>
                    <p>Total Bons de Livraison</p>
                </div>
                <div class="icon">
                    <i class="fas fa-truck"></i>
                </div>
                <a href="#bon-livraisons-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $bonLivraisons->where('status', 'livre')->count() }}</h3>
                    <p>Bons Livrés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#bon-livraisons-table" class="small-box-footer">Voir les livrés <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $bonLivraisons->where('status', 'en_cours')->count() }}</h3>
                    <p>En Cours</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#bon-livraisons-table" class="small-box-footer">Voir en cours <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $bonLivraisons->where('status', 'annule')->count() }}</h3>
                    <p>Bons Annulés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="#bon-livraisons-table" class="small-box-footer">Voir les annulés <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('bon-livraisons.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="en_cours" {{ request('status') == 'en_cours' ? 'selected' : '' }}>En cours</option>
                                <option value="livré" {{ request('status') == 'livre' ? 'selected' : '' }}>Livré</option>
                                <option value="annulé" {{ request('status') == 'annule' ? 'selected' : '' }}>Annulé</option>
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
                        <a href="{{ route('bon-livraisons.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bon Livraisons Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="bon-livraisons-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-truck mr-2"></i>Liste des Bons de Livraison
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('bon-livraisons.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Bon de Livraison
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
                                <th><i class="fas fa-money-bill mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($bonLivraisons as $bonLivraison)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $bonLivraison->numero_bon_livraison }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $bonLivraison->client->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar text-muted mr-1"></i>{{ $bonLivraison->date_livraison ? \Carbon\Carbon::parse($bonLivraison->date_livraison)->format('d/m/Y') : 'N/A' }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($bonLivraison->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($bonLivraison->status == 'livre')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Livré
                                            </span>
                                        @elseif($bonLivraison->status == 'en_cours')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En cours
                                            </span>
                                        @elseif($bonLivraison->status == 'annule')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulé
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $bonLivraison->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('bon-livraisons.show', $bonLivraison) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                              <a href="{{ route('bon-livraisons.pdf', $bonLivraison) }}" class="btn btn-primary  mr-1" title="Imprimer" target="_blank">
                                                <i class="fas fa-print"></i>
                                            </a>
                                            <a href="{{ route('bon-livraisons.edit', $bonLivraison) }}" class="btn btn-warning mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            @if(!in_array($bonLivraison->id, $transferredBonLivraisonIds))
                                            <form method="POST" action="{{ route('bon-livraisons.transfer', $bonLivraison) }}" class="d-inline">
                                                @csrf
                                                <button type="submit" class="btn btn-success mr-1" title="Transférer" onclick="return confirm('Transférer ce bon de livraison en facture ?')">
                                                    <i class="fas fa-arrow-right"></i>
                                                </button>
                                            </form>
                                            @endif
                                            <form method="POST" action="{{ route('bon-livraisons.destroy', $bonLivraison) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce bon de livraison ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="text-center py-4">
                                        <i class="fas fa-truck fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun bon de livraison trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun bon de livraison dans le système.</p>
                                        <a href="{{ route('bon-livraisons.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer le premier bon de livraison
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($bonLivraisons->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $bonLivraisons->firstItem() }} à {{ $bonLivraisons->lastItem() }} sur {{ $bonLivraisons->total() }} bons de livraison
                                    </small>
                                </div>
                                <div>
                                    {{ $bonLivraisons->links() }}
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