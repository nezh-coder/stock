@extends('adminlte::page')
@section('content')
@section('css')
<link rel="stylesheet"
      href="{{ asset('vendor/calendar/css/tempusdominus-bootstrap-4.min.css') }}">
@endsection

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">

            <div class="card">
                <div class="card-header">Modifier le Devis</div>

                <div class="card-body">
                    {{-- Display Validation Errors --}}
                    @if ($errors->any())
                        <div class="alert alert-danger">
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form action="{{ route('devis.update', $devi) }}" method="POST">
                        @csrf
                        @method('PUT')

                        {{-- Numero Devis --}}
                        <div class="mb-3">
                            <label for="numero_devis" class="form-label">Numéro du Devis</label>
                            <input
                                type="text"
                                name="numero_devis"
                                id="numero_devis"
                                class="form-control"
                                value="{{ old('numero_devis', $devi->numero_devis) }}"
                                required
                            >
                        </div>

                        {{-- Client --}}
                        <div class="mb-3">
                            <label for="client_id" class="form-label">Client</label>
                            <select name="client_id" id="client_id" class="form-control" required>
                                <option value="">Sélectionner un client</option>
                                @foreach(\App\Models\Client::all() as $user)
                                    <option value="{{ $user->id }}" {{ old('client_id', $devi->client_id) == $user->id ? 'selected' : '' }}>{{ $user->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        {{-- Date Devis --}}
                       <div class="mb-3">
    <label for="date_devis">Date du Devis</label>

    <div class="input-group date" id="date_devis_picker" data-target-input="nearest">
        <input type="text"
               name="date_devis"
               class="form-control datetimepicker-input @error('date_devis') is-invalid @enderror"
               data-target="#date_devis_picker"
               value="{{ old('date_devis', optional($devi->date_devis)->format('d-m-Y')) }}"
               autocomplete="off"
               required>
        <div class="input-group-append" data-target="#date_devis_picker" data-toggle="datetimepicker">
            <div class="input-group-text">
                <i class="far fa-calendar-alt"></i>
            </div>
        </div>
    </div>

    @error('date_devis')
        <span class="invalid-feedback d-block">{{ $message }}</span>
    @enderror
</div>


                          {{-- Products --}}
                        <div class="mb-3">
                            <label class="form-label">Articles:</label>
                            <table class="table table-bordered" id="products-table">
                                <thead>
                                    <tr>
                                        <th>Désignation</th>
                                        <th>Quantité</th>
                                        <th>Prix Unitaire</th>
                                        <th>Total</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="products-body">
                                    @foreach($devi->products as $index => $product)
                                    <tr class="product-row">
                                        <td>
                                            <select name="products[{{ $index }}][product_id]" class="form-control product-select" required>
                                                <option value="">Sélectionner un produit</option>
                                                @foreach($products as $prod)
                                                    <option value="{{ $prod->id }}" data-price="{{ $prod->unit_price }}" {{ $prod->id == $product->id ? 'selected' : '' }}>{{ $prod->name }}</option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            <input type="number" name="products[{{ $index }}][quantity]" class="form-control quantity" min="1" value="{{ $product->pivot->quantity }}" required>
                                        </td>
                                        <td>
                                            <input type="number" name="products[{{ $index }}][unit_price]" class="form-control unit-price" step="0.01" min="0" value="{{ $product->pivot->unit_price }}" required>
                                        </td>
                                        <td>
                                            <input type="number" class="form-control total" step="0.01" value="{{ $product->pivot->total }}" readonly>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-danger remove-product">Supprimer</button>
                                        </td>
                                    </tr>
                                    @endforeach
                                    @if($devi->products->isEmpty())
                                    <tr class="product-row">
                                        <td>
                                            <select name="products[0][product_id]" class="form-control product-select" required>
                                                <option value="">Sélectionner un produit</option>
                                                @foreach($products as $prod)
                                                    <option value="{{ $prod->id }}" data-price="{{ $prod->unit_price }}">{{ $prod->name }}</option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            <input type="number" name="products[0][quantity]" class="form-control quantity" min="1" value="1" required>
                                        </td>
                                        <td>
                                            <input type="number" name="products[0][unit_price]" class="form-control unit-price" step="0.01" min="0" required>
                                        </td>
                                        <td>
                                            <input type="number" class="form-control total" step="0.01" readonly>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-danger remove-product">Supprimer</button>
                                        </td>
                                    </tr>
                                    @endif
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-success" id="add-product">Ajouter Produit</button>
                        </div>
                        {{-- Total HT --}}
                        <div class="mb-3">
                            <label for="total_ht" class="form-label">Total HT</label>
                            <input
                                type="number"
                                name="total_ht"
                                id="total_ht"
                                class="form-control"
                                value="{{ old('total_ht', $devi->total_ht) }}"
                                step="0.01"
                                required
                            >
                        </div>

                        {{-- TVA --}}
                        <div class="mb-3">
                            <label for="tva" class="form-label">TVA (%)</label>
                            <input
                                type="number"
                                name="tva"
                                id="tva"
                                class="form-control"
                                value="{{ old('tva', $devi->tva) }}"
                                step="0.01"
                                required
                            >
                        </div>

                        {{-- Total TTC --}}
                        <div class="mb-3">
                            <label for="total_ttc" class="form-label">Total TTC</label>
                            <input
                                type="number"
                                name="total_ttc"
                                id="total_ttc"
                                class="form-control"
                                value="{{ old('total_ttc', $devi->total_ttc) }}"
                                step="0.01"
                                required
                            >
                        </div>

                        {{-- Status --}}
                        <div class="mb-3">
                            <label for="status" class="form-label">Statut</label>
                            <select name="status" id="status" class="form-control" required>
                                <option value="brouillon" {{ old('status', $devi->status) == 'brouillon' ? 'selected' : '' }}>Brouillon</option>
                                <option value="envoye" {{ old('status', $devi->status) == 'envoye' ? 'selected' : '' }}>Envoyé</option>
                                <option value="accepte" {{ old('status', $devi->status) == 'accepte' ? 'selected' : '' }}>Accepté</option>
                                <option value="refuse" {{ old('status', $devi->status) == 'refuse' ? 'selected' : '' }}>Refusé</option>
                            </select>
                        </div>

                        {{-- Notes --}}
                        <div class="mb-3">
                            <label for="notes" class="form-label">Notes</label>
                            <textarea
                                name="notes"
                                id="notes"
                                rows="4"
                                class="form-control"
                            >{{ old('notes', $devi->notes) }}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('devis.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Mettre à Jour</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    let productIndex = {{ $devi->products->count() }};

    const allProducts = @json($products);

    // Function to calculate row total
    function calculateRowTotal(row) {
        const quantity = parseFloat(row.querySelector('.quantity').value) || 0;
        const unitPrice = parseFloat(row.querySelector('.unit-price').value) || 0;
        const total = quantity * unitPrice;
        row.querySelector('.total').value = total.toFixed(2);
        return total;
    }

    // Function to calculate grand totals
    function calculateGrandTotals() {
        let totalHT = 0;
        document.querySelectorAll('.product-row').forEach(row => {
            totalHT += calculateRowTotal(row);
        });
        document.getElementById('total_ht').value = totalHT.toFixed(2);

        const tva = parseFloat(document.getElementById('tva').value) || 0;
        const totalTTC = totalHT * (1 + tva / 100);
        document.getElementById('total_ttc').value = totalTTC.toFixed(2);
    }

    // Add product button
    document.getElementById('add-product').addEventListener('click', function() {
        const tbody = document.getElementById('products-body');
        const row = document.createElement('tr');
        row.className = 'product-row';
        let options = '<option value="">Sélectionner un produit</option>';
        allProducts.forEach(prod => {
            options += `<option value="${prod.id}" data-price="${prod.unit_price}">${prod.name}</option>`;
        });
        row.innerHTML = `
            <td>
                <select name="products[${productIndex}][product_id]" class="form-control product-select" required>
                    ${options}
                </select>
            </td>
            <td>
                <input type="number" name="products[${productIndex}][quantity]" class="form-control quantity" min="1" value="1" required>
            </td>
            <td>
                <input type="number" name="products[${productIndex}][unit_price]" class="form-control unit-price" step="0.01" min="0" required>
            </td>
            <td>
                <input type="number" class="form-control total" step="0.01" readonly>
            </td>
            <td>
                <button type="button" class="btn btn-danger remove-product">Supprimer</button>
            </td>
        `;
        tbody.appendChild(row);
        productIndex++;
        attachRowEvents(row);
        calculateGrandTotals();
    });

    // Attach events to a row
    function attachRowEvents(row) {
        // Product select change
        row.querySelector('.product-select').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const price = selectedOption.getAttribute('data-price');
            if (price) {
                row.querySelector('.unit-price').value = price;
                calculateGrandTotals();
            }
        });

        // Quantity and unit price change
        row.querySelector('.quantity').addEventListener('input', calculateGrandTotals);
        row.querySelector('.unit-price').addEventListener('input', calculateGrandTotals);

        // Remove button
        row.querySelector('.remove-product').addEventListener('click', function() {
            row.remove();
            calculateGrandTotals();
        });
    }

    // Attach events to initial row
    document.querySelectorAll('.product-row').forEach(attachRowEvents);

    // TVA change
    document.getElementById('tva').addEventListener('input', calculateGrandTotals);



    // Initial calculation
    calculateGrandTotals();
});
</script>
@section('js')
<script src="{{ asset('vendor/calendar/js/moment.min.js') }}"></script>
<script src="{{ asset('vendor/calendar/js/fr.js') }}"></script>
<script src="{{ asset('vendor/calendar/js/tempusdominus-bootstrap-4.min.js') }}"></script>


<script>
$(function () {
    $('#date_devis_picker').datetimepicker({
        format: 'DD-MM-YYYY',   // 👀 affichage utilisateur
        locale: 'fr'
    });
});

</script>
@endsection



@endsection