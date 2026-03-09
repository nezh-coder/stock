<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Facture {{ $facture->numero_facture }}</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .info-table td {
            padding: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: left;
        }
        th {
            background: #f0f0f0;
        }
        .total {
            text-align: right;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>FACTURE</h2>
    <p>N° {{ $facture->numero_facture }}</p>
</div>

<table class="info-table">
    <tr>
        <td><strong>Client :</strong></td>
        <td>{{ $facture->client->name ?? '' }}</td>
        <td><strong>Date :</strong></td>
        <td>{{ $facture->date_facture }}</td>
    </tr>
    <tr>
        <td><strong>Bon Livraison :</strong></td>
        <td>{{ $facture->bonLivraison->numero_bon_livraison ?? '' }}</td>
        <td><strong>Échéance :</strong></td>
        <td>{{ $facture->date_echeance }}</td>
    </tr>
</table>

<table>
    <thead>
        <tr>
            <th>Produit</th>
            <th>Qté</th>
            <th>PU</th>
            <th>Total</th>
        </tr>
    </thead>
    <tbody>
        @foreach($facture->products as $product)
            <tr>
                <td>{{ $product->name }}</td>
                <td>{{ $product->pivot->quantity }}</td>
                <td>{{ number_format($product->pivot->unit_price, 2) }} €</td>
                <td>{{ number_format($product->pivot->total, 2) }} €</td>
            </tr>
        @endforeach
    </tbody>
</table>

<div class="total">
    <p><strong>Total HT :</strong> {{ number_format($facture->total_ht, 2) }} €</p>
    <p><strong>TVA :</strong> {{ $facture->tva }} %</p>
    <p><strong>Total TTC :</strong> {{ number_format($facture->total_ttc, 2) }} €</p>
</div>

</body>
</html>
