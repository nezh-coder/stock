@extends('adminlte::page')

@section('title', 'Détails du Bon de Livraison')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Détails du Bon d'Achat</h3>
                    <div class="card-tools">
                        <a href="{{ route('achats.edit', $Achat) }}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                        <a href="{{ route('achats.index') }}" class="btn btn-secondary btn-sm">
                            <i class="fas fa-list"></i> Retour à la Liste
                        </a>
                    </div>
                </div>
                <div class="card-body">
                    <dl class="row">
                        <dt class="col-sm-3">Numéro du Bon de Récéption</dt>
                        <dd class="col-sm-9">{{ $Achat->numero_achat }}</dd>

                        <dt class="col-sm-3">Fournisseur</dt>
                        <dd class="col-sm-9">{{ $Achat->fournisseur->name ?? 'N/A' }}</dd>

                       
                        <dt class="col-sm-3">Date de Livraison</dt>
                        <dd class="col-sm-9">{{ $Achat->date_livraison }}</dd>

                        <dt class="col-sm-3">Total HT</dt>
                        <dd class="col-sm-9">{{ $Achat->total_ht }} DH</dd>

                        <dt class="col-sm-3">TVA</dt>
                        <dd class="col-sm-9">{{ $Achat->tva }} %</dd>

                        <dt class="col-sm-3">Total TTC</dt>
                        <dd class="col-sm-9">{{ $Achat->total_ttc }} DH</dd>
                        <dt class="col-sm-3">Montant Payé</dt>
                        <dd class="col-sm-9">{{ $Achat->montant_paye }} DH</dd>

               
                        <dt class="col-sm-3">Statut</dt>
                        <dd class="col-sm-9">
                            @if($Achat->status == 'en_cours')
                                <span class="badge badge-warning">En Cours</span>
                            @elseif($Achat->status == 'partiellement_paye')
                                <span class="badge badge-success">Partiellement Payé</span>
                            @elseif($Achat->status == 'paye')
                                <span class="badge badge-success">Payé</span>

                                @elseif($Achat->status == 'annulée')
                                <span class="badge badge-danger">Annulé</span>
                            @endif
                        </dd>
                    </dl>

                    <h6 class="mt-4">Produits</h6>
                    <table class="table table-sm">
                        <thead>
                            <tr>
                                <th>Désignation</th>
                                <th>Quantité</th>
                                <th>Prix Unitaire</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($Achat->products as $product)
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
                        @if($Achat->status === 'livre')
                        <a href="{{ route('avoirs.create', ['source_type' => 'bon_livraison', 'source_id' => $Achat->id]) }}" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Créer un Avoir
                        </a>
                        @endif
                        <a href="{{ route('bon-livraisons.edit', $Achat) }}" class="btn btn-primary">Modifier</a>
                        <form method="POST" action="{{ route('bon-livraisons.destroy', $Achat) }}" class="d-inline">
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