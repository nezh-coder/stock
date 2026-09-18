<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>{{ config('app.name', 'Gestion de Stock') }}</title>

    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <style>
        html,
        body {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            min-width: 100% !important;
            min-height: 100% !important;
            overflow-x: hidden !important;
        }

        body {
            background: #f6f8fc;
        }

        .guest-layout {
            width: 100% !important;
            max-width: none !important;
            min-width: 100% !important;
            min-height: 100vh;
            margin: 0 !important;
            padding: 0 !important;
        }

        .guest-layout > * {
            max-width: none !important;
        }
    </style>
</head>

<body>
    <div class="guest-layout">
        {{ $slot }}
    </div>
</body>
</html>