@extends('adminlte::page')

@section('title', 'Modifier Produit')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Modifier Produit</div>

                <div class="card-body">

                    {{-- Validation Errors --}}
                    @if ($errors->any())
                        <div class="alert alert-danger">
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form action="{{ route('products.update', $product) }}" method="POST">
                        @csrf
                        @method('PUT')

                        {{-- Name --}}
                        <div class="form-group">
                            <label>Nom du produit</label>
                            <input type="text"
                                   name="name"
                                   class="form-control"
                                   value="{{ old('name', $product->name) }}"
                                   required>
                        </div>

                        {{-- Description --}}
                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description"
                                      class="form-control"
                                      rows="3">{{ old('description', $product->description) }}</textarea>
                        </div>

                        {{-- Category --}}
                        <div class="form-group">
                            <label>Catégorie</label>
                            <select name="category_id" id="category_id" class="form-control" required>
                                <option value="">-- Sélectionner --</option>
                                @foreach ($categories as $category)
                                    <option value="{{ $category->id }}"
                                        {{ old('category_id', $product->category_id) == $category->id ? 'selected' : '' }}>
                                        {{ $category->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        {{-- Add Category Button --}}
                        <div class="form-group">
                            <button type="button"
                                    class="btn btn-outline-primary"
                                    data-toggle="modal"
                                    data-target="#addCategoryModal">
                                Ajouter une nouvelle catégorie
                            </button>
                        </div>

                        {{-- Quantity --}}
                        <div class="form-group">
                            <label>Quantité</label>
                            <input type="number"
                                   name="quantity"
                                   class="form-control"
                                   value="{{ old('quantity', $product->quantity) }}"
                                   step="0.01"
                                   required>
                        </div>

                        {{-- Min stock --}}
                        <div class="form-group">
                            <label>Stock minimum</label>
                            <input type="number"
                                   name="min_qte"
                                   class="form-control"
                                   value="{{ old('min_qte', $product->min_qte) }}"
                                   step="0.01"
                                   required>
                        </div>

                        {{-- Unit price --}}
                        <div class="form-group">
                            <label>Prix unitaire</label>
                            <input type="number"
                                   name="unit_price"
                                   class="form-control"
                                   value="{{ old('unit_price', $product->unit_price) }}"
                                   step="0.01"
                                   required>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('products.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Mettre à jour</button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

{{-- MODAL --}}
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form id="addCategoryForm" action="{{ route('categories.store_live') }}" method="POST">
                @csrf

                <div class="modal-header">
                    <h5 class="modal-title">Ajouter une catégorie</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Nom de la catégorie</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </div>

            </form>

        </div>
    </div>
</div>
@endsection

@push('js')
<script>
$(document).ready(function () {

    $('#addCategoryForm').on('submit', function (e) {
        e.preventDefault();

        let form = $(this);

        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',

            success: function (data) {
                console.log('SUCCESS:', data);
               
                $('#category_id').append(
                    $('<option>', {
                        value: data.id,
                        text: data.name,
                        selected: true
                    })
                );

                $('#addCategoryModal').modal('hide');
                form[0].reset();
            },

            error: function (xhr) {
                console.log('ERROR:', xhr.responseText);
                alert('Erreur: ' + xhr.responseText);
            }
        });
    });

});
</script>
@endpush

