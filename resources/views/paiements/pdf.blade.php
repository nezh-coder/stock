<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>

body {
    font-family: DejaVu Sans, sans-serif;
    font-size: 12px;
}

.header {
    width: 100%;
    margin-bottom: 20px;
}

.logo {
    float: left;
    width: 150px;
}

.company {
    text-align: right;
}

.clear {
    clear: both;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table th, table td {
    border: 1px solid #000;
    padding: 6px;
    text-align: center;
}

th {
    background-color: #f2f2f2;
}

.footer {
    position: fixed;
    bottom: 0;
    width: 100%;
    text-align: right;
    font-size: 10px;
}

.signature {
    margin-top: 40px;
    width: 100%;
}

.signature div {
    width: 40%;
    display: inline-block;
    text-align: center;
}

</style>
</head>
<body>

{{-- HEADER --}}
<div class="header">
    <div class="logo">
        <img src="{{ public_path('images/logo.png') }}" width="120">
    </div>

    <div class="company">
        <h2 align="center"><u>ETAT DES REGLEMENTS CLIENTS</u></h2>
        <p>Date impression : {{ date('d/m/Y') }}</p>
    </div>
</div>

<div class="clear"></div>

@if($request->date_debut || $request->date_fin || $request->fournisseur_id)
<p>
<strong>Filtres :</strong><br>
@if($request->date_debut) Du : {{ $request->date_debut }} @endif
@if($request->date_fin)  Au : {{ $request->date_fin }} @endif
</p>
@endif

<br>

{{-- TABLEAU --}}
<table>
    <thead>
        <tr>
            <th>N°</th>
            <th>Client</th>
            <th>Montant</th>
             <th>Facture(s) payée(s)</th>
            <th>Date</th>
            <th>Mode</th>
            <th>Saisi par</th>
        </tr>
    </thead>
    <tbody>
        @foreach($reglements as $key => $r)
        <tr>
            <td>{{ $key + 1 }}</td>
            <td>{{ ucfirst($r->client->name) }}</td>
            <td>{{ number_format($r->montant,2) }} DH</td>
             <td>
          @foreach($r->factures as $key => $facture)   
           {{ ucfirst($facture->numero_facture).'- ' }}
         
        
          @endforeach
        </td>
            <td>{{ \Carbon\Carbon::parse($r->date_reglement)->format('d/m/Y') }}</td>
            <td>{{ $r->mode_paiement }}</td>
            <td>{{ ucfirst($r->user->name) }}</td>
        </tr>
        @endforeach
    </tbody>
</table>

<br>

{{-- TOTAL GENERAL --}}
<h3 style="text-align:right;">
    TOTAL GENERAL : {{ number_format($totalGeneral,2) }} DH
</h3>

{{-- SIGNATURE --}}
<div class="signature">
    <div>
        <p>Signature responsable</p>
        <br><br>
        _______________________
    </div>

    <div>
        <p>Cachet entreprise</p>
        <br><br>
        _______________________
    </div>
</div>

{{-- PAGINATION --}}
<div class="footer">
    Page <script type="text/php">
        if ( isset($pdf) ) {
            $pdf->page_text(520, 570, "Page {PAGE_NUM} / {PAGE_COUNT}", null, 10);
        }
    </script>
</div>

</body>
</html>