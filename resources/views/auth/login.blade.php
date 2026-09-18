<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion | Gestion de stock</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="{{ asset('css/auth.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
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
.password-wrapper { position: relative; width: 100%; } 
.password-wrapper input { width: 100%; box-sizing: border-box; /* Important : même taille dans les deux états */ padding-right: 45px; } /* Bouton de l'œil */
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
/* Bouton de l'œil */ .password-wrapper .toggle-password { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); /* Empêche le CSS global des boutons d'interférer */ width: 30px !important; height: 30px !important; min-width: 30px !important; min-height: 30px !important; max-width: 30px !important; max-height: 30px !important;padding: 0 !important; margin: 0 !important; border: none !important; outline: none; background: transparent !important; cursor: pointer; display: flex; align-items: center; justify-content: center; color: #666; /* Important */ line-height: 1 !important; font-size: 16px !important; }
/* Icône */ .password-wrapper .toggle-password i { font-size: 16px !important; line-height: 1 !important; width: auto !important; height: auto !important; } /* Hover */ .password-wrapper .toggle-password:hover { color: #222; background: transparent !important; }
/* Focus */ .password-wrapper .toggle-password:focus { outline: none !important; box-shadow: none !important; }
</style>