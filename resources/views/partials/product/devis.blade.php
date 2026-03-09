@foreach($devis as $d)
<div class="mb-2 p-2 border rounded">
    <strong>Numéro:</strong> {{ $d->numero_devis }}<br>
    <strong>Date:</strong> {{ $d->date_devis }}<br>
    <strong>Client:</strong> {{ $d->client->name ?? 'N/A' }}<br>
    <strong>Prix:</strong> {{ $d->products->firstWhere('id', request('id'))->pivot->unit_price ?? '-' }} DH
</div>
@endforeach