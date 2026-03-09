@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Ajouter Catégorie</div>

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

                    <form action="{{ route('categories.update',$category) }}" method="POST" >
                        @csrf
                         {{-- name --}}
                       @method('PUT')
                        <div class="mb-3">
                            <label for="name" class="form-label">Nom Catégorie</label>
                            <input
                                type="text"
                                name="name"
                                id="name"
                                class="form-control"
                                value="{{ old('name', $category->name) }}"
                                required
                            >
                        </div>

                        {{-- Description --}}
                        <div class="mb-3">
                            <label for="description" class="form-label">Déscription</label>
                            <textarea
                                name="description"
                                id="description"
                                rows="4"
                                class="form-control"
                            >{{ old('description', $category->description) }}</textarea>
                        </div>

                        
                        {{-- Submit --}}
                        <div class="d-flex justify-content-between">
                            <a href="{{ route('categories.index') }}" class="btn btn-secondary">
                                Back
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Editer
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
@endsection
