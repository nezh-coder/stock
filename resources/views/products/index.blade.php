@extends('adminlte::page')

@section('title', 'Produits')

@section('content')
<div class="container-fluid">
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif
    @if($errors->any())
        <div class="alert alert-danger">
            <ul class="mb-0">
                @foreach($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

 

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $products->total() }}</h3>
                    <p>Total Produits</p>
                </div>
                <div class="icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <a href="#products-table" class="small-box-footer">Voir la liste <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $productsInStock }}</h3>
                    <p>Produits en Stock</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <a href="#products-table" class="small-box-footer">Voir les détails <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $productsLowStock }}</h3>
                    <p>Stock Faible</p>
                </div>
                <div class="icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <a href="#products-table" class="small-box-footer">Voir les alertes <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $productsOutOfStock }}</h3>
                    <p>Rupture de Stock</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <a href="#products-table" class="small-box-footer">Voir les ruptures <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
   <div class="card card-outline card-success mb-3">
        <div class="card-header">
            <h3 class="card-title"><i class="fas fa-file-csv mr-2"></i>Importer les produits depuis un CSV</h3>
        </div>
        <div class="card-body">
            <form action="{{ route('products.import') }}" method="POST" enctype="multipart/form-data" class="form-inline">
                @csrf
                <input type="file" name="file" class="form-control mr-2" accept=".csv,.txt" required>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-upload mr-1"></i>Importer le CSV
                </button>
            </form>
            <small class="form-text text-muted mt-2">
                Colonnes attendues : Nom, Description, Catégorie, Unité, Prix unitaire, Qté en stock et Qté seuil.
                Les catégories et unités absentes seront créées automatiquement.
            </small>
        </div>
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
                    <form method="GET" action="{{ route('products.index') }}" class="form-inline">
                        <div class="form-group mr-3">
                            <input type="text" name="search" class="form-control" placeholder="Rechercher par nom..." value="{{ request('search') }}">
                        </div>
                        <div class="form-group mr-3">
                            <select name="stock_status" class="form-control">
                                <option value="">Tous les statuts</option>
                                <option value="in_stock" {{ request('stock_status') == 'in_stock' ? 'selected' : '' }}>En stock</option>
                                <option value="low_stock" {{ request('stock_status') == 'low_stock' ? 'selected' : '' }}>Stock faible</option>
                                <option value="out_of_stock" {{ request('stock_status') == 'out_of_stock' ? 'selected' : '' }}>Rupture</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary mr-2">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                        <a href="{{ route('products.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Réinitialiser
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="row">
        <div class="col-12">
            <div class="card" id="products-table">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>Liste des Produits
                    </h3>
                    <div class="card-tools">
                        <a href="{{ route('products.create') }}" class="btn btn-success btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Produit
                        </a>
                    </div>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-hover table-striped text-nowrap">
                        <thead class="thead-light">
                            <tr>
                                <th><i class="mr-1"></i>N°</th>
                                <th><i class="fas fa-tag mr-1"></i>Nom</th>
                                <th><i class="fas fa-files mr-1"></i>Catégorie</th>
                                 <th><i class="fas fa-money-bill mr-1"></i>Prix Unit</th>
                                <th><i class="fas fa-cubes mr-1"></i>Qté</th>
                                <th><i class="fas fa-info-circle mr-1"></i>Statut</th>
                               <!--- <th><i class="fas fa-calendar mr-1"></i>Créé le</th>-->
                                <th><i class="fas fa-cogs mr-1"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($products as $k=>$product)
                                <tr>
                                    <td>{{ $k+1 }}</td>
                                    <td>
                                        <strong>{{ $product->name }}</strong>
                                    </td>
                                   
                                     <td>
                                        <strong>{{ $product->category->name  }}</strong>
                                    </td>
                                    <td>
                                        <span class="badge badge-primary">{{ number_format($product->unit_price, 2) }} DH</span>
                                    </td>
                                    <td>
                                        @if($product->quantity > $product->min_quantity)
                                            <span class="badge badge-success">{{ $product->quantity }}</span>
                                        @elseif($product->quantity == $product->min_quantity)
                                            <span class="badge badge-warning">{{ $product->quantity }}</span>
                                        @else
                                            <span class="badge badge-danger">{{ $product->quantity }}</span>
                                        @endif
                                    </td>
                                    <td>
                                        @if($product->quantity > $product->min_qte)
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>En stock
                                            </span>
                                        @elseif($product->quantity < $product->min_qte)
                                            <span class="badge badge-warning">
                                                <i class="fas fa-exclamation-triangle mr-1"></i>Stock faible
                                            </span>
                                        @elseif($product->quantity == 0)
                                            <span class="badge badge-danger">
                                                <i class="fas fa-times-circle mr-1"></i>Rupture
                                            </span>
                                        @endif
                                    </td>
                                  <!---  <td>{{ $product->created_at->format('d/m/Y') }}</td>--->
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{{ route('products.show', $product) }}" class="btn btn-info mr-1" title="Voir">
                                                <i class="fas fa-eye mr-1"></i>
                                            </a>
                                            <a href="{{ route('products.edit', $product) }}" class="btn btn-warning mr-1" title="Modifier">
                                                <i class="fas fa-edit mr-1"></i>
                                            </a>
                                            <form method="POST" action="{{ route('products.destroy', $product) }}" class="d-inline">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger mr-1" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ?')">
                                                    <i class="fas fa-trash mr-1"></i>
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
                                        <a href="{{ route('products.create') }}" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Ajouter le premier produit
                                        </a>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                @if($products->hasPages())
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted">
                                        Affichage de {{ $products->firstItem() }} à {{ $products->lastItem() }} sur {{ $products->total() }} produits
                                    </small>
                                </div>
                                <div class="d-flex justify-content-center mt-3">
                                    {{ $products->links() }}
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