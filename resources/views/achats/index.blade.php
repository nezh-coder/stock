@extends('adminlte::page')

@section('title', 'Bons de Récéption')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $achats->count() }}</h3>
                    <p>Total Bons de Récéption</p>
                </div>
                <div class="icon">
                    <i class="fas fa-truck"></i>
                </div>
                <a href="#achats-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $achats->where('status', 'paye')->count() }}</h3>
                    <p>Bons Facturés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#achats-table" class="small-box-footer">Voir les BR Payés <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $achats->where('status', 'en_cours')->count() }}</h3>
                    <p>Bons non facturés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="#achats-table" class="small-box-footer">Voir BR non Payés <i class="fas fa-arrow-circle-right"></i></a>
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
                    <form method="GET" action="{{ route('achats.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="en_cours" {{ request('status') == 'en_cours' ? 'selected' : '' }}>En cours</option>
                                <option value="partiellement_paye" {{ request('status') == 'partiellement_paye' ? 'selected' : '' }}>Partiellement Payé</option>
                                <option value="paye" {{ request('status') == 'paye' ? 'selected' : '' }}>Payé</option>
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
                        <a href="{{ route('achats.index') }}" class="btn btn-secondary">
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
            <div class="card" id="achats-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-truck mr-2"></i>Liste des Bons de Récéption
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('achats.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Bon de Récéption
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="fas fa-hashtag mr-1"></i>N°BR</th>
                                <th><i class="fas fa-building mr-1"></i>Fournisseur</th>
                                <th><i class="fas fa-calendar mr-1"></i>Date livraison</th>
                                <th><i class="fas fa-money-bill-wave mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($achats as $Achat)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $Achat->numero_achat }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $Achat->fournisseur->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-calendar text-muted mr-1"></i>{{ $Achat->date_livraison ? \Carbon\Carbon::parse($Achat->date_livraison)->format('d/m/Y') : 'N/A' }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($Achat->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($Achat->status == 'en_cours')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En cours
                                            </span>
                                         @elseif($Achat->status == 'partiellement_paye')
                                             <span class="badge badge-info">
                                                 <i class="fas fa-hand-holding-usd mr-1"></i>Partiellement Payé
                                             </span>
                                        @elseif($Achat->status == 'paye')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Payé
                                            </span>
                                        @elseif($Achat->status == 'annule')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulé
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $Achat->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('achats.show', $Achat) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <a href="{{ route('achats.edit', $Achat) }}" class="btn btn-warning mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                           
                                            <form method="POST" action="{{ route('achats.destroy', $Achat) }}" class="d-inline">
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
                                        <h5 class="text-muted">Aucun bon de Récéption trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun bon d'achat dans le système.</p>
                                        <a href="{{ route('achats.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer le premier bon de livraison
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($achats->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $achats->firstItem() }} à {{ $achats->lastItem() }} sur {{ $achats->total() }} bons de livraison
                                    </small>
                                </div>
                                <div>
                                    {{ $achats->links() }}
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