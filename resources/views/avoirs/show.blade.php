@extends('adminlte::page')

@section('title', 'Détails de l\'Avoir - ' . $avoir->numero_avoir)

@section('content')
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-10">

            <div class="card card-primary">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="card-title">
                            <i class="fas fa-undo mr-2"></i>Détails de l'Avoir: {{ $avoir->numero_avoir }}
                        </h3>
                        <div>
                            <a href="{{ route('avoirs.pdf', $avoir) }}" class="btn btn-danger btn-sm" target="_blank">
                                <i class="fas fa-file-pdf mr-1"></i>Télécharger PDF
                            </a>
                            <a href="{{ route('avoirs.index') }}" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left mr-1"></i>Retour
                            </a>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h5 class="text-primary mb-3"><i class="fas fa-info-circle mr-2"></i>Informations Générales</h5>
                            <dl class="row">
                                <dt class="col-sm-4">Numéro Avoir:</dt>
                                <dd class="col-sm-8"><span class="badge badge-primary">{{ $avoir->numero_avoir }}</span></dd>

                                <dt class="col-sm-4">Client:</dt>
                                <dd class="col-sm-8"><strong>{{ $avoir->client->name ?? 'N/A' }}</strong></dd>

                                <dt class="col-sm-4">Date Avoir:</dt>
                                <dd class="col-sm-8">{{ \Carbon\Carbon::parse($avoir->date_avoir)->format('d/m/Y') }}</dd>

                                <dt class="col-sm-4">Statut:</dt>
                                <dd class="col-sm-8">
                                    @if($avoir->status == 'en_cours')
                                        <span class="badge badge-warning"><i class="fas fa-clock mr-1"></i>En Cours</span>
                                    @elseif($avoir->status == 'valide')
                                        <span class="badge badge-success"><i class="fas fa-check-circle mr-1"></i>Validé</span>
                                    @elseif($avoir->status == 'annule')
                                        <span class="badge badge-danger"><i class="fas fa-times-circle mr-1"></i>Annulé</span>
                                    @endif
                                </dd>

                                <dt class="col-sm-4">Créé le:</dt>
                                <dd class="col-sm-8">{{ $avoir->created_at->format('d/m/Y H:i') }}</dd>

                                <dt class="col-sm-4">Modifié le:</dt>
                                <dd class="col-sm-8">{{ $avoir->updated_at->format('d/m/Y H:i') }}</dd>
                            </dl>
                        </div>

                        <div class="col-md-6">
                            <h5 class="text-primary mb-3"><i class="fas fa-link mr-2"></i>Documents Référencés</h5>
                            @if($avoir->bon_livraison_id)
                                <div class="alert alert-info">
                                    <strong><i class="fas fa-truck mr-2"></i>Bon de Livraison:</strong>
                                    <br>{{ $avoir->bonLivraison->numero_bon_livraison ?? 'N/A' }}
                                    <br><small class="text">Date: {{ \Carbon\Carbon::parse($avoir->bonLivraison->date_livraison)->format('d/m/Y') }}</small>
                                </div>
                            @endif

                            @if($avoir->facture_id)
                                <div class="alert alert-warning">
                                    <strong><i class="fas fa-file-invoice-dollar mr-2"></i>Facture:</strong>
                                    <br>{{ $avoir->facture->numero_facture ?? 'N/A' }}
                                    <br><small class="text-muted">Date: {{ \Carbon\Carbon::parse($avoir->facture->date_facture)->format('d/m/Y') }}</small>
                                </div>
                            @endif

                            <h5 class="text-primary mt-4 mb-3"><i class="fas fa-calculator mr-2"></i>Totaux</h5>
                            <table class="table table-sm table-borderless">
                                <tr class="border-bottom">
                                    <td><strong>Total HT:</strong></td>
                                    <td class="text-right"><strong>{{ number_format($avoir->total_ht, 2) }} DH</strong></td>
                                </tr>
                                <tr class="border-bottom">
                                    <td><strong>TVA ({{ $avoir->tva }}%):</strong></td>
                                    <td class="text-right"><strong>{{ number_format(($avoir->total_ht * $avoir->tva) / 100, 2) }} DH</strong></td>
                                </tr>
                                <tr class="table-success">
                                    <td><strong>Total TTC:</strong></td>
                                    <td class="text-right"><strong style="font-size: 1.2em;">{{ number_format($avoir->total_ttc, 2) }} DH</strong></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    @if($avoir->motif || $avoir->notes)
                    <div class="alert alert-light mt-4 border-left border-warning">
                        @if($avoir->motif)
                        <h6 class="text-warning"><i class="fas fa-comment mr-2"></i>Motif du Retour</h6>
                        <p>{{ $avoir->motif }}</p>
                        @endif

                        @if($avoir->notes)
                        <h6 class="text-warning mt-3"><i class="fas fa-sticky-note mr-2"></i>Notes</h6>
                        <p>{{ $avoir->notes }}</p>
                        @endif
                    </div>
                    @endif

                    <h5 class="text-primary mt-4 mb-3"><i class="fas fa-boxes mr-2"></i>Articles Retournés</h5>
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead class="thead-light">
                                <tr>
                                    <th>Produit</th>
                                    <th class="text-center">Quantité</th>
                                    <th class="text-right">Prix Unitaire</th>
                                    <th class="text-right">Total</th>
                                    <th>Motif du Retour</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($avoir->products as $product)
                                    <tr>
                                        <td><strong>{{ $product->name }}</strong></td>
                                        <td class="text-center">
                                            <span class="badge badge-info">{{ $product->pivot->quantity }}</span>
                                        </td>
                                        <td class="text-right">{{ number_format($product->pivot->unit_price, 2) }} DH</td>
                                        <td class="text-right"><strong>{{ number_format($product->pivot->total, 2) }} DH</strong></td>
                                        <td>
                                            @if($product->pivot->motif_retour)
                                                <small class="text-muted">{{ $product->pivot->motif_retour }}</small>
                                            @else
                                                <small class="text-muted">-</small>
                                            @endif
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <i class="fas fa-box fa-2x mb-2"></i>
                                            <p>Aucun produit retourné</p>
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4 pt-3 border-top">
                        <a href="{{ route('avoirs.edit', $avoir) }}" class="btn btn-warning">
                            <i class="fas fa-edit mr-1"></i>Modifier
                        </a>
                        <a href="{{ route('avoirs.pdf', $avoir) }}" class="btn btn-danger" target="_blank">
                            <i class="fas fa-file-pdf mr-1"></i>Télécharger PDF
                        </a>
                        <form method="POST" action="{{ route('avoirs.destroy', $avoir) }}" class="d-inline">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-outline-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet avoir ? Cette action est irréversible.')">
                                <i class="fas fa-trash mr-1"></i>Supprimer
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection