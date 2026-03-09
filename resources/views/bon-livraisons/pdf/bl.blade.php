@php
    // IMAGE DE FOND BASE64
    $path = public_path('images/devis_bg.jpg');

    if (!file_exists($path)) {
        echo 'IMAGE NOT FOUND : ' . $path;
        exit;
    }

    $type = pathinfo($path, PATHINFO_EXTENSION);
    $data = file_get_contents($path);
    $base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);


@endphp
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
/* PAGE */
@page {
    margin: 120px 40px 100px 40px;
}

body {
    font-family: DejaVu Sans;
    font-size: 11px;
    color: #333;
}

/* IMAGE DE FOND */
.background {
   position: fixed; top: -120px; left: 0px; left: 0px; width: 100%; height: 100%; z-index: -1;
}

.background img {
   width: 100%;
    height: 297mm;
}

/* TITRES */
.header .title {
    font-size: 18px;
    margin-left: 20px;
    font-weight: bold;
    color: #071380;
}

.header .subtitle {
    font-size: 12px;
     margin-left: 20px;
    color: #555;
    font-weight: bold;
    margin-top: 2px;
}

/* FIELDSET / CARD */
.card {
    border: 1px solid #087df1;
    border-radius: 6px;
    padding: 10px 12px;
    margin-bottom: 10px;
    margin-left: 10px;
}

.card legend {
    font-size: 13px;
    font-weight: bold;
    color: #087df1;
    padding: 0 6px;
}

.card p {
    margin: 3px 0;
    font-size: 12px;
}

/* TABLEAU PRODUITS */
.table-devis {
    width: 95%;
    margin-left: 40px;
    margin-right: 20px;
    border-collapse: collapse;
    margin-top: 15px;
}

.table-devis th {
    background: #071380;
    color: #fff;
    font-size: 12px;
    padding: 8px;
     
    text-align: center;
}

.table-devis td {
    font-size: 12px;
    padding: 7px;
}
.table-devis tbody tr:nth-child(even) {
    background: #f4f6fa;
}
.table-devis tbody tr {
    border-bottom: 1px solid #03488d; /* couleur bleu foncé comme ton header */
}
.text-right {
    text-align: right;
}

.text-center {
    text-align: center;
}

/* TOTAL */
.total-box {
    margin-top: 20px;
    margin-left: 430px;
    
    width: 40%;
}

.total-line {
    padding: 8px;
    font-size: 13px;
    font-weight: bold;
    background: #f4f6fa;
    border: 1px solid #071380;
    text-align: right;
}
/* TOTAL EN LETTRES */
.total-lettres {
    margin-top: 20px;
    width: 100%;
    margin-left: 50px;
    font-size: 12px;
}
</style>
</head>
<body>

<!-- IMAGE DE FOND -->
<div class="background">
    <img src="{{ $base64 }}" />
</div>

<!-- HEADER -->
<div class="header">
    <div class="title">BON DE LIVRAISON N°: {{ $BonLivraison->numero_bon_livraison }}</div>
   
<div class="subtitle">
    Date : {{ $BonLivraison->date_livraison ? \Carbon\Carbon::parse($BonLivraison->date_livraison)->format('d/m/Y') : '-' }}
</div>

</div>

<!-- FOURNISSEUR / CLIENT -->
<table width="100%" border="0" style="margin-top:15px">
<tr>
<td width="50%" valign="top">
<fieldset class="card">
    <legend>Fournisseur</legend>
    <p><strong>{{ $entreprise->name }}</strong></p>
    <p>{{ $entreprise->adresse }}</p>
    <p>Tél : {{ $entreprise->tel }}</p>
</fieldset>
</td>

<td width="50%" valign="top">
<fieldset class="card">
    <legend>Client</legend>
    <p><strong>{{ $client->name }}</strong></p>
    <p>{{ $client->adresse }}</p>
    <p>Tél : {{ $client->tel }}</p>
</fieldset>
</td>
</tr>
</table>

<!-- TABLEAU PRODUITS -->
<table class="table-devis">
<thead>
<tr>
<th>Description</th>
<th>Qté</th>
<th>PU (DH)</th>
<th>Total (DH)</th>
</tr>
</thead>
<tbody>
@foreach($BonLivraison->products as $p)
<tr>
<td>{{ $p->name }}</td>
<td class="text-center">{{ $p->pivot->quantity }}</td>
<td class="text-center">{{ number_format($p->pivot->unit_price, 2) }}</td>
<td class="text-center">{{ number_format($p->pivot->total, 2) }}</td>
</tr>
@endforeach
</tbody>
</table>
<table><tr><td>
<!-- TOTAL TTC -->
<div class="total-box">
    <div class="total-line">
        <table align="center"><tr>
            <td width="50%" align="right">Total HT :</td>
            <td>{{ number_format($BonLivraison->total_ht, 2) }} </td>
        </tr>
        <tr>
            <td align="right">TVA :</td>
            <td>{{ number_format(($BonLivraison->total_ht*$BonLivraison->tva)/100, 2) }} </td>
        </tr>
        <tr>
            <td align="right">Total TTC :</td>
            <td>{{ $BonLivraison->total_ttc }} </td>
        </tr></table>
    </div>
</div>
</td></tr>
<tr><td>
<!-- TOTAL EN LETTRES -->
@php
    $lettre = new \App\Helpers\ChiffreEnLettre();
@endphp
<div class="total-lettres">
<p><b>PRESENT BL EST ARRETE A LA SOMME DE: {{ $lettre->conversion($BonLivraison->total_ttc) }}.</b></p>
</div>
</td></tr></table>
</body>
</html>
