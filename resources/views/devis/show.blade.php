@extends('adminlte::page')

@section('title', 'Devis N°'.$devi->numero_devis)

@section('content_header')
<div class="d-flex justify-content-between align-items-center">
    <h1>Devis N°{{ $devi->numero_devis }}</h1>
    <div>
        <a href="{{ route('devis.index') }}" class="btn btn-secondary btn-sm">
            <i class="fas fa-arrow-left"></i> Retour
        </a>
        <a href="{{ route('devis.a5', $devi) }}" target="_blank" class="btn btn-info btn-sm">
            <i class="fas fa-print"></i> Imprimer
        </a>
        <a href="{{ route('devis.pdf', $devi) }}" target="_blank" class="btn btn-danger btn-sm">
            <i class="fas fa-file-pdf"></i> Export PDF
        </a>
    </div>
</div>
@endsection

@section('content')
<div class="container-fluid">

    {{-- HEADER --}}
    <div class="row mb-4">
        <div class="col-12">
            <h3 class="mb-0">Détails du devis</h3>
            <p class="text-muted">Informations générales</p>
        </div>
    </div>

    {{-- STATS --}}
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Numéro</div>
                    <div class="h5 mb-0 font-weight-bold">{{ $devi->numero_devis }}</div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Statut</div>
                    @switch($devi->status)
                        @case('accepte') <span class="badge badge-success">Accepté</span> @break
                        @case('refuse') <span class="badge badge-danger">Refusé</span> @break
                        @case('envoye') <span class="badge badge-info">Envoyé</span> @break
                        @default <span class="badge badge-warning">Brouillon</span>
                    @endswitch
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Date</div>
                    <div class="h5 mb-0 font-weight-bold">
                        {{ optional($devi->date_devis)->format('d/m/Y') }}
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total TTC</div>
                    <div class="h5 mb-0 font-weight-bold">
                        {{ number_format($devi->total_ttc, 2) }} DH
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- INFO + PRODUITS --}}
    <div class="row">
        <div class="col-lg-8">

            <div class="card shadow mb-4">
                <div class="card-header">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-info-circle"></i> Informations du devis
                    </h6>
                </div>
                <div class="card-body">
                    <strong>Client :</strong> {{ $devi->client->name ?? 'N/A' }} <br>
                    <strong>Créé le :</strong> {{ $devi->created_at->format('d/m/Y H:i') }}
                </div>
            </div>

            <div class="card shadow">
                <div class="card-header">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-list"></i> Articles du devis
                    </h6>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Désignation</th>
                                <th class="text-center">Qté</th>
                                <th class="text-right">P.U HT</th>
                                <th class="text-right">Total HT</th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($devi->products as $product)
                            <tr>
                                <td>
                                    <strong>{{ $product->name }}</strong><br>
                                    <small class="text-muted">
                                        {{ \Illuminate\Support\Str::limit($product->description, 50) }}
                                    </small>
                                </td>
                                <td class="text-center">{{ $product->pivot->quantity }}</td>
                                <td class="text-right">{{ number_format($product->pivot->unit_price,2) }} DH</td>
                                <td class="text-right">{{ number_format($product->pivot->total,2) }} DH</td>
                            </tr>
                        @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-right">Total HT</th>
                                <th class="text-right">{{ number_format($devi->total_ht,2) }} DH</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="text-right">TVA {{ $devi->tva }}%</th>
                                <th class="text-right">{{ number_format($devi->total_ttc - $devi->total_ht,2) }} DH</th>
                            </tr>
                            <tr>
                                <th colspan="3" class="text-right">Total TTC</th>
                                <th class="text-right text-success">{{ number_format($devi->total_ttc,2) }} DH</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>

        {{-- SIDEBAR --}}
        <div class="col-lg-4">
            <div class="card shadow">
                <div class="card-header">
                    <h6 class="m-0 font-weight-bold text-primary">Actions</h6>
                </div>
                <div class="card-body">
                    <a href="{{ route('devis.edit', $devi) }}" class="btn btn-warning btn-block mb-2">
                        Modifier
                    </a>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection

@section('css')
<style>
@media print {
    body * { visibility: hidden; }
    .container-fluid, .container-fluid * { visibility: visible; }
    .btn, .col-lg-4 { display:none !important; }
}
</style>
@endsection
