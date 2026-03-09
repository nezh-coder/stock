@extends('adminlte::page')

@section('title', 'Catégories')

@section('content')
<div class="container-fluid">
    <div class="mb-3">
    <form action="{{ route('categories.import') }}" method="POST" enctype="multipart/form-data">
        @csrf
        <div class="input-group">
            <input type="file" name="file" class="form-control" required>
            <div class="input-group-append">
                <button class="btn btn-primary" type="submit">Importer Excel</button>
            </div>
        </div>
        @error('file')
            <small class="text-danger">{{ $message }}</small>
        @enderror
    </form>
</div>
</div>
@endsection