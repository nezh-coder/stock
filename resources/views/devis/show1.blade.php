@extends('adminlte::page')

@section('content')
<div class="container-fluid">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h3 mb-0 text-gray-800">Devis {{ $devi->numero_devis }}</h1>
                    <p class="text-muted mb-0">Détails du devis et informations</p>
                </div>
                <div>
                    <a href="{{ route('devis.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                    <button onclick="window.print()" class="btn btn-info">
                        <i class="fas fa-print"></i> Imprimer
                    </button>
                    <a href="{{ route('devis.edit', $devi) }}" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Modifier
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Status and Info Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                Numéro
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ $devi->numero_devis }}
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-hashtag fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Statut
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                @if($devi->status == 'accepte')
                                    <span class="badge badge-success">Accepté</span>
                                @elseif($devi->status == 'refuse')
                                    <span class="badge badge-danger">Refusé</span>
                                @elseif($devi->status == 'envoye')
                                    <span class="badge badge-info">Envoyé</span>
                                @else
                                    <span class="badge badge-warning">Brouillon</span>
                                @endif
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-info-circle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                Date
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ $devi->date_devis->format('d/m/Y') }}
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                Total TTC
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ number_format($devi->total_ttc, 2) }} DH
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-euro-sign fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="row">
        <!-- Devis Information -->
        <div class="col-lg-8 mb-4">
            <div class="card shadow">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-info-circle"></i> Informations du Devis
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Client:</strong><br>
                            <span class="text-primary">{{ $devi->client->name ?? 'N/A' }}</span>
                        </div>
                        <div class="col-md-6">
                            <strong>Date de création:</strong><br>
                            {{ $devi->created_at->format('d/m/Y H:i') }}
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-4">
                            <strong>Total HT:</strong><br>
                            {{ number_format($devi->total_ht, 2) }} DH
                        </div>
                        <div class="col-md-4">
                            <strong>TVA:</strong><br>
                            {{ $devi->tva }} %
                        </div>
                        <div class="col-md-4">
                            <strong>Total TTC:</strong><br>
                            <span class="text-success font-weight-bold">{{ number_format($devi->total_ttc, 2) }} DH</span>
                        </div>
                    </div>
                    @if($devi->notes)
                    <hr>
                    <div class="row">
                        <div class="col-12">
                            <strong>Notes:</strong><br>
                            <p class="text-muted">{{ $devi->notes }}</p>
                        </div>
                    </div>
                    @endif
                </div>
            </div>

            <!-- Products Table -->
            <div class="card shadow mt-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-list"></i> Produits
                    </h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="productsTable">
                            <thead class="table-light">
                                <tr>
                                    <th>Produit</th>
                                    <th class="text-center">Quantité</th>
                                    <th class="text-right">Prix Unit.</th>
                                    <th class="text-right">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($devi->products as $product)
                                    <tr>
                                        <td>
                                            <strong>{{ $product->name }}</strong>
                                            @if($product->description)
                                                <br><small class="text-muted">{{ Str::limit($product->description, 50) }}</small>
                                            @endif
                                        </td>
                                        <td class="text-center">{{ $product->pivot->quantity }}</td>
                                        <td class="text-right">{{ number_format($product->pivot->unit_price, 2) }} DH</td>
                                        <td class="text-right">{{ number_format($product->pivot->total, 2) }} DH</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">
                                            <i class="fas fa-info-circle"></i> Aucun produit associé
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                            <tfoot class="table-light">
                                <tr>
                                    <th colspan="3" class="text-right">Total HT:</th>
                                    <th class="text-right">{{ number_format($devi->total_ht, 2) }} DH</th>
                                </tr>
                                <tr>
                                    <th colspan="3" class="text-right">TVA ({{ $devi->tva }}%):</th>
                                    <th class="text-right">{{ number_format($devi->total_ttc - $devi->total_ht, 2) }} DH</th>
                                </tr>
                                <tr>
                                    <th colspan="3" class="text-right font-weight-bold">Total TTC:</th>
                                    <th class="text-right font-weight-bold text-success">{{ number_format($devi->total_ttc, 2) }} DH</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Quick Actions -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-cogs"></i> Actions Rapides
                    </h6>
                </div>
                <div class="card-body">
                    @if($devi->status == 'accepte')
                        <a href="{{ route('factures.create', ['devis_id' => $devi->id]) }}" class="btn btn-success btn-block mb-2">
                            <i class="fas fa-plus"></i> Créer Facture
                        </a>
                        <a href="{{ route('bon-livraisons.create', ['devis_id' => $devi->id]) }}" class="btn btn-info btn-block mb-2">
                            <i class="fas fa-plus"></i> Créer BL
                        </a>
                    @endif
                    <a href="{{ route('devis.edit', $devi) }}" class="btn btn-warning btn-block mb-2">
                        <i class="fas fa-edit"></i> Modifier Devis
                    </a>
                    <button onclick="window.print()" class="btn btn-secondary btn-block mb-2">
                        <i class="fas fa-print"></i> Imprimer
                    </button>
                   <!--- <button class="btn btn-primary btn-block" onclick="duplicateDevis()">
                        <i class="fas fa-copy"></i> Dupliquer
                    </button>-->
                </div>
            </div>

            <!-- Status Management -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-tasks"></i> Gestion du Statut
                    </h6>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('devis.update', $devi) }}" id="statusForm">
                        @csrf
                        @method('PUT')
                        <div class="form-group">
                            <label for="status">Statut</label>
                            <select class="form-control" id="status" name="status" onchange="updateStatus()">
                                <option value="brouillon" {{ $devi->status == 'brouillon' ? 'selected' : '' }}>Brouillon</option>
                                <option value="envoye" {{ $devi->status == 'envoye' ? 'selected' : '' }}>Envoyé</option>
                                <option value="accepte" {{ $devi->status == 'accepte' ? 'selected' : '' }}>Accepté</option>
                                <option value="refuse" {{ $devi->status == 'refuse' ? 'selected' : '' }}>Refusé</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block" id="statusBtn">
                            <i class="fas fa-save"></i> Mettre à jour
                        </button>
                    </form>
                </div>
            </div>

            <!-- Client Info -->
            @if($devi->client)
            <div class="card shadow">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="fas fa-user"></i> Informations Client
                    </h6>
                </div>
                <div class="card-body">
                    <div class="text-center mb-3">
                        <h5>{{ $devi->client->name }}</h5>
                    </div>
                    <div class="row text-center">
                        <div class="col-6">
                            <small class="text-muted">Téléphone</small><br>
                            <a href="tel:{{ $devi->client->tel }}">{{ $devi->client->tel ?: 'N/A' }}</a>
                        </div>
                        <div class="col-6">
                            <small class="text-muted">Email</small><br>
                            <a href="mailto:{{ $devi->client->email }}">{{ $devi->client->email ?: 'N/A' }}</a>
                        </div>
                    </div>
                    <hr>
                    <a href="{{ route('clients.show', $devi->client) }}" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-eye"></i> Voir le profil client
                    </a>
                </div>
            </div>
            @endif
        </div>
    </div>

    <!-- Danger Zone -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card border-left-danger">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-danger">
                        <i class="fas fa-exclamation-triangle"></i> Zone de Danger
                    </h6>
                </div>
                <div class="card-body">
                    <p class="text-muted">Ces actions sont irréversibles. Soyez prudent.</p>
                    <form method="POST" action="{{ route('devis.destroy', $devi) }}" class="d-inline" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce devis ? Cette action est irréversible.')">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Supprimer le Devis
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function updateStatus() {
    const status = document.getElementById('status').value;
    const btn = document.getElementById('statusBtn');

    if (status === 'accepte') {
        btn.innerHTML = '<i class="fas fa-check"></i> Accepter';
        btn.className = 'btn btn-success btn-block';
    } else if (status === 'refuse') {
        btn.innerHTML = '<i class="fas fa-times"></i> Refuser';
        btn.className = 'btn btn-danger btn-block';
    } else {
        btn.innerHTML = '<i class="fas fa-save"></i> Mettre à jour';
        btn.className = 'btn btn-primary btn-block';
    }
}


<style>
@media print {
    body * {
        visibility: hidden;
    }
    .container-fluid, .container-fluid * {
        visibility: visible;
    }
    .card {
        box-shadow: none !important;
        border: 1px solid #000 !important;
    }
    .card-header, .btn, form, .col-lg-4 {
        display: none !important;
    }
    .card-body {
        padding: 15px !important;
    }
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    .table th, .table td {
        border: 1px solid #000 !important;
        padding: 8px;
    }
    .table tfoot th {
        border-top: 2px solid #000 !important;
    }
}
</style>

@endsection