@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Ajouter Article</div>

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

                    <form action="{{ route('products.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                         {{-- category_id --}}
                        <div class="mb-3">
                            <label for="category_id" class="form-label">Catégorie</label>
                            <select name="category_id" id="category_id" class="form-control" required>
                                <option value="">Sélectionner une catégorie</option>
                                @foreach($categories as $category)
                                    <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                                @endforeach
                            </select>
                        </div>
                         {{-- Add Category Button --}}
                        <div class="form-group">
                            <button type="button"
                                    class="btn btn btn-sm btn-outline-primary"
                                    data-toggle="modal"
                                    data-target="#addCategoryModal">
                                Ajouter une nouvelle catégorie
                            </button>
                        </div>
                        {{-- Product Name --}}
                        <div class="mb-3">
                            <label for="name" class="form-label">Nom Article</label>
                            <input
                                type="text"
                                name="name"
                                id="name"
                                class="form-control"
                                value="{{ old('name') }}"
                                required
                            >
                        </div>
                        {{-- unite_id --}}
                        <div class="mb-3">
                            <label for="unite_id" class="form-label">Unité</label>
                            <select name="unite_id" id="unite_id" class="form-control" required>
                                <option value="">Sélectionner une unité</option>
                                @foreach($unites as $unite)
                                    <option value="{{ $unite->id }}" {{ old('unite_id') == $unite->id ? 'selected' : '' }}>{{ $unite->name }}</option>
                                @endforeach
                            </select>
                        </div> 
                        {{-- Add Unite Button --}}
                        <div class="form-group">
                            <button type="button"
                                    class="btn btn btn-sm btn-outline-primary"
                                    data-toggle="modal"
                                    data-target="#addUniteModal">
                                Ajouter une nouvelle unité
                            </button>
                        </div> 
                        {{-- Description --}}
                        <div class="mb-3">
                            <label for="description" class="form-label">Déscription</label>
                            <textarea
                                name="description"
                                id="description"
                                rows="4"
                                class="form-control"
                            >{{ old('description') }}</textarea>
                        </div>
                          {{-- Quantity --}}
                        <div class="form-group">
                            <label>Quantité</label>
                            <input type="number"
                                   name="quantity"
                                   class="form-control"
                                   value="{{ old('quantity') }}"
                                   step="0.01"
                                   required>
                        </div>
                        {{-- Price --}}
                        <div class="mb-3">
                            <label for="price" class="form-label">Prix</label>
                            <input
                                type="number"
                                step="0.01"
                                name="unit_price"
                                id="unit_price"
                                class="form-control"
                                value="{{ old('unit_price') }}"
                                required
                            >
                        </div>

                        {{-- Quantity --}}
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Qté minimal</label>
                            <input
                                type="number"
                                name="min_qte"
                                id="min_qte"
                                class="form-control"
                                value="{{ old('min_qte') }}"
                            >
                        </div>
                        </div>


                        {{-- Product Image 
                        <div class="mb-3">
                            <label for="image" class="form-label">Product Image</label>
                            <input
                                type="file"
                                name="image"
                                id="image"
                                class="form-control"
                            >
                        </div>
--}}
                        {{-- Submit --}}
                        <div class="d-flex justify-content-between">
                            <a href="{{ route('products.index') }}" class="btn btn-secondary">
                                Back
                            </a>
                            <button type="submit" class="btn btn-primary">
                               Valider
                            </button>
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
{{-- MODAL --}}
<div class="modal fade" id="addUniteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form id="addUniteForm" action="{{ route('unites.store_live') }}" method="POST">
                @csrf

                <div class="modal-header">
                    <h5 class="modal-title">Ajouter une unité</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Nom unité</label>
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

    $('#addUniteForm').on('submit', function (e) {
        e.preventDefault();

        let form = $(this);

        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',

            success: function (data) {
                console.log('SUCCESS:', data);
               
                $('#unite_id').append(
                    $('<option>', {
                        value: data.id,
                        text: data.name,
                        selected: true
                    })
                );

                $('#addUniteModal').modal('hide');
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

