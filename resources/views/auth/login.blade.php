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
                <label for="password">Mot de passe</label>

                <div class="password-wrapper">
                    <input
                        type="password"
                        id="password"
                        name="password"
                        required
                    >

                    <button
                        type="button"
                        class="toggle-password"
                        onclick="togglePassword()"
                        aria-label="Afficher le mot de passe"
                    >
                        👁️
                    </button>
                </div>
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

<script>
function togglePassword() {
    const password = document.getElementById('password');
    const toggle = document.querySelector('.toggle-password');

    if (password.type === 'password') {
        password.type = 'text';
        toggle.innerHTML = '<i class="fas fa-eye-slash"></i>';
        toggle.setAttribute('aria-label', 'Masquer le mot de passe');
    } else {
        password.type = 'password';
        toggle.innerHTML = '<i class="fas fa-eye"></i>';
        toggle.setAttribute('aria-label', 'Afficher le mot de passe');
    }
}
</script>

</body>
</html>
<style>
.password-wrapper {
    position: relative;
    width: 100%;
}

.password-wrapper input {
    width: 100%;
    padding-right: 45px;
    box-sizing: border-box;
}

.toggle-password {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);

    border: none;
    background: transparent;
    padding: 5px;

    cursor: pointer;
    font-size: 18px;

    color: #666;
}

.toggle-password:hover {
    color: #222;
}
</style>