@foreach($br as $b)
<div class="mb-2 p-2 border rounded">
    <strong>Numéro:</strong> {{ $b->numero_achat ?? $b->id }}<br>
    <strong>Date:</strong> {{ $b->date_livraison }}<br>
    <strong>Fournisseur:</strong> {{ $b->fournisseur->name ?? 'N/A' }}<br>
    <strong>Prix:</strong> {{ $b->products->firstWhere('id', request('id'))->pivot->unit_price ?? '-' }} DH
</div>
@endforeach