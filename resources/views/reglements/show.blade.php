@extends('adminlte::page')

@section('content')
 <div align="right">
                    <a href="{{ route('reglements.index') }}" class="btn btn-warning mb-3">
                         <i class="fas fa-arrow-left mr-1"></i>Retour à la liste
                       
                    </a>
                </div>
<h3>Détail règlement #{{ $reglement->id }}</h3>

<p><strong>Fournisseur :</strong> {{ $reglement->fournisseur->name }}</p>
<p><strong>Montant :</strong> {{ $reglement->montant }} DH</p>
<p><strong>Date :</strong> {{ $reglement->date_reglement }}</p>

<table class="table table-bordered">
    <thead>
        <tr>
            <th>Bon</th>
            <th>Montant payé</th>
        </tr>
    </thead>
    <tbody>
        @foreach($reglement->achats as $bon)
            <tr>
                <td>Bon #{{ $bon->id }}</td>
                <td>{{ $bon->pivot->mont_paye }} DH</td>
            </tr>
        @endforeach
    </tbody>
</table>

@endsection