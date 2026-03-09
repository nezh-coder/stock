@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Ajouter Client</div>

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

                    <form action="{{ route('clients.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        {{-- Product Name --}}
                        <div class="mb-3">
                            <label for="name" class="form-label">Nom</label>
                            <input
                                type="text"
                                name="name"
                                id="name"
                                class="form-control"
                                value="{{ old('name') }}"
                                required
                            >
                        </div>
                         <div class="mb-3">
                            <label for="price" class="form-label">Tél</label>
                            <input
                                name="tel"
                                id="tel"
                                class="form-control"
                                value="{{ old('tel') }}"
                                required
                            >
                        </div>

                        {{-- Quantity --}}
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Ice</label>
                            <input
                                name="ice"
                                id="ice"
                                class="form-control"
                                value="{{ old('ice') }}"
                            >
                        </div>

                         <div class="mb-3">
                            <label for="quantity" class="form-label">Email</label>
                            <input
                                name="email"
                                id="email"
                                class="form-control"
                                value="{{ old('email') }}"
                            >
                        </div>
                        {{-- Description --}}
                        <div class="mb-3">
                            <label for="description" class="form-label">Adresse</label>
                            <textarea
                                name="adresse"
                                id="description"
                                rows="4"
                                class="form-control"
                            >{{ old('adresse') }}</textarea>
                        </div>

                        {{-- Price --}}
                       
                        
                        {{-- Submit --}}
                        <div class="d-flex justify-content-between">
                            <a href="{{ route('clients.index') }}" class="btn btn-secondary">
                                Back
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Ajouter Client
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
@endsection
