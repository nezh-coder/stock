@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Modifier Fournisseur</div>

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

                    <form action="{{ route('fournisseurs.update', $fournisseur) }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')

                        {{-- fournisseur Name --}}
                        <div class="mb-3">
                            <label for="name" class="form-label">Nom du Fournisseur</label>
                            <input
                                type="text"
                                name="name"
                                id="name"
                                class="form-control"
                                value="{{ old('name', $fournisseur->name) }}"
                                required
                            >
                        </div>
                         <div class="mb-3">
                            <label for="unit_price" class="form-label">Tél</label>
                            <input
                                name="tel"
                                id="tel"
                                class="form-control"
                                value="{{ old('tel', $fournisseur->tel) }}"
                            
                                >
                        </div>
                        {{-- Description --}}
                        <div class="mb-3">
                            <label for="description" class="form-label">Adresse</label>
                            <textarea
                                name="adresse"
                                id="adresse"
                                rows="4"
                                class="form-control"
                            >{{ old('adresse', $fournisseur->adresse) }}</textarea>
                        </div>

                      

                        {{-- Unit Price --}}
                        <div class="mb-3">
                            <label for="unit_price" class="form-label">Email</label>
                            <input
                                name="email"
                                id="email"
                                type="email"
                                class="form-control"
                                value="{{ old('email', $fournisseur->email) }}"
                            
                                >
                        </div>
                        <div class="mb-3">
                            <label for="unit_price" class="form-label">Ice</label>
                            <input
                                name="ice"
                                id="ice "
                                type="text"
                                class="form-control"
                                value="{{ old('ice', $fournisseur->ice) }}"
                            
                                >
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('fournisseurs.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Mettre à Jour</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection