@extends('layouts.adminlte')

@section('title', 'Modifier une Facture')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-warning">
                <div class="card-header">
                    <h3 class="card-title">Modifier une Facture</h3>
                </div>
                <form method="POST" action="{{ route('factures.update', $facture) }}">
                    @csrf
                    @method('PUT')
                    <div class="card-body">
                        <div class="form-group">
                            <label for="numero_facture">Numéro de Facture</label>
                            <input type="text" name="numero_facture" class="form-control @error('numero_facture') is-invalid @enderror" value="{{ old('numero_facture', $facture->numero_facture) }}" required>
                            @error('numero_facture')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="client_id">Client</label>
                            <select name="client_id" class="form-control @error('client_id') is-invalid @enderror" required>
                                <option value="">Sélectionner un client</option>
                                @foreach($clients as $client)
                                    <option value="{{ $client->id }}" {{ old('client_id', $facture->client_id) == $client->id ? 'selected' : '' }}>{{ $client->name }}</option>
                                @endforeach
                            </select>
                            @error('client_id')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="bon_livraison_id">Bon de Livraison</label>
                            <select name="bon_livraison_id" class="form-control @error('bon_livraison_id') is-invalid @enderror">
                                <option value="">Sélectionner un bon de livraison (optionnel)</option>
                                @foreach($bonLivraisons as $bonLivraison)
                                    <option value="{{ $bonLivraison->id }}" {{ old('bon_livraison_id', $facture->bon_livraison_id) == $bonLivraison->id ? 'selected' : '' }}>{{ $bonLivraison->numero_bon_livraison }}</option>
                                @endforeach
                            </select>
                            @error('bon_livraison_id')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="date_facture">Date de Facture</label>
                            <input type="date" name="date_facture" class="form-control @error('date_facture') is-invalid @enderror" value="{{ old('date_facture', $facture->date_facture) }}" required>
                            @error('date_facture')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="date_echeance">Date d'Échéance</label>
                            <input type="date" name="date_echeance" class="form-control @error('date_echeance') is-invalid @enderror" value="{{ old('date_echeance', $facture->date_echeance) }}" required>
                            @error('date_echeance')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ht">Total HT</label>
                            <input type="number" step="0.01" name="total_ht" class="form-control @error('total_ht') is-invalid @enderror" value="{{ old('total_ht', $facture->total_ht) }}" required>
                            @error('total_ht')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="tva">TVA (%)</label>
                            <input type="number" step="0.01" name="tva" class="form-control @error('tva') is-invalid @enderror" value="{{ old('tva', $facture->tva) }}" required>
                            @error('tva')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ttc">Total TTC</label>
                            <input type="number" step="0.01" name="total_ttc" class="form-control @error('total_ttc') is-invalid @enderror" value="{{ old('total_ttc', $facture->total_ttc) }}" required>
                            @error('total_ttc')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="status">Statut</label>
                            <select name="status" class="form-control @error('status') is-invalid @enderror" required>
                                <option value="non_payee" {{ old('status', $facture->status) == 'non_payee' ? 'selected' : '' }}>Non Payée</option>
                                <option value="partiellement_paye" {{ old('status', $facture->status) == 'partiellement_paye' ? 'selected' : '' }}>Partiellement Payée</option>
                                <option value="payee" {{ old('status', $facture->status) == 'payee' ? 'selected' : '' }}>Payée</option>
                                <option value="annulee" {{ old('status', $facture->status) == 'annulee' ? 'selected' : '' }}>Annulée</option>
                            </select>
                            @error('status')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-warning">Mettre à Jour</button>
                        <a href="{{ route('factures.index') }}" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection