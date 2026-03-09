@extends('adminlte::page')

@section('title', 'Modifier un Bon de Livraison')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-warning">
                <div class="card-header">
                    <h3 class="card-title">Modifier un Bon de Récéption</h3>
                </div>
                <form method="POST" action="{{ route('achats.update', $Achat) }}">
                    @csrf
                    @method('PUT')
                    <div class="card-body">
                        <div class="form-group">
                            <label for="numero_achat">Numéro du Bon</label>
                            <input type="text" name="numero_achat" class="form-control @error('numero_achat') is-invalid @enderror" value="{{ old('numero_achat', $Achat->numero_achat) }}" required>
                            @error('numero_achat')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="fournisseur_id">fournisseur</label>
                            <select name="fournisseur_id" class="form-control @error('fournisseur_id') is-invalid @enderror" required>
                                <option value="">Sélectionner un fournisseur</option>
                                @foreach($fournisseurs as $fournisseur)
                                    <option value="{{ $fournisseur->id }}" {{ old('fournisseur_id', $Achat->fournisseur_id) == $fournisseur->id ? 'selected' : '' }}>{{ $fournisseur->name }}</option>
                                @endforeach
                            </select>
                            @error('fournisseur_id')
                                <span class="invalid-feedback">{{ $message }}</span>
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
                                    @foreach($Achat->products as $index => $product)
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
                                    @if($Achat->products->isEmpty())
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
                        <div class="form-group">
                            <label for="date_livraison">Date de Livraison</label>
                            <input type="date" name="date_livraison" class="form-control @error('date_livraison') is-invalid @enderror" value="{{ old('date_livraison', $Achat->date_livraison) }}" required>
                            @error('date_livraison')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ht">Total HT</label>
                            <input type="number" step="0.01" id="total_ht" name="total_ht" class="form-control @error('total_ht') is-invalid @enderror" value="{{ old('total_ht', $Achat->total_ht) }}" required>
                            @error('total_ht')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="tva">TVA (%)</label>
                            <input type="number" step="0.01" id="tva" name="tva" class="form-control @error('tva') is-invalid @enderror" value="{{ old('tva', $Achat->tva) }}" required>
                            @error('tva')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ttc">Total TTC</label>
                            <input type="number" step="0.01" id="total_ttc" name="total_ttc" class="form-control @error('total_ttc') is-invalid @enderror" value="{{ old('total_ttc', $Achat->total_ttc) }}" required>
                            @error('total_ttc')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="status">Statut</label>
                            <select name="status" class="form-control @error('status') is-invalid @enderror" required id="status">
                                <option value="en_cours" {{ old('status', $Achat->status) == 'en_cours' ? 'selected' : '' }}>En Cours</option>
                                <option value="partiellement_paye" {{ old('status', $Achat->status) == 'partiellement_paye' ? 'selected' : '' }}>Partiellement Payé</option>
                                  <option value="paye" {{ old('status') == 'paye' ? 'selected' : '' }}>Payé</option>
                            <option value="annulé" {{ old('status', $Achat->status) == 'annulé' ? 'selected' : '' }}>Annulée</option>
                            </select>
                            @error('status')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    {{-- Montant Payé (Conditional) --}}
                        <div class=" form-group " id="montant-paye-container" style="margin-left: 10px;">
                            <label for="montant_paye" class="form-label">Montant Payé</label>
                            <input
                                type="number"
                                name="montant_paye"
                                id="montant_paye"
                                class="form-control mb-3 w-25"
                                step="0.01"
                                min="0"
                                value="{{ old('montant_paye', $Achat->montant_paye) }}" 
                            >
                            <small class="form-text text-muted">Ne doit pas dépasser le total TTC: <span id="max-montant">0.00</span> DH</small>
                        </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-warning">Mettre à Jour</button>
                        <a href="{{ route('bon-livraisons.index') }}" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    let productIndex = {{ $Achat->products->count() }};

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
           /// montantPayeContainer.style.display = 'none';
            montantPayeInput.required = false;
           //// montantPayeInput.value = '';
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

