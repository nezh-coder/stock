@extends('adminlte::page')

@section('title','Règlements Clients')
@section('css')
<link rel="stylesheet" href="{{ asset('css/select2.min.css') }}">
<link rel="stylesheet" href="{{ asset('css/jquery.dataTables.min.css') }}">
@endsection
@section('content')
<div class="container-fluid">
   <h2 class="mb-4">Etat des règlements clients</h2>

{{-- 🔎 FILTRES --}}
<form method="GET" class="row mb-4">

    <div class="col-md-3">
        <label>Date début</label>
        <input type="date" name="date_debut" class="form-control">
    </div>

    <div class="col-md-3">
        <label>Date fin</label>
        <input type="date" name="date_fin" class="form-control">
    </div>

    <div class="col-md-3">
        <label>Client</label>
        <select name="client_id" class="form-control select2">
            <option value="">Tous</option>
            @foreach($clients as $c)
                <option value="{{ $c->id }}">{{ $c->name }}</option>
            @endforeach
        </select>
    </div>

    <div class="col-md-3 mt-4">
        <button class="btn btn-primary">Filtrer</button>
        <a href="{{ route('paiements.export.pdf', request()->all()) }}" 
   class="btn btn-danger">
    PDF
</a>
    </div>

</form>

{{-- 📊 CARDS DASHBOARD --}}
<div class="row mb-4">

    <div class="col-md-3">
        <div class="small-box bg-info">
            <div class="inner">
                <h3>{{ $totalReglements }}</h3>
                <p>Total règlements</p>
            </div>
            <div class="icon">
                <i class="fas fa-file-invoice"></i>
            </div>
        </div>
    </div>
 <div class="col-md-3">
        <div class="small-box bg-danger">
            <div class="inner">
                <h3>{{ number_format($totalReste,2) }} DH</h3>
                <p>Reste à payer</p>
            </div>
            <div class="icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
        </div>
    </div>

</div>
    <a href="{{ route('paiements.create') }}" class="btn btn-primary mb-3">Créer un règlement</a>

    <table class="table table-bordered" id="reglementTable">
        <thead>
            <tr>
                <th>N°</th>
                <th>Client</th>
                <th>Montant</th>
                <th>Facture(s) payée(s)</th>
                <th>Date</th>
                <th>Mode</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            @foreach($reglements as $key => $r)
            <tr>
                <td>{{ $key + 1 }}</td>
                <td>{{ $r->client->name }}</td>
                <td>{{ number_format($r->montant,2) }} </td>
                <td>
                @foreach($r->factures as $key => $facture)   
                    {{ ucfirst($facture->numero_facture).'- ' }}
                @endforeach
                </td>
                <td>{{ \Carbon\Carbon::parse($r->date_reglement)->format('d/m/Y') }}</td>
                <td>{{ $r->mode_paiement }}</td>
                <td class="d-flex">
                    <a href="{{ route('paiements.edit',$r->id) }}" class="btn btn-sm btn-warning mr-1"><i class="fas fa-edit"></i></a>
                    <a href="{{ route('paiements.show',$r->id) }}" class="btn btn-sm btn-info mr-1"><i class="fas fa-eye"></i></a>
                   <form action="{{ route('paiements.destroy',$r->id) }}" method="POST" onsubmit="return confirm('Supprimer ?')">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection