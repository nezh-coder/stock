<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion | Gestion de stock</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="{{ asset('css/auth.css') }}">
    <link rel="icon" href="{{ asset('favicon.ICO') }}">
</head>
<body>

<div class="login-container">
    <div class="login-card">

        <!-- Logo -->
        <div class="logo">
            <img src="{{ asset('favicon.png') }}" alt="Gestion de stock">
        </div>

        <h2>Connexion</h2>
        <p class="subtitle">Accédez à votre espace</p>

        <!-- Form -->
        <form method="POST" action="{{ route('login') }}">
            @csrf

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required autofocus>
            </div>

            <div class="form-group">
                <label>Mot de passe</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-options">
                <label>
                    <input type="checkbox" name="remember">
                    Se souvenir de moi
                </label>
            </div>

            <button type="submit">Se connecter</button>
        </form>

        <div class="footer">
            © {{ date('Y') }} Gestion de stock
        </div>

    </div>
</div>

</body>
</html>
