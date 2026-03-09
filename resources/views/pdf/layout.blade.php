<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>@yield('title')</title>

    <style>
        @page {
            margin: 120px 50px 110px 50px;
        }

        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 11px;
            color: #333;
        }

        header {
            position: fixed;
            top: -90px;
            left: 0;
            right: 0;
            height: 80px;
        }

        footer {
            position: fixed;
            bottom: -90px;
            left: 0;
            right: 0;
            height: 80px;
            font-size: 9px;
            color: #666;
        }

        .page {
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 6px;
        }

        th {
            background: #2c4f40;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    @include('pdf.header')
</header>

<footer>
    @include('pdf.footer')
</footer>

<div class="page">
    @yield('content')
</div>

</body>
</html>
