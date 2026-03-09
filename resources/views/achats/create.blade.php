@extends('adminlte::page')

@section('title', 'Créer un Bon de Livraison')

@section('plugins.Inputmask', true)

@section('content')

<div class="container-fluid">
    @if ($errors->any())
    <div class="alert alert-danger">
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif
    <div class="row">
        <div class="col-md-12" >
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Créer un Bon de Récéption</h3>
                </div>
                <form method="POST" action="{{ route('achats.store') }}">
                    @csrf
                   
<div class="row mb-3" >
    <div class="col-md-3" style="margin-left: 10px;">
        <label for="num" class="form-label">N°Bon de Récéption</label>
        <input
            type="text"
            name="numero_achat"
            id="numero_achat"
            class="form-control"
            value="{{ old('numero_achat', $numero_achat ?? '') }}"
            required
        >
    </div>

  
</div>
                       
                        <div class="form-group " style="margin-left: 10px;">
                            <label for="fournisseur_id">Fournisseur</label>
                            <select name="fournisseur_id" class="form-control mb-3 w-50  @error('fournisseur_id') is-invalid @enderror" required>
                                <option value="">Sélectionner un fournisseur</option>
                                @foreach($fournisseurs as $fournisseur)
                                    <option value="{{ $fournisseur->id }}" {{ old('fournisseur_id') == $fournisseur->id ? 'selected' : '' }}>{{ $fournisseur->name }}</option>
                                @endforeach
                            </select>
                            @error('fournisseur_id')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                       
                        <div class="form-group mb-3" style="margin-left: 10px;">
                            <label for="date_livraison">Date de Livraison</label>
                            <input type="date" name="date_livraison" class="form-control  w-50 @error('date_livraison') is-invalid @enderror" value="{{ old('date_livraison') }}" required>
                            @error('date_livraison')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                      
                         {{-- Products --}}
                        <div class="mb-3" >
                            <label class="form-label" style="margin-left: 10px;">Articles:</label>
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
                        <div class="mb-3" style="margin-left: 10px;">
                            <label for="tva" class="form-label">TVA (%)</label>
                            <input
                                type="number"
                                name="tva"
                                id="tva"
                                class="form-control mb-3 w-25"
                                value="{{ old('tva', 20.00) }}"
                                step="0.01"
                                required
                            >
                        </div>

                        {{-- Total HT --}}
                        <div class="mb-3" style="margin-left: 10px;">
                            <label for="total_ht" class="form-label">Total HT</label>
                            <input
                                type="number"
                                name="total_ht"
                                id="total_ht"
                                class="form-control w-25"
                                step="0.01"
                                readonly
                            >
                        </div>

                        {{-- Total TTC --}}
                        <div class="mb-3" style="margin-left: 10px;">
                            <label for="total_ttc" class="form-label">Total TTC</label>
                            <input
                                type="number"
                                name="total_ttc"
                                id="total_ttc"
                                class="form-control w-25"
                                step="0.01"
                                readonly
                            >
                        </div>

                        {{-- Status --}}
                        <div class="mb-3 w-25" style="margin-left: 10px;">
                            <label for="status" class="form-label">Statut</label>
                            <select name="status" id="status" class="form-control" required>
                                <option value="en_cours" {{ old('status') == 'en_cours' ? 'selected' : '' }}>En cours</option>
                                <option value="partiellement_paye" {{ old('status') == 'partiellement_paye' ? 'selected' : '' }}>Partiellement payé</option>
                                <option value="paye" {{ old('status') == 'paye' ? 'selected' : '' }}>Payé</option>
                             <option value="annule" {{ old('status') == 'annule' ? 'selected' : '' }}>Annulé</option>
                           </select>
                        </div>

                        {{-- Montant Payé (Conditional) --}}
                        <div class="mb-3 w-25" id="montant-paye-container" style="display: none;margin-left: 10px;">
                            <label for="montant_paye" class="form-label">Montant Payé</label>
                            <input
                                type="number"
                                name="montant_paye"
                                id="montant_paye"
                                class="form-control mb-3 "
                                step="0.01"
                                min="0"
                                value="{{ old('montant_paye', '') }}"
                            >
                            <small class="form-text text-muted">Ne doit pas dépasser le total TTC: <span id="max-montant">0.00</span> DH</small>
                        </div>

                        {{-- Notes --}}
                        <div class="mb-3 w-75" style="margin-left: 10px;">
                            <label for="notes" class="form-label">Obs</label>
                            <textarea
                                name="notes"
                                id="notes"
                                rows="2"
                                class="form-control"
                            >{{ old('notes') }}</textarea>
                        </div>
                       
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary">Créer</button>
                        <a href="{{ route('bon-livraisons.index') }}" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let productIndex = 1;

    const products = @json($products);

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
        products.forEach(prod => {
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
<script>
document.addEventListener('DOMContentLoaded', function () {
   
    // Handle montant_paye field visibility
    const statusSelect = document.getElementById('status');
    const montantPayeContainer = document.getElementById('montant-paye-container');
    const montantPayeInput = document.getElementById('montant_paye');
    const maxMontantSpan = document.getElementById('max-montant');
    const totalTtcInput = document.getElementById('total_ttc');

    function toggleMontantPaye() {
        const status = statusSelect.value;
        if (status === 'partiellement_paye' || status === 'paye') {
            montantPayeContainer.style.display = 'block';
            montantPayeInput.required = true;
            // If status is "paye", auto-fill with total_ttc
            if (status === 'paye') {
                montantPayeInput.value = parseFloat(totalTtcInput.value) || 0;
            }
        } else {
            montantPayeContainer.style.display = 'none';
            montantPayeInput.required = false;
            montantPayeInput.value = '';
        }
        updateMaxMontant();
    }

    function updateMaxMontant() {
        const totalTtc = parseFloat(totalTtcInput.value) || 0;
        maxMontantSpan.textContent = totalTtc.toFixed(2);
    }

    // Validate montant_paye doesn't exceed total_ttc
    montantPayeInput.addEventListener('input', function() {
        const totalTtc = parseFloat(totalTtcInput.value) || 0;
        const montantPaye = parseFloat(this.value) || 0;
        
        if (montantPaye > totalTtc) {
            this.value = totalTtc.toFixed(2);
            alert(`Le montant payé ne peut pas dépasser le total TTC (${totalTtc.toFixed(2)} DH)`);
        }
    });

    statusSelect.addEventListener('change', toggleMontantPaye);
    
    // Update max montant when total_ttc changes
    totalTtcInput.addEventListener('change', updateMaxMontant);

    // Initial state
    toggleMontantPaye();
});
</script>

@endsection
