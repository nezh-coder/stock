@extends('pdf.layout')

@section('title', 'Facture')

@section('doc_title', 'FACTURE')

@section('content')

{{-- ===== TITRE + NUMÉRO ===== --}}
<table width="100%" style="margin-bottom:25px;">
    <tr>
        <td>
            <h1 style="color:#2e7d32; margin:0;">FACTURE</h1>
            <p style="font-size:11px;">
                Facture N° : <strong>{{ $facture->numero_facture }}</strong>
            </p>
        </td>
        <td align="right">
            <strong>Date :</strong> {{ $facture->date_facture }}<br>
            <strong>Échéance :</strong> {{ $facture->date_echeance }}
        </td>
    </tr>
</table>

{{-- ===== ÉMETTEUR / DESTINATAIRE ===== --}}
<table width="100%" style="margin-bottom:25px;">
    <tr>
        <td width="50%">
            <strong style="color:#2e7d32;">ÉMETTEUR</strong><br>
            MA SOCIÉTÉ SARL<br>
            Casablanca – Maroc<br>
            +212 5 22 00 00 00<br>
            contact@societe.ma
        </td>
        <td width="50%">
            <strong style="color:#2e7d32;">DESTINATAIRE</strong><br>
            {{ $facture->client->name }}<br>
            {{ $facture->client->adresse ?? '' }}<br>
            {{ $facture->client->telephone ?? '' }}
        </td>
    </tr>
</table>

{{-- ===== TABLE PRODUITS ===== --}}
<table>
    <thead>
        <tr style="background:#2e7d32; color:white;">
            <th>Description</th>
            <th width="10%">Qté</th>
            <th width="20%">PU (DH)</th>
            <th width="20%">Total (DH)</th>
        </tr>
    </thead>
    <tbody>
        @foreach($facture->products as $product)
        <tr>
            <td>{{ $product->name }}</td>
            <td align="center">{{ $product->pivot->quantity }}</td>
            <td align="right">{{ number_format($product->pivot->unit_price, 2) }}</td>
            <td align="right">{{ number_format($product->pivot->total, 2) }}</td>
        </tr>
        @endforeach
    </tbody>
</table>

{{-- ===== TOTAUX ===== --}}
<table width="40%" align="right" style="margin-top:20px;">
    <tr>
        <td>Total HT</td>
        <td align="right">{{ number_format($facture->total_ht, 2) }} DH</td>
    </tr>
    <tr>
        <td>TVA {{ $facture->tva }}%</td>
        <td align="right">{{ number_format($facture->total_ttc - $facture->total_ht, 2) }} DH</td>
    </tr>
    <tr style="background:#e8f5e9;">
        <th>Total TTC</th>
        <th align="right">{{ number_format($facture->total_ttc, 2) }} DH</th>
    </tr>
</table>

<br><br>

{{-- ===== RÈGLEMENT ===== --}}
<p style="font-size:11px;">
    <strong style="color:#2e7d32;">RÈGLEMENT</strong><br>
    Par virement bancaire<br>
    Banque : Attijariwafa Bank<br>
    RIB : 012 345 678 901 234 567 89
</p>

{{-- ===== CONDITIONS + SIGNATURE ===== --}}
<table width="100%" style="margin-top:25px;">
    <tr>
        <td width="60%" style="font-size:10px;">
            En cas de retard de paiement, une pénalité pourra être appliquée.<br>
            Conditions générales disponibles sur le site de la société.
        </td>
        <td width="40%" align="center">
            <strong>Signature & Cachet</strong><br><br>
            <img src="{{ public_path('images/cachet.png') }}" height="70">
        </td>
    </tr>
</table>

@endsection
