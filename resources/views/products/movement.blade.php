@extends('adminlte::page')

@section('title', 'Mouvement du Produit')

@section('content')
<div class="container-fluid">

    <div class="row mb-4">
        <div class="col-12">
            <h1 class="h3 mb-0 text-gray-800">
                <i class="fas fa-exchange-alt mr-2 text-primary"></i>
                Mouvement du Produit : <span class="text-dark">{{ $product->name }}</span>
            </h1>
        </div>
    </div>

    {{-- Filtre --}}
    <div class="card mb-4">
        <div class="card-header">
            <form method="GET" action="">
                <div class="row">
                    <div class="col-md-4">
                        <label>Date début</label>
                        <input type="date" name="date_deb" class="form-control" value="{{ request('date_deb') }}">
                    </div>
                    <div class="col-md-4">
                        <label>Date fin</label>
                        <input type="date" name="date_fin" class="form-control" value="{{ request('date_fin') }}">
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Filtrer</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {{-- DEVIS ACCEPTÉ --}}
    <div class="card mb-2">
        <div class="card-header">
            <button class="btn btn-link text-left" type="button" data-toggle="collapse" data-target="#devisTable" aria-expanded="true">
                <i class="fas fa-plus mr-2"></i>Devis Accepté
            </button>
        </div>
        <div id="devisTable" class="collapse">
            <div class="card-body p-0">
                <table class="table table-bordered table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Numéro</th>
                            <th>Quantité</th>
                            <th>Prix</th>
                            <th>Client</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($movements->where('type', 'Devis Accepté') as $mvt)
                            <tr>
                                <td>{{ \Carbon\Carbon::parse($mvt->date)->format('d/m/Y') }}</td>
                                <td>{{ $mvt->numero }}</td>
                                <td>{{ $mvt->quantity }}</td>
                                <td>{{ $mvt->price }}</td>
                                <td>{{ $mvt->partner }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted">Aucun devis accepté pour cette période.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    {{-- BON DE RÉCEPTION --}}
    <div class="card mb-2">
        <div class="card-header">
            <button class="btn btn-link text-left" type="button" data-toggle="collapse" data-target="#brTable" aria-expanded="false">
                <i class="fas fa-plus mr-2"></i>Achats
            </button>
        </div>
        <div id="brTable" class="collapse">
            <div class="card-body p-0">
                <table class="table table-bordered table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Numéro</th>
                            <th>Quantité</th>
                            <th>Prix</th>
                            <th>Fournisseur</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($movements->where('type', 'Bon de Réception') as $mvt)
                            <tr>
                                <td>{{ \Carbon\Carbon::parse($mvt->date)->format('d/m/Y') }}</td>
                                <td>{{ $mvt->numero }}</td>
                                <td>{{ $mvt->quantity }}</td>
                                <td>{{ $mvt->price }}</td>
                                <td>{{ $mvt->partner }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted">Aucun bon de réception pour cette période.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    {{-- BON DE LIVRAISON --}}
    <div class="card mb-2">
        <div class="card-header">
            <button class="btn btn-link text-left" type="button" data-toggle="collapse" data-target="#blTable" aria-expanded="false">
                <i class="fas fa-plus mr-2"></i>Ventes
            </button>
        </div>
        <div id="blTable" class="collapse">
            <div class="card-body p-0">
                <table class="table table-bordered table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Numéro</th>
                            <th>Quantité</th>
                            <th>Prix</th>
                            <th>Client</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($movements->where('type', 'Bon de Livraison') as $mvt)
                            <tr>
                                <td>{{ \Carbon\Carbon::parse($mvt->date)->format('d/m/Y') }}</td>
                                <td>{{ $mvt->numero }}</td>
                                <td>{{ $mvt->quantity }}</td>
                                <td>{{ $mvt->price }}</td>
                                <td>{{ $mvt->partner }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted">Aucun bon de livraison pour cette période.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

{{-- JS pour changer + / − --}}
@section('js')
<script>
    $(document).ready(function(){
        $('.card-header button').click(function(){
            var icon = $(this).find('i');
            if(icon.hasClass('fa-plus')){
                icon.removeClass('fa-plus').addClass('fa-minus');
            } else {
                icon.removeClass('fa-minus').addClass('fa-plus');
            }
        });
    });
</script>
@endsection

@endsection