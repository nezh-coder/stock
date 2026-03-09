@extends('adminlte::page')

@section('title', 'Modifier un Bon de Livraison')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card card-warning">
                <div class="card-header">
                    <h3 class="card-title">Modifier un Bon de Livraison</h3>
                </div>
                <form method="POST" action="{{ route('bon-livraisons.update', $bonLivraison) }}">
                    @csrf
                    @method('PUT')
                    <div class="card-body">
                        <div class="form-group">
                            <label for="numero_bon_livraison">Numéro du Bon de Livraison</label>
                            <input type="text" name="numero_bon_livraison" class="form-control @error('numero_bon_livraison') is-invalid @enderror" value="{{ old('numero_bon_livraison', $bonLivraison->numero_bon_livraison) }}" required>
                            @error('numero_bon_livraison')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="client_id">Client</label>
                            <select name="client_id" class="form-control @error('client_id') is-invalid @enderror" required>
                                <option value="">Sélectionner un client</option>
                                @foreach($clients as $client)
                                    <option value="{{ $client->id }}" {{ old('client_id', $bonLivraison->client_id) == $client->id ? 'selected' : '' }}>{{ $client->name }}</option>
                                @endforeach
                            </select>
                            @error('client_id')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="bon_commande_id">Bon de Commande</label>
                            <select name="bon_commande_id" id="bon_commande_id" class="form-control @error('bon_commande_id') is-invalid @enderror">
                                <option value="">Sélectionner un bon de commande (optionnel)</option>
                                @foreach($bonCommandes as $bonCommande)
                                    <option value="{{ $bonCommande->id }}" {{ old('bon_commande_id', $bonLivraison->bon_commande_id) == $bonCommande->id ? 'selected' : '' }}>{{ $bonCommande->numero_bon_commande }}</option>
                                @endforeach
                            </select>
                            @error('bon_commande_id')
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
                                    @foreach($bonLivraison->products as $index => $product)
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
                                    @if($bonLivraison->products->isEmpty())
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
                            <input type="date" name="date_livraison" class="form-control @error('date_livraison') is-invalid @enderror" value="{{ old('date_livraison', $bonLivraison->date_livraison) }}" required>
                            @error('date_livraison')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ht">Total HT</label>
                            <input type="number" step="0.01" id="total_ht" name="total_ht" class="form-control @error('total_ht') is-invalid @enderror" value="{{ old('total_ht', $bonLivraison->total_ht) }}" required>
                            @error('total_ht')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="tva">TVA (%)</label>
                            <input type="number" step="0.01" id="tva" name="tva" class="form-control @error('tva') is-invalid @enderror" value="{{ old('tva', $bonLivraison->tva) }}" required>
                            @error('tva')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="total_ttc">Total TTC</label>
                            <input type="number" step="0.01" id="total_ttc" name="total_ttc" class="form-control @error('total_ttc') is-invalid @enderror" value="{{ old('total_ttc', $bonLivraison->total_ttc) }}" required>
                            @error('total_ttc')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="status">Statut</label>
                            <select name="status" class="form-control @error('status') is-invalid @enderror" required>
                                <option value="En attente" {{ old('status', $bonLivraison->status) == 'En attente' ? 'selected' : '' }}>En Attente</option>
                                <option value="livré" {{ old('status', $bonLivraison->status) == 'livré' ? 'selected' : '' }}>Livrée</option>
                                <option value="annulé" {{ old('status', $bonLivraison->status) == 'annulé' ? 'selected' : '' }}>Annulée</option>
                            </select>
                            @error('status')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
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
    let productIndex = {{ $bonLivraison->products->count() }};

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

    // Bon Commande change
    document.getElementById('bon_commande_id').addEventListener('change', function() {
        const bonCommandeId = this.value;
        if (bonCommandeId) {
            fetch(`{{ url('bon-livraisons/get-products') }}/${bonCommandeId}`)
                .then(response => response.json())
                .then(fetchedProducts => {
                    // Clear existing products
                    const tbody = document.getElementById('products-body');
                    tbody.innerHTML = '';
                    productIndex = 0;

                    fetchedProducts.forEach(product => {
                        const row = document.createElement('tr');
                        row.className = 'product-row';
                        let options = '<option value="">Sélectionner un produit</option>';
                        allProducts.forEach(prod => {
                            const selected = prod.id == product.id ? 'selected' : '';
                            options += `<option value="${prod.id}" data-price="${prod.unit_price}" ${selected}>${prod.name}</option>`;
                        });
                        row.innerHTML = `
                            <td>
                                <select name="products[${productIndex}][product_id]" class="form-control product-select" required>
                                    ${options}
                                </select>
                            </td>
                            <td>
                                <input type="number" name="products[${productIndex}][quantity]" class="form-control quantity" min="1" value="${product.quantity}" required>
                            </td>
                            <td>
                                <input type="number" name="products[${productIndex}][unit_price]" class="form-control unit-price" step="0.01" min="0" value="${product.unit_price}" required>
                            </td>
                            <td>
                                <input type="number" class="form-control total" step="0.01" value="${product.total}" readonly>
                            </td>
                            <td>
                                <button type="button" class="btn btn-danger remove-product">Supprimer</button>
                            </td>
                        `;
                        tbody.appendChild(row);
                        attachRowEvents(row);
                        productIndex++;
                    });
                    calculateGrandTotals();
                })
                .catch(error => console.error('Error fetching products:', error));
        } else {
            // Clear products if no bon commande selected
            document.getElementById('products-body').innerHTML = '';
            productIndex = 0;
            calculateGrandTotals();
        }
    });

    // Initial calculation
    calculateGrandTotals();
});
</script>


@endsection

