@extends('adminlte::page')

@section('title', 'Bons de Commande')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $bonCommandes->count() }}</h3>
                    <p>Total Bons de Commande</p>
                </div>
                <div class="icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <a href="#bon-commandes-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $bonCommandes->where('status', 'recu')->count() }}</h3>
                    <p>Bons Validés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#bon-commandes-table" class="small-box-footer">Voir les validés <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $bonCommandes->where('status', 'en_cours')->count() }}</h3>
                    <p>En Cours</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#bon-commandes-table" class="small-box-footer">Voir en cours <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $bonCommandes->where('status', 'annule')->count() }}</h3>
                    <p>Bons Annulés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="#bon-commandes-table" class="small-box-footer">Voir les annulés <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('bon-commandes.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="en_cours" {{ request('status') == 'en_cours' ? 'selected' : '' }}>En cours</option>
                                <option value="recu" {{ request('status') == 'recu' ? 'selected' : '' }}>Validé</option>
                                <option value="annule" {{ request('status') == 'annule' ? 'selected' : '' }}>Annulé</option>
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
                        <a href="{{ route('bon-commandes.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bon Commandes Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="bon-commandes-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-shopping-cart mr-2"></i>Liste des Bons de Commande
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('bon-commandes.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Bon de Commande
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="fas fa-hashtag mr-1"></i>Numéro</th>
                                <th><i class="fas fa-building mr-1"></i>Fournisseur</th>
                                <th><i class="fas fa-calendar mr-1"></i>Date</th>
                                <th><i class="fas fa-money-bill-wave mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($bonCommandes as $bonCommande)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $bonCommande->numero_bon_commande }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $bonCommande->client->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar text-muted mr-1"></i>{{ \Carbon\Carbon::parse($bonCommande->date_commande)->format('d/m/Y') }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($bonCommande->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($bonCommande->status == 'recu')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Validé
                                            </span>
                                        @elseif($bonCommande->status == 'en_cours')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En cours
                                            </span>
                                        @elseif($bonCommande->status == 'annule')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulé
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $bonCommande->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('bon-commandes.show', $bonCommande) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="{{ route('bon-commandes.edit', $bonCommande) }}" class="btn btn-warning mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            @if(!in_array($bonCommande->id, $transferredBonCommandeIds))
                                            <form method="POST" action="{{ route('bon-commandes.transfer', $bonCommande) }}" class="d-inline">
                                                @csrf
                                                <button type="submit" class="btn btn-success mr-1" title="Transférer" onclick="return confirm('Transférer ce bon de commande en bon de livraison ?')">
                                                    <i class="fas fa-arrow-right"></i>
                                                </button>
                                            </form>
                                            @endif
                                            <form method="POST" action="{{ route('bon-commandes.destroy', $bonCommande) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce bon de commande ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="text-center py-4">
                                        <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun bon de commande trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun bon de commande dans le système.</p>
                                        <a href="{{ route('bon-commandes.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer le premier bon de commande
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($bonCommandes->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $bonCommandes->firstItem() }} à {{ $bonCommandes->lastItem() }} sur {{ $bonCommandes->total() }} bons de commande
                                    </small>
                                </div>
                                <div>
                                    {{ $bonCommandes->links() }}
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