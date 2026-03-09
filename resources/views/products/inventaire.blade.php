@extends('adminlte::page')

@section('title', 'Inventaire des Produits')

@section('content')
<div class="container-fluid">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-lg-3 col-6">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $totalProducts }}</h3>
                    <p>Total Produits</p>
                </div>
                <div class="icon">
                    <i class="fas fa-boxes"></i>
                </div>
            </div>
        </div>
    
        <div class="col-lg-3 col-6">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $lowStockCount }}</h3>
                    <p>Stock Faible</p>
                </div>
                <div class="icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-6">
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ $outOfStockCount }}</h3>
                    <p>Rupture de Stock</p>
                </div>
                <div class="icon">
                    <i class="fas fa-times-circle"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Inventaire des Articles</h3>
                    <div class="card-tools">
                       <a href="{{ route('products.inventaire', array_merge(request()->query(), ['export' => 'excel'])) }}"
   class="btn btn-success btn-sm">
    <i class="fas fa-download"></i> Exporter Excel
</a>

                    </div>
                </div>
                <div class="card-body">
                    <!-- Search and Filter Form -->
                    <form method="GET" action="{{ route('products.inventaire') }}" class="mb-3">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="search" class="form-control" placeholder="Rechercher par nom..." value="{{ request('search') }}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <select name="stock_status" class="form-control">
                                        <option value="">Tous les statuts</option>
                                        <option value="in_stock" {{ request('stock_status') == 'in_stock' ? 'selected' : '' }}>En Stock (>10)</option>
                                        <option value="low_stock" {{ request('stock_status') == 'low_stock' ? 'selected' : '' }}>Stock Faible (1-10)</option>
                                        <option value="out_of_stock" {{ request('stock_status') == 'out_of_stock' ? 'selected' : '' }}>Rupture de Stock</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary btn-block">Filtrer</button>
                            </div>
                        </div>
                    </form>

                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>Nom</th>
                                 <th>Catégorie</th>
                                <th>Unité</th>
                                <th>Qté achetée</th>
                                <th>Prix Total achat</th>
                                <th>Qté en Stock</th>
                                <th>Qté seuil</th>
                              <!--  <th>Actions</th>-->
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($products as $k => $product)
                            <tr>
                               <td>{{ $products->firstItem() + $k }}</td>
                                <td>{{ $product->name }}</td>
                                <td>{{ $product->Category->name ?? '-' }}</td>
                                <td>{{ $product->Unite->name ?? '-' }}</td>
                                  <!-- Quantité achetée -->
                                 <td>{{ $product->quantity_achetee ?? '-' }}</td>
                                   <!-- Prix total achat -->
                                <td>{{ number_format($product->total_achat,2) }} DH</td>

                                 <td>
                                    <span class="badge {{ $product->quantity > 10 ? 'badge-success' : ($product->quantity > 0 ? 'badge-warning' : 'badge-danger') }}">
                                        {{ $product->quantity }}
                                    </span>
                                </td>
                                <!-- Seuil -->
                              <td>{{ $product->min_qte ?? '-' }}</td>
                               <!--  <td>
                                    <a href="{{ route('products.edit', $product->id) }}" class="btn btn-sm btn-warning">Modifier</a>
                                </td>-->
                            </tr>
                            @endforeach
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    {{ $products->appends(request()->query())->links() }}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
