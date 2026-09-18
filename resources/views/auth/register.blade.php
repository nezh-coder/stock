<x-guest-layout>

    <style>
        :root {
            --register-blue: #315efb;
            --register-blue-dark: #2448d8;
            --register-purple: #7c3aed;
            --register-navy: #14203d;
            --register-text: #19223c;
            --register-muted: #718096;
            --register-line: #e2e8f0;
            --register-soft: #f8faff;
            --register-danger: #dc2626;
            --register-success: #16a34a;
        }

        /* =========================================================
           GLOBAL
        ========================================================= */

        html,
        body {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            min-height: 100% !important;
            overflow-x: hidden;
        }

        /* =========================================================
           PAGE
        ========================================================= */

        .register-page {
            position: relative;

            width: 100%;
            min-height: 100vh;

            margin: 0;
            padding: 45px 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            box-sizing: border-box;

            overflow: hidden;

            /*
             * Fond SaaS moderne :
             * - blanc / bleu très clair
             * - halo bleu
             * - halo violet
             * - grille très discrète
             */
            background:
                radial-gradient(
                    circle at 10% 15%,
                    rgba(49, 94, 251, 0.14),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 90% 85%,
                    rgba(124, 58, 237, 0.10),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 80% 5%,
                    rgba(59, 130, 246, 0.08),
                    transparent 24%
                ),
                #f7f9fd;
        }

        /*
         * Grille décorative
         */
        .register-page::before {
            content: "";
            position: absolute;
            inset: 0;

            pointer-events: none;

            background-image:
                linear-gradient(
                    rgba(49, 94, 251, 0.035) 1px,
                    transparent 1px
                ),
                linear-gradient(
                    90deg,
                    rgba(49, 94, 251, 0.035) 1px,
                    transparent 1px
                );

            background-size: 38px 38px;

            mask-image: linear-gradient(
                to bottom,
                black,
                transparent 90%
            );
        }

        /*
         * Cercles décoratifs
         */
        .register-page::after {
            content: "";
            position: absolute;

            width: 420px;
            height: 420px;

            right: -180px;
            top: -180px;

            border-radius: 50%;

            background:
                radial-gradient(
                    circle,
                    rgba(49, 94, 251, 0.08),
                    transparent 68%
                );

            pointer-events: none;
        }

        /* =========================================================
           CARD
        ========================================================= */

        .register-card {
            position: relative;
            z-index: 2;

            width: 100%;
            max-width: 820px;

            background: rgba(255, 255, 255, 0.96);

            border: 1px solid rgba(226, 232, 240, 0.90);

            border-radius: 20px;

            box-shadow:
                0 25px 70px rgba(20, 32, 61, 0.10),
                0 4px 15px rgba(20, 32, 61, 0.04);

            overflow: hidden;

            backdrop-filter: blur(12px);
        }

        .register-card *,
        .register-card *::before,
        .register-card *::after {
            box-sizing: border-box;
        }

        /* =========================================================
           HEADER
        ========================================================= */

        .register-top {
            padding: 30px 42px 0;
        }

        .register-brand {
            display: inline-flex;
            align-items: center;
            gap: 10px;

            color: var(--register-navy);

            font-size: 1.05rem;
            font-weight: 750;

            text-decoration: none;
        }

        .register-brand-mark {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            width: 36px;
            height: 36px;

            background:
                linear-gradient(
                    135deg,
                    var(--register-blue),
                    #4f75ff
                );

            border-radius: 10px;

            color: #fff;

            box-shadow:
                0 7px 16px rgba(49, 94, 251, 0.22);
        }

        /* =========================================================
           PROGRESS
        ========================================================= */

        .progress {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));

            gap: 8px;

            margin-top: 32px;
        }

        .progress-step {
            position: relative;

            display: flex;
            align-items: center;

            gap: 8px;

            color: #a4aec0;

            font-size: 0.78rem;
            font-weight: 700;
        }

        .progress-step:not(:last-child)::after {
            content: "";

            position: absolute;

            height: 1px;

            left: calc(100% - 16px);
            right: 8px;

            top: 14px;

            background: #e3e8f1;
        }

        .progress-step.is-active,
        .progress-step.is-complete {
            color: var(--register-blue);
        }

        .progress-step.is-complete::after {
            background: #9cb2ff;
        }

        .progress-number {
            position: relative;
            z-index: 1;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            flex: 0 0 auto;

            width: 28px;
            height: 28px;

            background: #eef1f6;

            border-radius: 50%;
        }

        .is-active .progress-number {
            background: var(--register-blue);

            color: #fff;

            box-shadow:
                0 0 0 4px #e8edff;
        }

        .is-complete .progress-number {
            background: #e4edff;
        }

        /* =========================================================
           BODY
        ========================================================= */

        .register-body {
            width: 100%;

            padding: 32px 42px 38px;
        }

        .step {
            display: none;
        }

        .step.is-visible {
            display: block;
        }

        .step-heading {
            margin-bottom: 26px;
        }

        .step-heading h1 {
            margin: 0 0 7px;

            color: var(--register-text);

            font-size: 1.65rem;
            letter-spacing: -0.035em;
        }

        .step-heading p {
            margin: 0;

            color: var(--register-muted);

            font-size: 0.9rem;
        }

        /* =========================================================
           SECTIONS
        ========================================================= */

        .section-label {
            display: flex;
            align-items: center;

            gap: 9px;

            margin: 26px 0 15px;

            color: var(--register-text);

            font-size: 0.92rem;
            font-weight: 750;
        }

        .section-label i {
            color: var(--register-blue);
            font-size: 0.85rem;
        }

        /* =========================================================
           FIELDS
        ========================================================= */

        .field-grid {
            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 15px;

            width: 100%;
        }

        .field {
            width: 100%;
            min-width: 0;

            margin-bottom: 15px;
        }

        .field label {
            display: block;

            margin-bottom: 7px;

            color: #3b465d;

            font-size: 0.78rem;
            font-weight: 700;
        }

        .input-wrap {
            position: relative;

            width: 100%;
        }

        .input-wrap > i {
            position: absolute;

            left: 13px;
            top: 50%;

            transform: translateY(-50%);

            color: #9aa6ba;

            font-size: 0.8rem;

            pointer-events: none;

            z-index: 1;
        }

        .register-input {
            display: block;

            width: 100%;
            max-width: 100%;

            height: 46px;

            box-sizing: border-box;

            padding: 0 13px 0 37px;

            background: #fff;

            border: 1px solid var(--register-line);

            border-radius: 10px;

            color: var(--register-text);

            font-size: 0.88rem;

            outline: none;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }

        .register-input:focus {
            border-color: var(--register-blue);

            box-shadow:
                0 0 0 3px rgba(49, 94, 251, 0.10);
        }

        .register-input::placeholder {
            color: #b0b8c6;
        }

        /* =========================================================
           CLIENT VALIDATION
        ========================================================= */

        .register-input.input-error {
            border-color: var(--register-danger) !important;

            background: #fffafa;

            box-shadow:
                0 0 0 3px rgba(220, 38, 38, 0.07);
        }

        .register-input.input-success {
            border-color: var(--register-success);
        }

        .field-error {
            display: block;

            min-height: 0;

            margin-top: 5px;

            color: var(--register-danger);

            font-size: 0.72rem;
            line-height: 1.4;
        }

        .field-error:empty {
            display: none;
        }

        /* =========================================================
           INFO NOTE
        ========================================================= */

        .info-note {
            margin-bottom: 22px;

            padding: 12px 14px;

            background:
                linear-gradient(
                    135deg,
                    #f5f7ff,
                    #f8faff
                );

            border: 1px solid #e8edff;

            border-radius: 10px;

            color: #65728b;

            font-size: 0.78rem;

            line-height: 1.55;
        }

        .info-note i {
            margin-right: 6px;

            color: var(--register-blue);
        }

        /* =========================================================
           UPLOAD
        ========================================================= */

        .upload-grid {
            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 15px;

            width: 100%;
        }

        .upload-box {
            position: relative;

            display: block;

            min-width: 0;
            min-height: 142px;

            padding: 18px;

            border: 1px dashed #b9c7e5;

            border-radius: 11px;

            cursor: pointer;

            overflow: hidden;

            text-align: center;

            transition:
                background 0.2s ease,
                border-color 0.2s ease,
                transform 0.2s ease;
        }

        .upload-box:hover,
        .upload-box.has-file {
            background: #f7f9ff;

            border-color: var(--register-blue);

            transform: translateY(-1px);
        }

        .upload-box input {
            position: absolute;

            width: 1px;
            height: 1px;

            opacity: 0;
        }

        .upload-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            width: 37px;
            height: 37px;

            margin-bottom: 9px;

            background: #eaf0ff;

            border-radius: 9px;

            color: var(--register-blue);
        }

        .upload-title {
            display: block;

            color: var(--register-text);

            font-size: 0.8rem;
            font-weight: 750;
        }

        .upload-help {
            display: block;

            margin-top: 4px;

            color: var(--register-muted);

            font-size: 0.68rem;

            line-height: 1.45;
        }

        .preview {
            display: none;

            width: auto;
            max-width: 130px;

            height: 48px;

            margin: 8px auto 0;

            object-fit: contain;
        }

        .preview.is-visible {
            display: block;
        }

        .background-preview {
            display: none;

            width: 130px;
            max-width: 130px;

            height: 48px;

            margin: 8px auto 0;

            background-position: center;
            background-size: cover;

            border-radius: 5px;
        }

        .background-preview.is-visible {
            display: block;
        }

        /* =========================================================
           BUTTONS
        ========================================================= */

        .form-actions {
            display: flex;

            align-items: center;
            justify-content: space-between;

            gap: 15px;

            margin-top: 28px;
        }

        .text-link {
            color: var(--register-muted);

            font-size: 0.8rem;
            font-weight: 600;

            text-decoration: none;

            transition: color 0.2s ease;
        }

        .text-link:hover {
            color: var(--register-blue);
        }

        .action-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 9px;

            min-height: 44px;

            padding: 0 20px;

            background:
                linear-gradient(
                    135deg,
                    var(--register-blue),
                    #4d70ff
                );

            border: 0;

            border-radius: 9px;

            box-shadow:
                0 8px 18px rgba(49, 94, 251, 0.20);

            color: #fff;

            cursor: pointer;

            font-size: 0.84rem;
            font-weight: 750;

            transition:
                background 0.2s ease,
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }

        .action-button:hover {
            background:
                linear-gradient(
                    135deg,
                    var(--register-blue-dark),
                    #315efb
                );

            transform: translateY(-1px);

            box-shadow:
                0 11px 22px rgba(49, 94, 251, 0.25);
        }

        .secondary-button {
            background: #f2f4f8;

            color: #536079;

            box-shadow: none;
        }

        .secondary-button:hover {
            background: #e7ebf3;

            color: #3b465d;

            box-shadow: none;
        }

        /* =========================================================
           PLANS
        ========================================================= */

        .plan-grid {
            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 16px;

            width: 100%;
        }

        .plan-card {
            position: relative;

            display: block;

            min-width: 0;

            padding: 22px;

            border: 1px solid var(--register-line);

            border-radius: 12px;

            cursor: pointer;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                transform 0.2s ease;
        }

        .plan-card:hover {
            border-color: #a9bbf6;

            box-shadow:
                0 12px 28px rgba(35, 69, 198, 0.08);

            transform: translateY(-2px);
        }

        .plan-card.selected {
            border-color: var(--register-blue);

            box-shadow:
                0 0 0 3px rgba(49, 94, 251, 0.10);

            background: #fbfcff;
        }

        .plan-card input {
            position: absolute;

            left: -9999px;
        }

        .plan-card h2 {
            margin: 0 0 9px;

            color: var(--register-text);

            font-size: 1rem;
        }

        .plan-card p {
            min-height: 39px;

            margin: 0;

            color: var(--register-muted);

            font-size: 0.79rem;

            line-height: 1.55;
        }

        .plan-list {
            margin: 18px 0 0;

            padding: 0;

            list-style: none;
        }

        .plan-list li {
            margin: 10px 0;

            color: #55627a;

            font-size: 0.77rem;
        }

        .plan-list i {
            margin-right: 7px;

            color: #21a477;
        }

        .plan-action {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 15px;

            padding: 10px 12px;

            border: 0;

            border-radius: 8px;

            cursor: pointer;

            font-size: 0.78rem;
            font-weight: 750;
        }

        .plan-free .plan-action {
            background: #eaf0ff;

            color: var(--register-blue);
        }

        .plan-paid .plan-action {
            background: var(--register-blue);

            color: #fff;
        }

        /* =========================================================
           SERVER ERRORS
        ========================================================= */

        .server-errors {
            margin-bottom: 18px;

            padding: 11px 13px;

            background: #fff4f4;

            border: 1px solid #ffd8d8;

            border-radius: 9px;

            color: #b42318;

            font-size: 0.78rem;
        }

        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 700px) {

            .register-page {
                align-items: flex-start;

                padding: 25px 12px;
            }

            .register-card {
                max-width: 100%;

                border-radius: 15px;
            }

            .register-top {
                padding: 24px 22px 0;
            }

            .register-body {
                padding: 27px 22px 30px;
            }

            .field-grid,
            .upload-grid,
            .plan-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                align-items: stretch;

                flex-direction: column-reverse;
            }

            .action-button {
                width: 100%;
            }

            .text-link {
                text-align: center;
            }
        }

        @media (max-width: 480px) {

            .register-page {
                padding: 12px 8px;
            }

            .register-top {
                padding: 20px 16px 0;
            }

            .register-body {
                padding: 23px 16px 25px;
            }

            .progress {
                gap: 4px;
            }

            .progress-step {
                gap: 5px;

                font-size: 0.64rem;
            }

            .progress-number {
                width: 25px;
                height: 25px;
            }

            .step-heading h1 {
                font-size: 1.4rem;
            }
        }
    </style>


    @php
        $enterpriseFields = [
            'entreprise_name',
            'entreprise_adresse',
            'entreprise_tel',
            'entreprise_email',
            'entreprise_ice',
            'logo',
            'document_background'
        ];

        $hasEnterpriseErrors = $errors->hasAny($enterpriseFields);

        $initialStep = $hasEnterpriseErrors ? 2 : 1;
    @endphp


    <div
        class="register-page"
        data-register-app
        data-initial-step="{{ $initialStep }}"
    >

        <div class="register-card">

            {{-- =====================================================
                 HEADER
            ====================================================== --}}

            <div class="register-top">

                <a
                    class="register-brand"
                    href="{{ url('/') }}"
                >
                    <span class="register-brand-mark">
                        <i class="fas fa-boxes-stacked"></i>
                    </span>

                    <span>Gestion de Stock</span>
                </a>


                <div
                    class="progress"
                    aria-label="Progression de l'inscription"
                >

                    <div
                        class="progress-step is-active"
                        data-progress="1"
                    >
                        <span class="progress-number">
                            01
                        </span>

                        <span>Compte</span>
                    </div>


                    <div
                        class="progress-step"
                        data-progress="2"
                    >
                        <span class="progress-number">
                            02
                        </span>

                        <span>Entreprise</span>
                    </div>


                    <div
                        class="progress-step"
                        data-progress="3"
                    >
                        <span class="progress-number">
                            03
                        </span>

                        <span>Formule</span>
                    </div>

                </div>

            </div>


            {{-- =====================================================
                 FORM
            ====================================================== --}}

            <form
                class="register-body"
                method="POST"
                action="{{ route('register') }}"
                enctype="multipart/form-data"
                data-register-form
            >

                @csrf


                @if($errors->any())

                    <div class="server-errors">

                        <i class="fas fa-circle-exclamation mr-1"></i>

                        Vérifiez les informations indiquées avant de continuer.

                    </div>

                @endif


                {{-- =================================================
                     STEP 1
                ================================================== --}}

                <section
                    class="step"
                    data-step="1"
                >

                    <div class="step-heading">

                        <h1>
                            Créer votre compte
                        </h1>

                        <p>
                            Commencez par créer votre compte administrateur.
                        </p>

                    </div>


                    <div class="field-grid">

                        {{-- NAME --}}

                        <div class="field">

                            <label for="name">
                                Nom complet
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-user"></i>

                                <input
                                    class="register-input @error('name') input-error @enderror"
                                    id="name"
                                    name="name"
                                    type="text"
                                    value="{{ old('name') }}"
                                    required
                                    autocomplete="name"
                                    placeholder="Votre nom complet"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="name"
                            >
                                @error('name')
                                    {{ $message }}
                                @enderror
                            </div>

                        </div>


                        {{-- EMAIL --}}

                        <div class="field">

                            <label for="email">
                                Adresse email
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-envelope"></i>

                                <input
                                    class="register-input @error('email') input-error @enderror"
                                    id="email"
                                    name="email"
                                    type="email"
                                    value="{{ old('email') }}"
                                    required
                                    autocomplete="username"
                                    placeholder="vous@entreprise.com"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="email"
                            >
                                @error('email')
                                    {{ $message }}
                                @enderror
                            </div>

                        </div>

                    </div>


                    <div class="field-grid">

                        {{-- PASSWORD --}}

                        <div class="field">

                            <label for="password">
                                Mot de passe
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-lock"></i>

                                <input
                                    class="register-input @error('password') input-error @enderror"
                                    id="password"
                                    name="password"
                                    type="password"
                                    required
                                    minlength="8"
                                    autocomplete="new-password"
                                    placeholder="Votre mot de passe"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="password"
                            >
                                @error('password')
                                    {{ $message }}
                                @enderror
                            </div>

                        </div>


                        {{-- CONFIRMATION --}}

                        <div class="field">

                            <label for="password_confirmation">
                                Confirmation
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-lock"></i>

                                <input
                                    class="register-input"
                                    id="password_confirmation"
                                    name="password_confirmation"
                                    type="password"
                                    required
                                    minlength="8"
                                    autocomplete="new-password"
                                    placeholder="Confirmez le mot de passe"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="password_confirmation"
                            ></div>

                        </div>

                    </div>


                    <div class="form-actions">

                        <a
                            class="text-link"
                            href="{{ route('login') }}"
                        >
                            J'ai déjà un compte
                        </a>


                        <button
                            class="action-button"
                            type="button"
                            data-next="2"
                        >
                            Continuer

                            <i class="fas fa-arrow-right"></i>
                        </button>

                    </div>

                </section>


                {{-- =================================================
                     STEP 2
                ================================================== --}}

                <section
                    class="step"
                    data-step="2"
                >

                    <div class="step-heading">

                        <h1>
                            Votre entreprise
                        </h1>

                        <p>
                            Configurez votre espace entreprise.
                        </p>

                    </div>


                    <div class="section-label">

                        <i class="fas fa-building"></i>

                        Informations de l'entreprise

                    </div>


                    <div class="info-note">

                        <i class="fas fa-circle-info"></i>

                        Votre entreprise disposera de son propre espace de travail.

                    </div>


                    {{-- COMPANY NAME --}}

                    <div class="field">

                        <label for="entreprise_name">
                            Nom de l'entreprise
                        </label>

                        <div class="input-wrap">

                            <i class="fas fa-building"></i>

                            <input
                                class="register-input @error('entreprise_name') input-error @enderror"
                                id="entreprise_name"
                                name="entreprise_name"
                                type="text"
                                value="{{ old('entreprise_name') }}"
                                required
                                placeholder="Nom de votre entreprise"
                            >

                        </div>

                        <div
                            class="field-error"
                            data-error-for="entreprise_name"
                        >
                            @error('entreprise_name')
                                {{ $message }}
                            @enderror
                        </div>

                    </div>


                    {{-- ADDRESS --}}

                    <div class="field">

                        <label for="entreprise_adresse">
                            Adresse
                        </label>

                        <div class="input-wrap">

                            <i class="fas fa-location-dot"></i>

                            <input
                                class="register-input @error('entreprise_adresse') input-error @enderror"
                                id="entreprise_adresse"
                                name="entreprise_adresse"
                                type="text"
                                value="{{ old('entreprise_adresse') }}"
                                placeholder="Adresse de l'entreprise"
                            >

                        </div>

                        <div
                            class="field-error"
                            data-error-for="entreprise_adresse"
                        >
                            @error('entreprise_adresse')
                                {{ $message }}
                            @enderror
                        </div>

                    </div>


                    <div class="field-grid">

                        {{-- PHONE --}}

                        <div class="field">

                            <label for="entreprise_tel">
                                Téléphone
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-phone"></i>

                                <input
                                    class="register-input @error('entreprise_tel') input-error @enderror"
                                    id="entreprise_tel"
                                    name="entreprise_tel"
                                    type="text"
                                    value="{{ old('entreprise_tel') }}"
                                    placeholder="Téléphone"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="entreprise_tel"
                            >
                                @error('entreprise_tel')
                                    {{ $message }}
                                @enderror
                            </div>

                        </div>


                        {{-- COMPANY EMAIL --}}

                        <div class="field">

                            <label for="entreprise_email">
                                Email entreprise
                            </label>

                            <div class="input-wrap">

                                <i class="fas fa-envelope"></i>

                                <input
                                    class="register-input @error('entreprise_email') input-error @enderror"
                                    id="entreprise_email"
                                    name="entreprise_email"
                                    type="email"
                                    value="{{ old('entreprise_email') }}"
                                    placeholder="contact@entreprise.com"
                                >

                            </div>

                            <div
                                class="field-error"
                                data-error-for="entreprise_email"
                            >
                                @error('entreprise_email')
                                    {{ $message }}
                                @enderror
                            </div>

                        </div>

                    </div>


                    {{-- ICE --}}

                    <div class="field">

                        <label for="entreprise_ice">

                            ICE

                            <span
                                style="
                                    color:#9aa6ba;
                                    font-weight:400;
                                "
                            >
                                (facultatif)
                            </span>

                        </label>

                        <div class="input-wrap">

                            <i class="fas fa-id-card"></i>

                            <input
                                class="register-input @error('entreprise_ice') input-error @enderror"
                                id="entreprise_ice"
                                name="entreprise_ice"
                                type="text"
                                value="{{ old('entreprise_ice') }}"
                                placeholder="Identifiant Commun de l'Entreprise"
                            >

                        </div>

                        <div
                            class="field-error"
                            data-error-for="entreprise_ice"
                        >
                            @error('entreprise_ice')
                                {{ $message }}
                            @enderror
                        </div>

                    </div>


                    {{-- =================================================
                         VISUAL IDENTITY
                    ================================================== --}}

                    <div class="section-label">

                        <i class="fas fa-palette"></i>

                        Identité visuelle

                    </div>


                    <div class="upload-grid">

                        {{-- LOGO --}}

                        <label
                            class="upload-box"
                            data-upload-box="logo"
                        >

                            <input
                                id="logo"
                                name="logo"
                                type="file"
                                accept="image/jpeg,image/png,image/jpg,image/webp"
                                data-preview-target="logo-preview"
                            >

                            <span class="upload-icon">
                                <i class="fas fa-image"></i>
                            </span>

                            <span class="upload-title">
                                Logo de l'entreprise
                            </span>

                            <span class="upload-help">
                                PNG, JPG, JPEG ou WEBP · 2 Mo max.
                            </span>

                            <img
                                class="preview"
                                id="logo-preview"
                                alt="Prévisualisation du logo"
                            >

                        </label>


                        {{-- DOCUMENT BACKGROUND --}}

                        <label
                            class="upload-box"
                            data-upload-box="document_background"
                        >

                            <input
                                id="document_background"
                                name="document_background"
                                type="file"
                                accept="image/jpeg,image/png,image/jpg,image/webp"
                                data-preview-target="background-preview"
                            >

                            <span class="upload-icon">
                                <i class="fas fa-file-image"></i>
                            </span>

                            <span class="upload-title">
                                Arrière-plan des documents
                            </span>

                            <span class="upload-help">
                                Pour vos devis, factures et documents · 4 Mo max.
                            </span>

                            <span
                                class="background-preview"
                                id="background-preview"
                            ></span>

                        </label>

                    </div>


                    <div
                        class="field-error"
                        data-error-for="logo"
                    >
                        @error('logo')
                            {{ $message }}
                        @enderror
                    </div>


                    <div
                        class="field-error"
                        data-error-for="document_background"
                    >
                        @error('document_background')
                            {{ $message }}
                        @enderror
                    </div>


                    <div class="form-actions">

                        <button
                            class="action-button secondary-button"
                            type="button"
                            data-back="1"
                        >
                            <i class="fas fa-arrow-left"></i>

                            Retour
                        </button>


                        <button
                            class="action-button"
                            type="button"
                            data-next="3"
                        >
                            Continuer

                            <i class="fas fa-arrow-right"></i>
                        </button>

                    </div>

                </section>


                {{-- =================================================
                     STEP 3
                ================================================== --}}

                <section
                    class="step"
                    data-step="3"
                >

                    <div class="step-heading">

                        <h1>
                            Comment souhaitez-vous commencer ?
                        </h1>

                        <p>
                            Choisissez une formule pour poursuivre la création de votre espace.
                        </p>

                    </div>


                    <input
                        type="hidden"
                        name="formule"
                        value="{{ old('formule', 'essai') }}"
                        data-plan-value
                    >


                    <div class="plan-grid">

                        {{-- FREE --}}

                        <label
                            class="plan-card plan-free"
                            data-plan="essai"
                        >

                            <input
                                type="radio"
                                name="formule_choice"
                                value="essai"
                            >

                            <h2>
                                ESSAI GRATUIT
                            </h2>

                            <p>
                                Découvrez Gestion de Stock avant de choisir votre formule.
                            </p>

                            <ul class="plan-list">

                                <li>
                                    <i class="fas fa-check"></i>
                                    Gestion des produits
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Gestion du stock
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Clients et fournisseurs
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Devis et factures
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Tableau de bord
                                </li>

                            </ul>

                            <span class="plan-action">

                                Commencer l'essai

                                <i class="fas fa-arrow-right"></i>

                            </span>

                        </label>


                        {{-- PAID --}}

                        <label
                            class="plan-card plan-paid"
                            data-plan="abonnement"
                        >

                            <input
                                type="radio"
                                name="formule_choice"
                                value="abonnement"
                            >

                            <h2>
                                ABONNEMENT
                            </h2>

                            <p>
                                Accédez à votre espace professionnel.
                            </p>

                            <ul class="plan-list">

                                <li>
                                    <i class="fas fa-check"></i>
                                    Gestion complète du stock
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Documents commerciaux
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Gestion clients/fournisseurs
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Espace entreprise dédié
                                </li>

                                <li>
                                    <i class="fas fa-check"></i>
                                    Support
                                </li>

                            </ul>

                            <span class="plan-action">

                                Choisir cette formule

                                <i class="fas fa-arrow-right"></i>

                            </span>

                        </label>

                    </div>


                    <div
                        class="info-note"
                        style="margin-top:20px;"
                    >

                        <i class="fas fa-circle-info"></i>

                        La formule est enregistrée comme choix de parcours.
                        Aucun paiement n'est demandé ici.

                    </div>


                    <div class="form-actions">

                        <button
                            class="action-button secondary-button"
                            type="button"
                            data-back="2"
                        >
                            <i class="fas fa-arrow-left"></i>

                            Retour
                        </button>


                        <button
                            class="action-button"
                            type="submit"
                            data-final-submit
                        >
                            Créer mon espace

                            <i class="fas fa-check"></i>
                        </button>

                    </div>

                </section>

            </form>

        </div>

    </div>


    <script>
        document.addEventListener('DOMContentLoaded', function () {

            const app =
                document.querySelector('[data-register-app]');

            const form =
                app?.querySelector('[data-register-form]');

            if (!app || !form) {
                return;
            }


            let currentStep =
                Number(app.dataset.initialStep || 1);


            const steps = [
                ...form.querySelectorAll('[data-step]')
            ];


            const progress = [
                ...app.querySelectorAll('[data-progress]')
            ];


            const planValue =
                form.querySelector('[data-plan-value]');


            /* =====================================================
               AFFICHER UNE ÉTAPE
            ===================================================== */

            const showStep = (step) => {

                currentStep = step;


                steps.forEach((item) => {

                    item.classList.toggle(
                        'is-visible',
                        Number(item.dataset.step) === step
                    );

                });


                progress.forEach((item) => {

                    const number =
                        Number(item.dataset.progress);


                    item.classList.toggle(
                        'is-active',
                        number === step
                    );


                    item.classList.toggle(
                        'is-complete',
                        number < step
                    );


                    const numberElement =
                        item.querySelector('.progress-number');


                    if (number < step) {

                        numberElement.innerHTML =
                            '<i class="fas fa-check"></i>';

                    } else {

                        numberElement.textContent =
                            `0${number}`;

                    }

                });


                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });

            };


            /* =====================================================
               ERREURS
            ===================================================== */

            const clearFieldError = (fieldName) => {

                const field =
                    form.querySelector(
                        `[name="${fieldName}"]`
                    );

                const error =
                    form.querySelector(
                        `[data-error-for="${fieldName}"]`
                    );


                if (field) {

                    field.classList.remove(
                        'input-error'
                    );

                }


                if (error) {

                    /*
                     * Ne pas effacer une erreur Laravel
                     * affichée au chargement.
                     */
                    if (!error.dataset.serverError) {
                        error.textContent = '';
                    }

                }

            };


            const showFieldError = (
                fieldName,
                message
            ) => {

                const field =
                    form.querySelector(
                        `[name="${fieldName}"]`
                    );

                const error =
                    form.querySelector(
                        `[data-error-for="${fieldName}"]`
                    );


                if (field) {

                    field.classList.add(
                        'input-error'
                    );

                }


                if (error) {

                    error.textContent = message;

                }

            };


            /* =====================================================
               VALIDATION STEP 1
            ===================================================== */

            const validateStep1 = () => {

                let valid = true;


                const name =
                    form.querySelector(
                        '[name="name"]'
                    );

                const email =
                    form.querySelector(
                        '[name="email"]'
                    );

                const password =
                    form.querySelector(
                        '[name="password"]'
                    );

                const confirmation =
                    form.querySelector(
                        '[name="password_confirmation"]'
                    );


                [
                    'name',
                    'email',
                    'password',
                    'password_confirmation'
                ].forEach(clearFieldError);


                /* NAME */

                if (!name.value.trim()) {

                    showFieldError(
                        'name',
                        'Le nom complet est obligatoire.'
                    );

                    valid = false;
                }


                /* EMAIL */

                if (!email.value.trim()) {

                    showFieldError(
                        'email',
                        "L'adresse email est obligatoire."
                    );

                    valid = false;

                } else if (!email.validity.valid) {

                    showFieldError(
                        'email',
                        'Veuillez saisir une adresse email valide.'
                    );

                    valid = false;
                }


                /* PASSWORD */

                if (!password.value) {

                    showFieldError(
                        'password',
                        'Le mot de passe est obligatoire.'
                    );

                    valid = false;

                } else if (password.value.length < 8) {

                    showFieldError(
                        'password',
                        'Le mot de passe doit contenir au moins 8 caractères.'
                    );

                    valid = false;
                }


                /* CONFIRMATION */

                if (!confirmation.value) {

                    showFieldError(
                        'password_confirmation',
                        'Veuillez confirmer votre mot de passe.'
                    );

                    valid = false;

                } else if (
                    confirmation.value !== password.value
                ) {

                    showFieldError(
                        'password_confirmation',
                        'Les mots de passe ne correspondent pas.'
                    );

                    valid = false;
                }


                return valid;
            };


            /* =====================================================
               VALIDATION STEP 2
            ===================================================== */

            const validateStep2 = () => {

                let valid = true;


                const companyName =
                    form.querySelector(
                        '[name="entreprise_name"]'
                    );

                const companyEmail =
                    form.querySelector(
                        '[name="entreprise_email"]'
                    );


                [
                    'entreprise_name',
                    'entreprise_email'
                ].forEach(clearFieldError);


                /* NOM ENTREPRISE */

                if (!companyName.value.trim()) {

                    showFieldError(
                        'entreprise_name',
                        "Le nom de l'entreprise est obligatoire."
                    );

                    valid = false;
                }


                /* EMAIL ENTREPRISE */

                if (
                    companyEmail.value.trim() &&
                    !companyEmail.validity.valid
                ) {

                    showFieldError(
                        'entreprise_email',
                        'Veuillez saisir une adresse email valide.'
                    );

                    valid = false;
                }


                return valid;
            };


            /* =====================================================
               NEXT
            ===================================================== */

            app.querySelectorAll('[data-next]')
                .forEach((button) => {

                    button.addEventListener(
                        'click',
                        () => {

                            let valid = true;


                            if (currentStep === 1) {

                                valid =
                                    validateStep1();

                            }


                            if (currentStep === 2) {

                                valid =
                                    validateStep2();

                            }


                            if (!valid) {

                                const firstError =
                                    form.querySelector(
                                        '.input-error'
                                    );


                                if (firstError) {

                                    firstError.focus();

                                    firstError.scrollIntoView({
                                        behavior: 'smooth',
                                        block: 'center'
                                    });

                                }

                                return;
                            }


                            showStep(
                                Number(
                                    button.dataset.next
                                )
                            );

                        }
                    );

                });


            /* =====================================================
               BACK
            ===================================================== */

            app.querySelectorAll('[data-back]')
                .forEach((button) => {

                    button.addEventListener(
                        'click',
                        () => {

                            showStep(
                                Number(
                                    button.dataset.back
                                )
                            );

                        }
                    );

                });


            /* =====================================================
               VALIDATION EN TEMPS RÉEL
            ===================================================== */

            form.querySelectorAll(
                'input:not([type="file"]), textarea'
            ).forEach((field) => {

                field.addEventListener(
                    'input',
                    () => {

                        if (
                            field.value.trim() !== ''
                        ) {

                            clearFieldError(
                                field.name
                            );

                        }


                        /*
                         * Vérification confirmation
                         */
                        if (
                            field.name ===
                            'password_confirmation'
                        ) {

                            const password =
                                form.querySelector(
                                    '[name="password"]'
                                );


                            if (
                                field.value &&
                                password.value &&
                                field.value !== password.value
                            ) {

                                showFieldError(
                                    'password_confirmation',
                                    'Les mots de passe ne correspondent pas.'
                                );

                            }

                        }

                    }
                );

            });


            /* =====================================================
               CHOIX FORMULE
            ===================================================== */

            app.querySelectorAll('[data-plan]')
                .forEach((card) => {

                    card.addEventListener(
                        'click',
                        () => {

                            const plan =
                                card.dataset.plan;


                            if (planValue) {

                                planValue.value =
                                    plan;

                            }


                            app.querySelectorAll(
                                '[data-plan]'
                            ).forEach((item) => {

                                item.classList.toggle(
                                    'selected',
                                    item.dataset.plan === plan
                                );

                            });


                            const radio =
                                card.querySelector(
                                    'input[type="radio"]'
                                );


                            if (radio) {

                                radio.checked = true;

                            }

                        }
                    );

                });


            /* =====================================================
               PRÉVISUALISATION FICHIERS
            ===================================================== */

            app.querySelectorAll(
                'input[type="file"]'
            ).forEach((input) => {

                input.addEventListener(
                    'change',
                    () => {

                        const file =
                            input.files[0];


                        const box =
                            app.querySelector(
                                `[data-upload-box="${input.name}"]`
                            );


                        const target =
                            document.getElementById(
                                input.dataset.previewTarget
                            );


                        if (!file || !target) {
                            return;
                        }


                        const url =
                            URL.createObjectURL(file);


                        if (box) {

                            box.classList.add(
                                'has-file'
                            );

                        }


                        if (
                            target.tagName === 'IMG'
                        ) {

                            target.src = url;

                        } else {

                            target.style.backgroundImage =
                                `url("${url}")`;

                        }


                        target.classList.add(
                            'is-visible'
                        );

                    }
                );

            });


            /* =====================================================
               INITIALISATION
            ===================================================== */

            showStep(currentStep);


            const selectedPlan =
                planValue?.value || 'essai';


            const selectedCard =
                app.querySelector(
                    `[data-plan="${selectedPlan}"]`
                );


            if (selectedCard) {

                selectedCard.classList.add(
                    'selected'
                );


                const radio =
                    selectedCard.querySelector(
                        'input[type="radio"]'
                    );


                if (radio) {

                    radio.checked = true;

                }

            }

        });
    </script>

</x-guest-layout>