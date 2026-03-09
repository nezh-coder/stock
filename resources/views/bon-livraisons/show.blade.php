@extends('adminlte::page')

@section('title', 'Détails du Bon de Livraison')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Détails du Bon de Livraison</h3>
                    <div class="card-tools">
                        <a href="{{ route('bon-livraisons.edit', $bonLivraison) }}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                        <a href="{{ route('bon-livraisons.index') }}" class="btn btn-secondary btn-sm">
                            <i class="fas fa-list"></i> Retour à la Liste
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">Numéro du Bon de Livraison</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->numero_bon_livraison }}</dd>

                        <dt class="col-sm-3">Client</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->client->name ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Bon de Commande</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->bonCommande->numero_bon_commande ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Date de Livraison</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->date_livraison }}</dd>

                        <dt class="col-sm-3">Total HT</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->total_ht }} DH</dd>

                        <dt class="col-sm-3">TVA</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->tva }} %</dd>

                        <dt class="col-sm-3">Total TTC</dt>
                        <dd class="col-sm-9">{{ $bonLivraison->total_ttc }} DH</dd>

                        <dt class="col-sm-3">Statut</dt>
                        <dd class="col-sm-9">
                            @if($bonLivraison->status == 'en_attente')
                                <span class="badge badge-warning">En Attente</span>
                            @elseif($bonLivraison->status == 'livré')
                                <span class="badge badge-success">Livré</span>
                            @elseif($bonLivraison->status == 'annulée')
                                <span class="badge badge-danger">Annulé</span>
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
                            @forelse($bonLivraison->products as $product)
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
                        @if($bonLivraison->status === 'livre')
                        <a href="{{ route('avoirs.create', ['source_type' => 'bon_livraison', 'source_id' => $bonLivraison->id]) }}" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Créer un Avoir
                        </a>
                        @endif
                        <a href="{{ route('bon-livraisons.edit', $bonLivraison) }}" class="btn btn-primary">Modifier</a>
                        <form method="POST" action="{{ route('bon-livraisons.destroy', $bonLivraison) }}" class="d-inline">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce bon de livraison ?')">Supprimer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection