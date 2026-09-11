@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-11">

            <div class="card">
                <div class="card-header">Créer un Devis</div>

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

                    <form action="{{ route('devis.store') }}" method="POST">
                        @csrf

                        {{-- Numero Devis --}}
                       <div class="row mb-3">
    <div class="col-md-6">
        <label for="num" class="form-label">Numéro du Devis</label>
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
                            <label for="client_id" class="form-label">Client</label>
                            <select name="client_id" id="client_id" class="form-control" required>
                                <option value="">Sélectionner un client</option>
                                @foreach($clients as $client)
                                    <option value="{{ $client->id }}" {{ old('client_id') == $client->id ? 'selected' : '' }}>{{ $client->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        {{-- Date Devis --}}
                        <div class="mb-3">
                            <label for="date_devis" class="form-label">Date du Devis</label>
                            <input
                                type="date"
                                name="date_devis"
                                id="date_devis"
                                class="form-control"
                                value="{{ old('date_devis') }}"
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
                                        <th>Prix Achat</th>
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
                                                  <input disabled=true type="number" name="products[0][prix_achat]" class="form-control prix-achat"  >
                                        </td>
                                         <td>
                                            <input type="number" name="products[0][unit_price]" class="form-control unit-price" step="0.01" min="0" required>
                                        </td>
                                        <td>
                                            <input type="number" class="form-control total" step="0.01" readonly>
                                        </td>
                                        <td class="d-flex">
                                             <button type="button" class="btn btn-danger  mr-1 remove-product" title="Supprimer" >
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            <button type="button" class="btn btn-info mr-1 show-product-info" title="Voir" data-product-id="">
                                                <i class="fas fa-info-circle"></i>
                                            </button>
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
                               <!--- <option value="brouillon" {{ old('status') == 'brouillon' ? 'selected' : '' }}>Brouillon</option>
                               --> <option value="envoye" {{ old('status') == 'envoye' ? 'selected' : '' }}>Envoyé</option>
                                <option value="accepte" {{ old('status') == 'accepte' ? 'selected' : '' }}>Accepté</option>
                                <option value="refuse" {{ old('status') == 'refuse' ? 'selected' : '' }}>Refusé</option>
                            </select>
                        </div>

                        {{-- Notes --}}
                        <div class="mb-3">
                            <label for="notes" class="form-label">Obs</label>
                            <textarea
                                name="notes"
                                id="notes"
                                rows="4"
                                class="form-control"
                            >{{ old('notes') }}</textarea>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('devis.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Créer Devis</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="{{ asset('js/inputmask.min.js') }}"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    let productIndex = 1;
Inputmask("9999", { placeholder: "" }).mask(document.getElementById('num'));
Inputmask("9999").mask(document.getElementById('annee'));

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
              <input disabled=true type="number" name="products[${productIndex}][prix_achat]" class="form-control prix-achat"  >
           </td>
            <td>
                <input type="number" name="products[${productIndex}][unit_price]" class="form-control unit-price" step="0.01" min="0" required>
            </td>
            <td>
                <input type="number" class="form-control total" step="0.01" readonly>
            </td>
            <td>
                <button type="button" class="btn btn-danger remove-product">Supprimer</button>
                <button type="button" class="btn btn-info btn-sm ms-2" data-product-id="">Voir Détails</button>
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
             // Récupérer le dernier prix d'achat
                    const productId = this.value;
                    if (productId) {
                        fetch(`/api/products/${productId}/last-purchase-price`)
                            .then(response => response.json())
                            .then(data => {
                                row.querySelector('.prix-achat').value = data.prix_achat !== null ? data.prix_achat : '';
                            });
                           
                    } else {
                        row.querySelector('.prix-achat').value = '';
                    }
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

// Ajout gestion bouton info produit
document.querySelectorAll('.show-product-info').forEach(function(btn) {
    btn.addEventListener('click', function() {
        const row = btn.closest('.product-row');
        const productSelect = row.querySelector('.product-select');
        const productId = productSelect.value;
        if (!productId) return;
        // Charger les infos via AJAX
        fetch(`/api/products/${productId}/info`)
            .then(response => response.json())
            .then(data => {
                // Remplir les tabs
                document.getElementById('devis-content').innerHTML = data.devisHtml || '<em>Aucun devis accepté</em>';
                document.getElementById('br-content').innerHTML = data.brHtml || '<em>Aucun BR</em>';
                document.getElementById('bl-content').innerHTML = data.blHtml || '<em>Aucun BL</em>';
                // Afficher le modal
                var modal = new bootstrap.Modal(document.getElementById('productInfoModal'));
                modal.show();
            });
    });
});

// Correction activation des tabs Bootstrap
var tabElList = [].slice.call(document.querySelectorAll('#productInfoTabs button'));
tabElList.forEach(function(tabEl) {
    tabEl.addEventListener('click', function (event) {
        event.preventDefault();
        var tab = new bootstrap.Tab(tabEl);
        tab.show();
    });
});
</script>


@endsection

<!-- Modal Produit Info -->
<div class="modal fade" id="productInfoModal" tabindex="-1" aria-labelledby="productInfoModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="productInfoModalLabel">Informations sur le produit</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul class="nav nav-tabs" id="productInfoTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="devis-tab" data-bs-toggle="tab" data-bs-target="#devis" type="button" role="tab" aria-controls="devis" aria-selected="true">Devis Accepté</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="br-tab" data-bs-toggle="tab" data-bs-target="#br" type="button" role="tab" aria-controls="br" aria-selected="false">Bon de Réception</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="bl-tab" data-bs-toggle="tab" data-bs-target="#bl" type="button" role="tab" aria-controls="bl" aria-selected="false">Bon de Livraison</button>
          </li>
        </ul>
        <div class="tab-content mt-3" id="productInfoTabsContent">
          <div class="tab-pane fade show active" id="devis" role="tabpanel" aria-labelledby="devis-tab">
            <div id="devis-content"></div>
          </div>
          <div class="tab-pane fade" id="br" role="tabpanel" aria-labelledby="br-tab">
            <div id="br-content"></div>
          </div>
          <div class="tab-pane fade" id="bl" role="tabpanel" aria-labelledby="bl-tab">
            <div id="bl-content"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS (si non inclus) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>