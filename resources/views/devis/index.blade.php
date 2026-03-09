@extends('adminlte::page')

@section('title', 'Devis')
@section('css')
<style>
    .small-box.border {
        transform: scale(1.03);
        transition: all 0.3s ease;
    }
</style>
@endsection
@section('content')
@php
    $activeStatus = request('status');
@endphp
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
          <div class="small-box bg-info {{ empty($activeStatus) ? 'border border-light shadow-lg' : '' }}">
                <div class="inner">
                    <h3>{{ $devis->count() }}</h3>
                    <p>Total Devis</p>
                </div>
                <div class="icon">
                    <i class="fas fa-file-invoice"></i>
                </div>
                 <a href="{{ route('devis.index', ['status' => '']) }}" class="small-box-footer">
                    Voir la liste <i class="fas fa-arrow-circle-right"></i>
                </a>
              
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success {{ $activeStatus == 'accepte' ? 'border border-dark shadow-lg' : '' }}">
                <div class="inner">
                    <h3>{{ $devis->where('status', 'accepte')->count() }}</h3>
                    <p>Devis Validés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
               <a href="{{ route('devis.index', ['status' => 'accepte']) }}" class="small-box-footer">
                    Voir les validés <i class="fas fa-arrow-circle-right"></i>
                </a>
  </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning {{ $activeStatus == 'envoye' ? 'border border-dark shadow-lg' : '' }}">
                <div class="inner">
                    <h3>{{ $devis->where('status', 'envoye')->count() }}</h3>
                    <p>En Attente</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
                <a href="{{ route('devis.index', ['status' => 'envoye']) }}" class="small-box-footer">
                    Voir en attente <i class="fas fa-arrow-circle-right"></i>
                </a>

            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger {{ $activeStatus == 'refuse' ? 'border border-dark shadow-lg' : '' }}">
                <div class="inner">
                    <h3>{{ $devis->where('status', 'refuse')->count() }}</h3>
                    <p>Devis Annulés</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="{{ route('devis.index', ['status' => 'refuse']) }}" class="small-box-footer">
                    Voir les annulés <i class="fas fa-arrow-circle-right"></i>
                </a>

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
                    <form method="GET" action="{{ route('devis.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par numéro..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                           <select name="status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="envoye" {{ request('status') == 'envoye' ? 'selected' : '' }}>En attente</option>
                                <option value="accepte" {{ request('status') == 'accepte' ? 'selected' : '' }}>Validé</option>
                                <option value="refuse" {{ request('status') == 'refuse' ? 'selected' : '' }}>Annulé</option>
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
                        <a href="{{ route('devis.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Devis Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="devis-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-file-invoice mr-2"></i>Liste des Devis
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('devis.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Devis
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
                                <th><i class="fas fa-money-bill-wave mr-1"></i>Total TTC</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                                <th><i class="fas fa-clock mr-1"></i>Créé le</th>
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($devis as $devi)
                                <tr>
                                    <td>
                                        <span class="badge badge-primary">{{ $devi->numero_devis }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $devi->client->name ?? 'N/A' }}</strong>
                                    </td>
                                    <td>
                                        {{ \Carbon\Carbon::parse($devi->date_devis)->format('d/m/Y') }}
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ number_format($devi->total_ttc, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($devi->status == 'accepte')
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Validé
                                            </span>
                                        @elseif($devi->status == 'envoye')
                                            <span class="badge badge-warning">
                                                <i class="fas fa-clock mr-1"></i>En attente
                                            </span>
                                        @elseif($devi->status == 'refuse')
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Annulé
                                            </span>
                                        @endif
                                    </td>
                                    <td>{{ $devi->created_at->format('d/m/Y H:i') }}</td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('devis.show', $devi) }}" class="btn btn-info  mr-1" title="Voir">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                             <a href="{{ route('devis.a5', $devi) }}" class="btn btn-primary  mr-1" title="Imprimer" target="_blank">
                                                <i class="fas fa-print"></i>
                                            </a>
                                            <a href="{{ route('devis.edit', $devi) }}" class="btn btn-warning  mr-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            @if(!in_array($devi->id, $transferredDevisIds))
                                            <form method="POST" action="{{ route('devis.transfer', $devi) }}" class="d-inline">
                                                @csrf
                                                <button type="submit" class="btn btn-success  mr-1" title="Transférer" onclick="return confirm('Transférer ce devis en bon de commande ?')">
                                                    <i class="fas fa-arrow-right"></i>
                                                </button>
                                            </form>
                                            @endif
                                            <form method="POST" action="{{ route('devis.destroy', $devi) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger  mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce devis ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="text-center py-4">
                                        <i class="fas fa-file-invoice fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun devis trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun devis dans le système.</p>
                                        <a href="{{ route('devis.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Créer le premier devis
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($devis->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $devis->firstItem() }} à {{ $devis->lastItem() }} sur {{ $devis->total() }} devis
                                    </small>
                                </div>
                                <div>
                                    {{ $devis->links() }}
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
@section('js')
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const hasFilters =
            new URLSearchParams(window.location.search).toString().length > 0;

        if (hasFilters) {
            const table = document.getElementById('devis-table');
            if (table) {
                table.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }
    });
</script>
@endsection

@endsection
