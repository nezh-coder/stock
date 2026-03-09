@extends('adminlte::page')

@section('title', 'Détails de la Facture')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Détails de la Facture</h3>
                    <div class="card-tools">
                        <a href="{{ route('factures.edit', $facture) }}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                        <a href="{{ route('factures.index') }}" class="btn btn-secondary btn-sm">
                            <i class="fas fa-list"></i> Retour à la Liste
                        </a>
                        <a href="{{ route('factures.pdf', $facture) }}" target="_blank" class="btn btn-danger btn-sm">
                            <i class="fas fa-file-pdf"></i> Imprimer PDF
                        </a>

                    </div>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">Numéro de Facture</dt>
                        <dd class="col-sm-9">{{ $facture->numero_facture }}</dd>

                        <dt class="col-sm-3">Client</dt>
                        <dd class="col-sm-9">{{ $facture->client->name ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Bon de Livraison</dt>
                        <dd class="col-sm-9">{{ $facture->bonLivraison->numero_bon_livraison ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Date de Facture</dt>
                        <dd class="col-sm-9">{{ $facture->date_facture }}</dd>

                        <dt class="col-sm-3">Date d'Échéance</dt>
                        <dd class="col-sm-9">{{ $facture->date_echeance }}</dd>

                        <dt class="col-sm-3">Total HT</dt>
                        <dd class="col-sm-9">{{ $facture->total_ht }} DH</dd>

                        <dt class="col-sm-3">TVA</dt>
                        <dd class="col-sm-9">{{ $facture->tva }} %</dd>

                        <dt class="col-sm-3">Total TTC</dt>
                        <dd class="col-sm-9">{{ $facture->total_ttc }} DH</dd>

                        <dt class="col-sm-3">Statut</dt>
                        <dd class="col-sm-9">
                            @if($facture->status == 'en_attente')
                                <span class="badge badge-warning">En Attente</span>
                            @elseif($facture->status == 'payee')
                                <span class="badge badge-success">Payée</span>
                            @elseif($facture->status == 'annulee')
                                <span class="badge badge-danger">Annulée</span>
                            @endif
                        </dd>
                    </dl>

                    <h6 class="mt-4">Produits</h6>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Produit</th>
                                <th>Quantité</th>
                                <th>Prix Unitaire</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($facture->products as $product)
                                <tr>
                                    <td>{{ $product->name }}</td>
                                    <td>{{ $product->pivot->quantity }}</td>
                                    <td>{{ $product->pivot->unit_price }} DH</td>
                                    <td>{{ $product->pivot->total }} DH</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4">Aucun produit</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>

                    <div class="mt-4">
                        @if($facture->status === 'payee')
                        <a href="{{ route('avoirs.create', ['source_type' => 'facture', 'source_id' => $facture->id]) }}" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Créer un Avoir
                        </a>
                        @endif
                        <a href="{{ route('factures.edit', $facture) }}" class="btn btn-primary">Modifier</a>
                        <form method="POST" action="{{ route('factures.destroy', $facture) }}" class="d-inline">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette facture ?')">Supprimer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection