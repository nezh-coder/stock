@extends('adminlte::page')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <div class="card">
                <div class="card-header">Modifier Client</div>

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

                    <form action="{{ route('clients.update', $client) }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')

                        {{-- client Name --}}
                        <div class="mb-3">
                            <label for="name" class="form-label">Nom du Client</label>
                            <input
                                type="text"
                                name="name"
                                id="name"
                                class="form-control"
                                value="{{ old('name', $client->name) }}"
                                required
                            >
                        </div>
                         <div class="mb-3">
                            <label for="unit_price" class="form-label">Tél</label>
                            <input
                                name="tel"
                                id="tel"
                                class="form-control"
                                value="{{ old('tel', $client->tel) }}"
                            
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
                            >{{ old('adresse', $client->adresse) }}</textarea>
                        </div>

                      

                        {{-- Unit Price --}}
                        <div class="mb-3">
                            <label for="unit_price" class="form-label">Email</label>
                            <input
                                name="email"
                                id="email"
                                type="email"
                                class="form-control"
                                value="{{ old('email', $client->email) }}"
                            
                                >
                        </div>
                        <div class="mb-3">
                            <label for="unit_price" class="form-label">Ice</label>
                            <input
                                name="ice"
                                id="ice "
                                type="text"
                                class="form-control"
                                value="{{ old('ice', $client->ice) }}"
                            
                                >
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="{{ route('clients.index') }}" class="btn btn-secondary">Retour</a>
                            <button type="submit" class="btn btn-primary">Mettre à Jour</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection