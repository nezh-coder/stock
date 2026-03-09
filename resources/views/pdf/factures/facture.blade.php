@extends('pdf.layout')

@section('title', 'Facture')

@section('content')

{{-- ÉMETTEUR / DESTINATAIRE --}}
<table style="margin-bottom:25px;">
    <tr>
        <td width="50%">
            <strong style="color:#2e7d32;">ÉMETTEUR :</strong><br>
            MA SOCIÉTÉ SARL<br>
            123 Anywhere St.<br>
            Casablanca – Maroc<br>
            +212 5 22 00 00 00<br>
            contact@societe.ma
        </td>
        <td width="50%">
            <strong style="color:#2e7d32;">DESTINATAIRE :</strong><br>
            {{ $facture->client->name }}<br>
            {{ $facture->client->adresse ?? '' }}<br>
            {{ $facture->client->telephone ?? '' }}
        </td>
    </tr>
</table>

{{-- INFOS --}}
<table style="margin-bottom:20px;">
    <tr>
        <td><strong>DATE :</strong> {{ $facture->date_facture }}</td>
        <td><strong>ÉCHÉANCE :</strong> {{ $facture->date_echeance }}</td>
    </tr>
</table>

{{-- TABLE PRODUITS --}}
<table border="1">
    <thead >
        <tr>
            <th>Description</th>
            <th width="10%">Qté</th>
            <th width="20%">Prix Unit</th>
            <th width="20%">Total HT</th>
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

{{-- TOTAUX --}}
<table width="45%" align="right" style="margin-top:20px; font-weight: bold;" border="1">
    <tr>
        <td align="right" width="80%">Total HT</td>
        <td align="right">{{ number_format($facture->total_ht, 2) }} DH</td>
    </tr>
    <tr>
        <td align="right">TVA ({{ $facture->tva }}%)</td>
        <td align="right">{{ number_format($facture->total_ttc - $facture->total_ht, 2) }} DH</td>
    </tr>
    <tr style="background:#e8f5e9;">
        <th align="right">Total TTC</th>
        <th align="right">{{ number_format($facture->total_ttc, 2) }} DH</th>
    </tr>
</table>

<br><br>

{{-- RÈGLEMENT --}}
<p>
    <strong style="color:#2e7d32;">RÈGLEMENT :</strong><br>
    Par virement bancaire<br>
    Banque : Attijariwafa Bank<br>
    IBAN : MA64 0123 4567 8901 2345 6789
</p>

{{-- CONDITIONS + SIGNATURE --}}
<table style="margin-top:25px;">
    <tr>
        <td width="65%" style="font-size:9px;">
            En cas de retard de paiement, une pénalité de 10% par jour sera appliquée.<br>
            Conditions générales consultables sur le site de la société.
        </td>
        <td width="35%" align="center">
            <strong>Signature & Cachet</strong><br><br>
            <img src="{{ public_path('images/cachet.png') }}" height="65">
        </td>
    </tr>
</table>

@endsection
