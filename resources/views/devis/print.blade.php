<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Devis {{ $devi->numero_devis }}</title>
    <style>
        body { font-family: Arial; font-size: 12px; }
        @media print { button { display:none; } }
        table { width:100%; border-collapse: collapse; }
        th,td { border:1px solid #000; padding:6px; }
    </style>
</head>
<body>

<button onclick="window.print()">Imprimer</button>

<h2>DEVIS {{ $devi->numero_devis }}</h2>
<p>Date : {{ $devi->date_devis->format('d/m/Y') }}</p>

<table>
    <tr>
        <th>Produit</th><th>Qté</th><th>PU</th><th>Total</th>
    </tr>
    @foreach($devi->products as $p)
    <tr>
        <td>{{ $p->name }}</td>
        <td>{{ $p->pivot->quantity }}</td>
        <td>{{ number_format($p->pivot->unit_price,2) }} DH</td>
        <td>{{ number_format($p->pivot->total,2) }} DH</td>
    </tr>
    @endforeach
</table>

<h3>Total TTC : {{ number_format($devi->total_ttc,2) }} DH</h3>

</body>
</html>
