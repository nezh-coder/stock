<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="{{ route('dashboard') }}" class="brand-link">
    <img src="{{ asset('adminlte/dist/assets/img/AdminLTELogo.png') }}" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
    <span class="brand-text font-weight-light">Gestion Stock</span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
      <div class="image">
        <img src="{{ asset('adminlte/dist/assets/img/user2-160x160.jpg') }}" class="img-circle elevation-2" alt="User Image">
      </div>
      <div class="info">
        <a href="#" class="d-block">{{ Auth::user()->name }}</a>
      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Dashboard -->
        <li class="nav-item">
          <a href="{{ route('dashboard') }}" class="nav-link {{ request()->routeIs('dashboard') ? 'active' : '' }}">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>Dashboard</p>
          </a>
        </li>

        <!-- Clients -->
        <li class="nav-item">
          <a href="{{ route('clients.index') }}" class="nav-link {{ request()->routeIs('clients.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-users"></i>
            <p>Clients</p>
          </a>
        </li>

        <!-- Fournisseurs -->
        <li class="nav-item">
          <a href="{{ route('fournisseurs.index') }}" class="nav-link {{ request()->routeIs('fournisseurs.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-truck"></i>
            <p>Fournisseurs</p>
          </a>
        </li>

        <!-- Produits -->
        <li class="nav-item">
          <a href="{{ route('products.index') }}" class="nav-link {{ request()->routeIs('products.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-boxes"></i>
            <p>Produits</p>
          </a>
        </li>

        <!-- Devis -->
        <li class="nav-item">
          <a href="{{ route('devis.index') }}" class="nav-link {{ request()->routeIs('devis.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-file-contract"></i>
            <p>Devis</p>
          </a>
        </li>

        <!-- Bons de Commande -->
        <li class="nav-item">
          <a href="{{ route('bon-commandes.index') }}" class="nav-link {{ request()->routeIs('bon-commandes.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-shopping-cart"></i>
            <p>Bons de Commande</p>
          </a>
        </li>

        <!-- Bons de Livraison -->
        <li class="nav-item">
          <a href="{{ route('bon-livraisons.index') }}" class="nav-link {{ request()->routeIs('bon-livraisons.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-truck-loading"></i>
            <p>Bons de Livraison</p>
          </a>
        </li>

        <!-- Factures -->
        <li class="nav-item">
          <a href="{{ route('factures.index') }}" class="nav-link {{ request()->routeIs('factures.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-file-invoice-dollar"></i>
            <p>Factures</p>
          </a>
        </li>

        <!-- Avoirs -->
        <li class="nav-item">
          <a href="{{ route('avoirs.index') }}" class="nav-link {{ request()->routeIs('avoirs.*') ? 'active' : '' }}">
            <i class="nav-icon fas fa-undo"></i>
            <p>Avoirs</p>
          </a>
        </li>
      </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>