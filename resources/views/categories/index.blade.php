@extends('adminlte::page')

@section('title', 'Catégories')

@section('content')
<div class="container-fluid">
    @if(session('success'))
    <div class="alert alert-success">{{ session('success') }}</div>
@endif
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $categories->count() }}</h3>
                    <p>Total Catégories</p>
                </div>
                <div class="icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <a href="#categories-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
       
    </div>
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
    <!-- Search and Filter Section -->
    <div class="row mb-3">
        <div class="col-12">
            <div class="card card-outline card-primary">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-search mr-2"></i>Recherche et Filtres
                    </h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <form method="GET" action="{{ route('categories.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par nom..." value="{{ request('search') }}">
                        </div>
                       
                        <button type="submit" class="btn btn-primary mr-2">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                        <a href="{{ route('categories.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- categories Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="categories-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>Liste des Categories
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('categories.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Ajouter Catégorie
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="mr-1"></i>N°</th>
                                <th><i class="fas fa-tag mr-1"></i>Nom</th>
                                <th><i class="fas fa-align-left mr-1"></i>Description</th>
                                <th><i class=" mr-1"></i>Nbre Produits</th>
                               
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($categories as $k=>$product)
                                <tr>
                                    <td>{{ $k+1 }}</td>
                                    <td>
                                        <strong>{{ $product->name }}</strong>
                                    </td>
                                    <td>
                                        <span title="{{ $product->description }}">
                                           {{ \Illuminate\Support\Str::limit($product->description, 250) }}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-primary">{{ $product->products_count}} </span>
                                    </td>
                                                   
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                          
                                            <a href="{{ route('categories.edit', $product) }}" class="btn btn-warning" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form method="POST" action="{{ route('categories.destroy', $product) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="8" class="text-center py-4">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Aucun produit trouvé</h5>
                                        <p class="text-muted">Il n'y a actuellement aucun produit dans le système.</p>
                                        <a href="{{ route('categories.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Ajouter le premier produit
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($categories->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $categories->firstItem() }} à {{ $categories->lastItem() }} sur {{ $categories->total() }} Catégories
                                    </small>
                                </div>
                                <div>
                                    {{ $categories->links() }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                @endif
            </div>
        </div>
    </div>
</div>
@endsection