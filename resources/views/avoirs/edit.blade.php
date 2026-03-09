@extends('adminlte::page')

@section('title', 'Modifier un Avoir')

@section('content')
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Modifier un Avoir - Retour d'articles</h3>
                    <a href="{{ route('avoirs.index') }}" class="btn btn-secondary btn-sm float-right">Retour</a>
                </div>
                <div class="card-body">
                    <form action="{{ route('avoirs.update', $avoir) }}" method="POST" id="avoirForm">
                        @csrf
                        @method('PUT')

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="client_id">Client <span class="text-danger">*</span></label>
                                    <select name="client_id" id="client_id" class="form-control @error('client_id') is-invalid @enderror" required>
                                        <option value="">Sélectionner un client</option>
                                        @foreach($clients as $client)
                                            <option value="{{ $client->id }}" {{ (isset($source) && $source->client_id == $client->id) || old('client_id', $avoir->client_id) == $client->id ? 'selected' : '' }}>
                                                {{ $client->name }}
                                            </option>
                                        @endforeach
                                    </select>
                                    @error('client_id')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="date_avoir">Date d'Avoir <span class="text-danger">*</span></label>
                                    <input type="date" name="date_avoir" id="date_avoir" class="form-control @error('date_avoir') is-invalid @enderror"
                                           value="{{ old('date_avoir', $avoir->date_avoir) }}" required>
                                    @error('date_avoir')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="tva">TVA (%) <span class="text-danger">*</span></label>
                                    <input type="number" step="1" name="tva" id="tva" class="form-control @error('tva') is-invalid @enderror"
                                           value="{{ old('tva', $avoir->tva) }}" required>
                                    @error('tva')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                        </div>
                        <div class="form-group mt-3">
                            <label for="motif">Motif général du retour</label>
                            <textarea name="motif" id="motif" class="form-control @error('motif') is-invalid @enderror" rows="2">{{ old('motif', $avoir->motif) }}</textarea>
                            @error('motif')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="bon_livraison_id">Bon de Livraison</label>
                                    <select name="bon_livraison_id" id="bon_livraison_id" class="form-control @error('bon_livraison_id') is-invalid @enderror">
                                        <option value="">Sélectionner un bon de livraison</option>
                                        @foreach($bonLivraisons as $bonLivraison)
                                            <option value="{{ $bonLivraison->id }}" data-type="bon_livraison" {{ old('bon_livraison_id', $avoir->bon_livraison_id) == $bonLivraison->id ? 'selected' : '' }}>
                                                {{ $bonLivraison->numero_bon_livraison }} - {{ $bonLivraison->client->name ?? 'N/A' }}
                                            </option>
                                        @endforeach
                                    </select>
                                    @error('bon_livraison_id')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="facture_id">Facture</label>
                                    <select name="facture_id" id="facture_id" class="form-control @error('facture_id') is-invalid @enderror">
                                        <option value="">Sélectionner une facture</option>
                                        @foreach($factures as $facture)
                                            <option value="{{ $facture->id }}" data-type="facture" {{ old('facture_id', $avoir->facture_id) == $facture->id ? 'selected' : '' }}>
                                                {{ $facture->numero_facture }} - {{ $facture->client->name ?? 'N/A' }}
                                            </option>
                                        @endforeach
                                    </select>
                                    @error('facture_id')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                        </div>




                        <!-- Articles du document source -->
                        <div id="sourceArticles" class="card mt-4" style="display: none;">
                            <div class="card-header">
                                <h4 class="card-title">Articles disponibles pour retour</h4>
                                <small class="text-muted">Sélectionnez les articles et quantités à retourner</small>
                            </div>
                            <div class="card-body">
                                <div id="sourceProductsList" class="table-responsive">
                                    <!-- Products from source will be loaded here -->
                                </div>
                            </div>
                        </div>

                        <!-- Sélection d'articles personnalisée -->
                        <div class="card mt-4">
                            <div class="card-header">
                                <h4 class="card-title">Articles à retourner</h4>
                                <button type="button" id="addProduct" class="btn btn-success btn-sm float-right">+ Ajouter un article</button>
                            </div>
                            <div class="card-body">
                                <div id="productsContainer">
                                    <!-- Product rows will be added here -->
                                </div>
                                <div class="form-group mt-3">
                                    <label for="notes">Notes supplémentaires</label>
                                    <textarea name="notes" id="notes" class="form-control @error('notes') is-invalid @enderror" rows="2">{{ old('notes', $avoir->notes) }}</textarea>
                                    @error('notes')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="row mt-4 border-top pt-3">
                                    <div class="col-md-3">
                                        <h5>Total HT: <span id="totalHT" class="text-primary">0.00</span> DH</h5>
                                    </div>
                                    <div class="col-md-3">
                                        <h5>TVA (<span id="tvaPercent">20</span>%): <span id="totalTVA" class="text-primary">0.00</span> DH</h5>
                                    </div>
                                    <div class="col-md-3">
                                        <h5>Total TTC: <span id="totalTTC" class="text-success">0.00</span> DH</h5>
                                    </div>
                                </div>
                                
                            </div>
                        </div>

                        <div class="form-group mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-save"></i> Editer
                            </button>
                            <a href="{{ route('avoirs.index') }}" class="btn btn-secondary btn-lg">Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@section('js')
<script>
   

$(document).ready(function() {
     let productIndex = 0;

     // Define functions first
     function addProductRow(productId = '', productName = '', unitPrice = '', quantity = 1, motifRetour = '') {
        const rowHtml = `
            <div class="product-row row mb-3 border-bottom pb-3 p-3 bg-light" data-index="${productIndex}">
                <div class="col-md-3">
                    <label><strong>Produit</strong></label>
                    <select name="products[${productIndex}][product_id]" class="form-control product-select" required>
                        <option value="">Sélectionner un produit</option>
                        @foreach(\App\Models\Product::all() as $product)
                            <option value="{{ $product->id }}" data-price="{{ $product->price }}" ${productId == {{ $product->id }} ? 'selected' : ''}>
                                {{ $product->name }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-1">
                    <label><strong>Quantité</strong></label>
                    <input type="number" name="products[${productIndex}][quantity]" class="form-control quantity-input" value="${quantity}" min="1" required>
                </div>
                <div class="col-md-2">
                    <label><strong>Prix Unitaire DH</strong></label>
                    <input type="number" step="0.01" name="products[${productIndex}][unit_price]" class="form-control unit-price-input" value="${unitPrice}" min="0" required>
                </div>
                <div class="col-md-2">
                    <label><strong>Total DH</strong></label>
                    <input type="number" step="0.01" class="form-control total-input" readonly>
                </div>
                <div class="col-md-2">
                    <label><strong>Ajouter au stock</strong></label>
                    <div class="form-check">
                        <input type="checkbox" name="products[${productIndex}][add_to_stock]" class="form-check-input" id="addStock${productIndex}">
                        <label class="form-check-label" for="addStock${productIndex}">
                            Ajouter la qté au stock
                        </label>
                    </div>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-danger btn-sm w-100 remove-product">
                        <i class="fas fa-trash"></i> Supprimer
                    </button>
                </div>
                <div class="col-md-12 mt-2">
                    <label><strong>Motif du retour</strong></label>
                    <input type="text" name="products[${productIndex}][motif_retour]" class="form-control motif-input" placeholder="Ex: Produit défectueux, non conforme, etc." value="${motifRetour}">
                </div>
            </div>
        `;
        $('#productsContainer').append(rowHtml);
        productIndex++;
        updateTotals();
     }

     function updateRowTotal($row) {
        const quantity = parseFloat($row.find('.quantity-input').val()) || 0;
        const unitPrice = parseFloat($row.find('.unit-price-input').val()) || 0;
        const total = quantity * unitPrice;
        $row.find('.total-input').val(total.toFixed(2));
        updateTotals();
     }

     function updateTotals() {
        let totalHT = 0;
        $('.product-row').each(function() {
            const quantity = parseFloat($(this).find('.quantity-input').val()) || 0;
            const unitPrice = parseFloat($(this).find('.unit-price-input').val()) || 0;
            totalHT += quantity * unitPrice;
        });

        const tvaRate = parseFloat($('#tva').val()) || 0;
        const totalTVA = totalHT * (tvaRate / 100);
        const totalTTC = totalHT + totalTVA;

        $('#totalHT').text(totalHT.toFixed(2));
        $('#totalTVA').text(totalTVA.toFixed(2));
        $('#totalTTC').text(totalTTC.toFixed(2));
     }

     window.addProductRowFromSource = function(productId, productName, unitPrice, quantity, motif = '') {
        const rowHtml = `
            <div class="product-row row mb-3 border-bottom pb-3 p-3 bg-light" data-index="${productIndex}" data-product-id="${productId}">
                <div class="col-md-4">
                    <label><strong>Produit</strong></label>
                    <input type="hidden" name="products[${productIndex}][product_id]" value="${productId}">
                    <input type="text" class="form-control" value="${productName}" disabled>
                </div>
                <div class="col-md-2">
                    <label><strong>Quantité</strong></label>
                    <input type="number" name="products[${productIndex}][quantity]" class="form-control quantity-input" value="${quantity}" min="1" required>
                </div>
                <div class="col-md-2">
                    <label><strong>Prix Unitaire DH</strong></label>
                    <input type="number" step="0.01" name="products[${productIndex}][unit_price]" class="form-control unit-price-input" value="${parseFloat(unitPrice).toFixed(2)}" min="0" required readonly>
                </div>
                <div class="col-md-2">
                    <label><strong>Total DH</strong></label>
                    <input type="number" step="0.01" class="form-control total-input" readonly>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="button" class="btn btn-danger btn-sm w-100 remove-product">
                        <i class="fas fa-trash"></i> Supprimer
                    </button>
                </div>
                <div class="col-md-12 mt-2">
                    <label><strong>Motif du retour</strong></label>
                    <input type="text" name="products[${productIndex}][motif_retour]" class="form-control motif-input" placeholder="Ex: Produit défectueux, non conforme, etc." value="${motif}">
                </div>
            </div>
        `;
        
        $('#productsContainer').append(rowHtml);
        productIndex++;
        updateRowTotal($('#productsContainer').find('[data-index="' + (productIndex - 1) + '"]'));
     };

     window.loadDocumentProducts = function(documentId, documentType) {
        if (!documentId) {
            $('#sourceArticles').slideUp();
            return;
        }

        console.log('Loading document:', documentType, documentId);

        $.ajax({
            url: '/get-document-articles',
            type: 'POST',
            data: {
                document_id: documentId,
                document_type: documentType,
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                console.log('Response received:', response);
                
                if (response.products && response.products.length > 0) {
                    let html = '<table class="table table-striped table-sm">';
                    html += '<thead><tr><th>Produit</th><th>Prix Unit.</th><th>Qté Originale</th><th>Qté à Retourner</th><th>Motif</th><th>Action</th></tr></thead><tbody>';
                    
                    response.products.forEach(function(product) {
                        const rowId = 'source-row-' + product.id;
                        console.log('Processing product:', product);
                        html += `<tr id="${rowId}">
                            <td>${product.name}</td>
                            <td>${parseFloat(product.pivot.unit_price).toFixed(2)} DH</td>
                            <td>${product.pivot.quantity}</td>
                            <td>
                                <input type="number" class="form-control form-control-sm qty-input" data-product-id="${product.id}" 
                                       data-product-name="${product.name}" data-product-price="${product.pivot.unit_price}"
                                       min="0" max="${product.pivot.quantity}" value="0">
                            </td>
                            <td>
                                <input type="text" class="form-control form-control-sm motif-input" placeholder="Motif du retour">
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-primary add-to-return" data-row-id="${rowId}">
                                    <i class="fas fa-plus"></i> Ajouter
                                </button>
                            </td>
                        </tr>`;
                    });
                    
                    html += '</tbody></table>';
                    $('#sourceProductsList').html(html);
                    $('#sourceArticles').slideDown();

                    // Handler for adding product to return list
                    $('.add-to-return').on('click', function(e) {
                        e.preventDefault();
                        const rowId = $(this).data('row-id');
                        const $row = $('#' + rowId);
                        const qty = parseInt($row.find('.qty-input').val()) || 0;
                        const motif = $row.find('.motif-input').val() || '';

                        if (qty > 0) {
                            const productId = $row.find('.qty-input').data('product-id');
                            const productName = $row.find('.qty-input').data('product-name');
                            const productPrice = $row.find('.qty-input').data('product-price');
                            
                            // Clear the inputs
                            $row.find('.qty-input').val(0);
                            $row.find('.motif-input').val('');

                            // Check if product already in return list
                            const $existingRow = $('#productsContainer').find(`[data-product-id="${productId}"]`).closest('.product-row');
                            if ($existingRow.length) {
                                const currentQty = parseInt($existingRow.find('.quantity-input').val());
                                $existingRow.find('.quantity-input').val(currentQty + qty).trigger('input');
                                if (motif) {
                                    $existingRow.find('.motif-input').val(motif);
                                }
                            } else {
                                // Add as new row
                                addProductRowFromSource(productId, productName, productPrice, qty, motif);
                            }
                        } else {
                            alert('Veuillez entrer une quantité supérieure à 0.');
                        }
                    });
                } else {
                    console.log('No products found');
                    $('#sourceArticles').slideUp();
                }
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', error, xhr.responseText);
                alert('Erreur lors du chargement des articles.');
            }
        });
     };

     // Load existing products
     @if($avoir->products->count() > 0)
        @foreach($avoir->products as $product)
            addProductRowFromSource({{ $product->id }}, '{{ $product->name }}', {{ $product->pivot->unit_price }}, {{ $product->pivot->quantity }}, '{{ $product->pivot->motif_retour ?? '' }}');
        @endforeach
        updateTotals();
     @endif
 
    // Filter Bon Livraison and Facture by selected client
    $('#client_id').on('change', function() {
        const clientId = $(this).val();
       
        // Clear selections
        $('#bon_livraison_id').val('').find('option').not(':first').remove();
        $('#facture_id').val('').find('option').not(':first').remove();
        $('#sourceArticles').slideUp();

        if (!clientId) {
            // Reload all options
            location.reload();
            return;
        }

        // Load documents for selected client
        $.ajax({
            url: '/get-client-documents',
            type: 'GET',
            data: { client_id: clientId },
            success: function(response) {
                // Add bon livraisons
                if (response.bonLivraisons && response.bonLivraisons.length > 0) {
                    response.bonLivraisons.forEach(function(bl) {
                        $('#bon_livraison_id').append(`
                            <option value="${bl.id}" data-client-id="${bl.client_id}">
                                ${bl.numero_bon_livraison}
                            </option>
                        `);
                    });
                }

                // Add factures
                if (response.factures && response.factures.length > 0) {
                    response.factures.forEach(function(f) {
                        $('#facture_id').append(`
                            <option value="${f.id}" data-client-id="${f.client_id}">
                                ${f.numero_facture}
                            </option>
                        `);
                    });
                }
            },
            error: function(e) {
                console.error('Erreur lors du chargement des documents:', e);
                alert('Erreur lors du chargement des documents');
            }
        });
    });

    // Event listeners for document selection
    $('#bon_livraison_id').on('change', function() {
        if (this.value) {
            loadDocumentProducts(this.value, 'bon_livraison');
        } else {
            $('#sourceArticles').slideUp();
        }
    });

    $('#facture_id').on('change', function() {
        if (this.value) {
            loadDocumentProducts(this.value, 'facture');
        } else {
            $('#sourceArticles').slideUp();
        }
    });

    // Add product button
    $('#addProduct').click(function() {
        addProductRow();
    });

    // Update TVA percent display
    $('#tva').on('change', function() {
        $('#tvaPercent').text($(this).val());
        updateTotals();
    });

    $(document).on('change', '.product-select', function() {
        const selectedOption = $(this).find('option:selected');
        const price = selectedOption.data('price') || 0;
        $(this).closest('.product-row').find('.unit-price-input').val(price.toFixed(2));
        updateRowTotal($(this).closest('.product-row'));
    });

    $(document).on('input', '.quantity-input, .unit-price-input', function() {
        updateRowTotal($(this).closest('.product-row'));
    });

    $(document).on('click', '.remove-product', function() {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce produit de l\'avoir?')) {
            $(this).closest('.product-row').remove();
            updateTotals();
        }
    });


    // Form validation
    $('#avoirForm').on('submit', function() {
        const productCount = $('#productsContainer .product-row').length;
        if (productCount === 0) {
            alert('Veuillez ajouter au moins un article à retourner.');
            return false;
        }
        return true;
    });
});
</script>
@endsection
@endsection