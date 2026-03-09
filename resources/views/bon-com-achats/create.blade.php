@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Créer un Bon de Commande Achat</div>

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

                    <form action="{{ route('bon-com-achats.store') }}" method="POST">
                        @csrf

                        {{-- Numero Bon Commande --}}
                      
<div class="row mb-3">
    <div class="col-md-6">
        <label for="num" class="form-label">N°BC</label>
        <input
            type="text"
            name="num"
            id="num"
            class="form-control"
            value="{{ old('num', $Num ?? '') }}"
            required
        >
    </div>

    <div class="col-md-6">
        <label for="annee" class="form-label">Année</label>
        <input
            type="text"
            name="annee"
            id="annee"
            class="form-control"
            value="{{ old('annee', $annee ?? '') }}"
            required
        >
    </div>
</div>



                        {{-- Client --}}
                        <div class="mb-3">
                            <label for="fournisseur_id" class="form-label">Fournisseur</label>
                            <select name="fournisseur_id" id="fournisseur_id" class="form-control" required>
                                <option value="">Sélectionner un fournisseur</option>
                                @foreach($fournisseurs as $fournisseur)
                                    <option value="{{ $fournisseur->id }}" {{ old('fournisseur_id') == $fournisseur->id ? 'selected' : '' }}>{{ $fournisseur->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        {{-- Date Devis --}}
                        <div class="mb-3">
                            <label for="date_devis" class="form-label">Date du Bon</label>
                            <input
                                type="date"
                                name="date_bc_achat"
                                id="date_bc_achat"
                                class="form-control"
                                value="{{ old('date_bc_achat') }}"
                                required
                            >
                        </div>

                        {{-- Products --}}
                        <div class="mb-3">
                            <label class="form-label">Produits</label>
                            <table class="table table-bordered" id="products-table">
                                <thead>
                                    <tr>
                                        <th>Produit</th>
                                        <th>Quantité</th>
                                        <th>Prix Unitaire</th>
                                        <th>Total</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="products-body">
                                    <tr class="product-row">
                                        <td>
                                            <select name="products[0][product_id]" class="form-control product-select" required>
                                                <option value="">Sélectionner un produit</option>
                                                @foreach($products as $product)
                                                    <option value="{{ $product->id }}" data-price="{{ $product->unit_price }}">{{ $product->name }}</option>
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
                                </tbody>
                            </table>
                            <button type="button" class="btn btn-success" id="add-product">Ajouter Produit</button>
                        </div>

                        {{-- TVA --}}
                        <div class="mb-3">
                            <label for="tva" class="form-label">TVA (%)</label>
                            <input
                                type="number"
                                name="tva"
                                id="tva"
                                class="form-control"
                                value="{{ old('tva', 20.00) }}"
                                step="0.01"
                                required
                            >
                        </div>

                        {{-- Total HT --}}
                        <div class="mb-3">
                            <label for="total_ht" class="form-label">Total HT</label>
                            <input
                                type="number"
                                name="total_ht"
                                id="total_ht"
                                class="form-control"
                                step="0.01"
                                readonly
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
                                step="0.01"
                                readonly
                            >
                        </div>

                        {{-- Status --}}
                        <div class="mb-3">
                            <label for="status" class="form-label">Statut</label>
                            <select name="status" id="status" class="form-control" required>
                                <option value="" {{ old('status') == '' ? 'selected' : '' }}>==Choisir==</option>
                                <option value="brouillon" {{ old('status') == 'brouillon' ? 'selected' : '' }}>Brouillon</option>
                                <option value="envoye" {{ old('status') == 'envoye' ? 'selected' : '' }}>Envoyé</option>
                                  <option value="livre" {{ old('status') == 'livre' ? 'selected' : '' }}>Livré</option>
                                <option value="annule" {{ old('status') == 'annule' ? 'selected' : '' }}>Annulé</option>
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
                            >{{ old('notes') }}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('bon-com-achats.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Créer BC Achat</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let productIndex = 1;

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
        row.innerHTML = `
            <td>
                <select name="products[${productIndex}][product_id]" class="form-control product-select" required>
                    <option value="">Sélectionner un produit</option>
                    @foreach($products as $product)
                        <option value="{{ $product->id }}" data-price="{{ $product->unit_price }}">{{ $product->name }}</option>
                    @endforeach
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


@endsection