<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>@yield('title')</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">



    {{-- AdminLTE --}}
    <link rel="stylesheet" href="{{ asset('adminlte/css/adminlte.css') }}">
</head>

<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
<div class="app-wrapper">

    {{-- Navbar --}}
    @include('admin.partials.navbar')

    {{-- Sidebar --}}
    @include('admin.partials.sidebar')

    {{-- MAIN CONTENT --}}
    <main class="app-main">
        <div class="app-content">
           
            @yield('content')
        </div>
    </main>

    {{-- Footer --}}
    @include('admin.partials.footer')

</div>

{{-- Bootstrap JS (REQUIRED) --}}
<script src="adminlte/js/bootstrap.bundle.min.js"></script>


{{-- AdminLTE JS --}}
<script src="{{ asset('adminlte/js/adminlte.js') }}"></script>
 @stack('scripts')
</body>
</html>
