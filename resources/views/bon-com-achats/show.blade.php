@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">

            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Détails du Bon de Commande</h5>
                        <a href="{{ route('bon-commandes.index') }}" class="btn btn-secondary btn-sm">Retour</a>
                    </div>
                </div>

                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">Numéro:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->numero_bc_achat }}</dd>

                        <dt class="col-sm-3">Fournisseur:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->fournisseur->name ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Date:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->date_bc_achat }}</dd>

                        <dt class="col-sm-3">Date de livraison:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->date_livraison ?? 'N/A' }}</dd>

                        <dt class="col-sm-3">Total HT:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->total_ht }} DH</dd>

                        <dt class="col-sm-3">TVA:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->tva }} %</dd>

                        <dt class="col-sm-3">Total TTC:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->total_ttc }} DH</dd>

                        <dt class="col-sm-3">Statut:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->status }}</dd>

                        <dt class="col-sm-3">Notes:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->notes ?: 'N/A' }}</dd>

                        <dt class="col-sm-3">Créé le:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->created_at->format('d/m/Y H:i') }}</dd>

                        <dt class="col-sm-3">Mis à jour le:</dt>
                        <dd class="col-sm-9">{{ $BonComAchat->updated_at->format('d/m/Y H:i') }}</dd>
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
                            @forelse($BonComAchat->products as $product)
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
                        <a href="{{ route('bon-com-achats.edit', $BonComAchat) }}" class="btn btn-warning">Modifier</a>
                        <form method="POST" action="{{ route('bon-com-achats.destroy', $BonComAchat) }}" class="d-inline">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce bon de commande ?')">Supprimer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection