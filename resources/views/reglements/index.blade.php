@extends('adminlte::page')

@section('title', 'Etat des règlements')
@section('css')
<link rel="stylesheet" href="{{ asset('css/select2.min.css') }}">
<link rel="stylesheet" href="{{ asset('css/jquery.dataTables.min.css') }}">
@endsection
@section('content')

<div class="container-fluid">

<h2 class="mb-4">Etat des règlements fournisseurs</h2>

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
        <label>Fournisseur</label>
        <select name="fournisseur_id" class="form-control select2">
            <option value="">Tous</option>
            @foreach($fournisseurs as $f)
                <option value="{{ $f->id }}">{{ $f->name }}</option>
            @endforeach
        </select>
    </div>

    <div class="col-md-3 mt-4">
        <button class="btn btn-primary">Filtrer</button>
        <a href="{{ route('reglements.export.pdf', request()->all()) }}" 
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
<!----
    <div class="col-md-3">
        <div class="small-box bg-success">
            <div class="inner">
                <h3>{{ number_format($totalMontant,2) }} DH</h3>
                <p>Montant total réglé</p>
            </div>
            <div class="icon">
                <i class="fas fa-money-bill-wave"></i>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3>{{ number_format($totalPaye,2) }} DH</h3>
                <p>Total payé (bons)</p>
            </div>
            <div class="icon">
                <i class="fas fa-check-circle"></i>
            </div>
        </div>
    </div>
-->
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
<!---<div class="row mb-4">

    <div class="col-md-3">
        <div class="small-box bg-secondary">
            <div class="inner">
                <h3>{{ $fournisseursCount }}</h3>
                <p>Fournisseurs concernés</p>
            </div>
            <div class="icon">
                <i class="fas fa-users"></i>
            </div>
        </div>
    </div>

</div>-->

{{-- 📋 TABLEAU --}}
<div class="card">
    <div class="card-body table-responsive">

        <table id="reglementTable" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>N°</th>
                    <th>Fournisseur</th>
                    <th>Montant</th>
                     <th>BR payés</th>
                    <th>Date</th>
                    <th>Mode</th>
                     <th>Status</th>
                    <th>Saisi par</th>
                     <th>Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach($reglements as $key=>$r)
                <tr>
                    <td>{{ $key + 1 }}</td>
                    <td>{{ $r->fournisseur->name }}</td>
                    <td><strong>{{ number_format($r->montant,2) }}</strong></td>
                    <td>
                @foreach($r->achats as $key => $br)
                    {{ ucfirst($br->numero_achat).'-' }}
                @endforeach
            </td>
                    <td>{{ \Carbon\Carbon::parse($r->date_reglement)->format('d/m/Y') }}</td>
                    <td>{{ $r->mode_paiement }}</td>
                    <td>
                        {!! $r->status == 'annule'
                            ? '<span class="badge badge-danger">
                                    <i class="fas fa-clock mr-1"></i> Annulé
                            </span>'
                            : '<span class="badge badge-success">
                                    <i class="fas fa-check mr-1"></i> Validé
                            </span>'
                        !!}
                    </td>
                    <td>{{ ucfirst($r->user->name); }}</td>
                    <td class="d-flex">

    {{-- Détails --}}
    <a href="{{ route('reglements.show', $r->id) }}" 
       class="btn btn-sm btn-info mr-1">
        <i class="fas fa-eye"></i>
    </a>

    {{-- Modifier --}}
    <a href="{{ route('reglements.edit', $r->id) }}" 
       class="btn btn-sm btn-warning mr-1">
        <i class="fas fa-edit"></i>
    </a>

    {{-- Supprimer --}}
    <form action="{{ route('reglements.destroy', $r->id) }}" 
          method="POST"
          onsubmit="return confirm('Supprimer ce règlement ?')">
        @csrf
        @method('DELETE')
        <button class="btn btn-sm btn-danger">
            <i class="fas fa-trash"></i>
        </button>
    </form>

</td>
                </tr>
                @endforeach
            </tbody>
        </table>

    </div>
</div>

</div>

@endsection


@section('js')


<script src="{{ asset('js/select2.min.js') }}"></script>

<script src="{{ asset('js/jquery.dataTables.min.js') }}"></script>
<script>
$(document).ready(function() {
    $('#reglementTable').DataTable({
        pageLength: 10,
        ordering: true
    });
     // Select2
    $('.select2').select2({
        placeholder: "Choisir un fournisseur",
        allowClear: true,
        width: '100%'
    });
});
</script>
@endsection