<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description"
        content="Gestion de Stock : centralisez vos produits, stocks, clients, fournisseurs et documents commerciaux dans une seule plateforme.">

    <meta name="robots" content="index,follow">

    <title>Gestion de Stock | Gérez votre activité simplement</title>

    <link rel="icon" href="{{ asset('favicon.ico') }}" type="image/x-icon">

    <!-- Google/Bunny Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link
        href="https://fonts.bunny.net/css?family=dm-sans:400,500,600,700|space-grotesk:500,600,700"
        rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
        href="{{ asset('adminlte/plugins/fontawesome-free/css/all.min.css') }}">

    @if (file_exists(public_path('build/manifest.json')) || file_exists(public_path('hot')))
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    @endif

    <style>
        /* =========================================================
   BACK TO TOP
========================================================= */

.back-to-top {
    position: fixed;
    right: 24px;
    bottom: 24px;
    z-index: 1000;

    width: 46px;
    height: 46px;

    display: flex;
    align-items: center;
    justify-content: center;

    border: 0;
    border-radius: 50%;

    color: #ffffff;
    background: var(--primary);

    box-shadow: 0 8px 24px rgba(49, 94, 251, 0.28);

    cursor: pointer;

    opacity: 0;
    visibility: hidden;
    transform: translateY(15px);

    transition:
        opacity 0.25s ease,
        visibility 0.25s ease,
        transform 0.25s ease,
        background 0.2s ease,
        box-shadow 0.2s ease;
}

.back-to-top.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.back-to-top:hover {
    background: var(--primary-dark);
    box-shadow: 0 11px 28px rgba(49, 94, 251, 0.36);
    transform: translateY(-3px);
}

.back-to-top:focus {
    outline: 3px solid rgba(49, 94, 251, 0.25);
    outline-offset: 3px;
}

@media (max-width: 480px) {
    .back-to-top {
        right: 16px;
        bottom: 16px;
        width: 42px;
        height: 42px;
    }
}
        :root {
            --primary: #315efb;
            --primary-dark: #2345c6;
            --navy: #111a33;
            --text: #19223c;
            --muted: #68738d;
            --line: #e7ebf3;
            --soft: #f7f9fc;
            --white: #ffffff;
            --success: #159461;
            --warning: #be7707;
        }

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            overflow-x: hidden;
            background: var(--white);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
        }

        body,
        button,
        a {
            -webkit-font-smoothing: antialiased;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        button {
            font-family: inherit;
        }

        .site-shell {
            overflow: hidden;
        }

        .container {
            width: 100%;
            max-width: 1180px;
            margin: 0 auto;
            padding: 0 28px;
        }

        /* =========================================================
           HEADER
        ========================================================= */

        header {
            position: relative;
            z-index: 20;
            background: rgba(255, 255, 255, 0.94);
            border-bottom: 1px solid rgba(231, 235, 243, 0.7);
            backdrop-filter: blur(12px);
        }

        .nav {
            height: 78px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.06rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .brand-mark {
            position: relative;
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            background: var(--primary);
            border-radius: 10px;
            box-shadow: 0 7px 18px rgba(49, 94, 251, 0.2);
        }

        .brand-mark::after {
            position: absolute;
            width: 14px;
            height: 14px;
            content: '';
            border: 2px solid var(--white);
            border-left-color: transparent;
            border-radius: 50%;
            transform: rotate(-40deg);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .nav-links > a:not(.button) {
            color: #58647d;
            font-size: 0.9rem;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .nav-links > a:not(.button):hover {
            color: var(--primary);
        }

        /* =========================================================
           BUTTONS
        ========================================================= */

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 0.88rem;
            font-weight: 700;
            transition:
                background 0.2s ease,
                box-shadow 0.2s ease,
                transform 0.2s ease;
        }

        .button:hover {
            transform: translateY(-2px);
        }

        .button-primary {
            color: var(--white);
            background: var(--primary);
            box-shadow: 0 8px 18px rgba(49, 94, 251, 0.2);
        }

        .button-primary:hover {
            color: var(--white);
            background: var(--primary-dark);
            box-shadow: 0 11px 24px rgba(49, 94, 251, 0.28);
        }

        .button-ghost {
            color: #52617c;
        }

        .button-ghost:hover {
            background: #f1f4fa;
        }

        /* =========================================================
           HERO
        ========================================================= */

        .hero {
            position: relative;
            padding: 82px 0 104px;
            background:
                radial-gradient(
                    circle at 87% 9%,
                    rgba(113, 148, 255, 0.19),
                    transparent 30%
                ),
                linear-gradient(
                    180deg,
                    #f7f9ff 0%,
                    #ffffff 92%
                );
        }

        .hero-grid {
            display: grid;
            grid-template-columns:
                minmax(0, 0.9fr)
                minmax(450px, 1.1fr);
            gap: 58px;
            align-items: center;
        }

        .eyebrow {
            display: flex;
            align-items: center;
            gap: 9px;
            color: var(--primary);
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-transform: uppercase;
        }

        .eyebrow::before {
            width: 7px;
            height: 7px;
            content: '';
            background: var(--primary);
            border-radius: 99px;
        }

        h1,
        h2,
        h3 {
            font-family: 'Space Grotesk', sans-serif;
        }

        h1 {
            max-width: 650px;
            margin: 20px 0 23px;
            font-size: clamp(2.8rem, 5vw, 4.8rem);
            line-height: 1.02;
            letter-spacing: -0.06em;
            animation: rise-in 0.65s ease both;
        }

        h1 span {
            display: block;
            color: var(--primary);
        }

        .hero-copy {
            max-width: 550px;
            margin: 0;
            color: var(--muted);
            font-size: 1.08rem;
            line-height: 1.75;
            animation: rise-in 0.65s 0.08s ease both;
        }

        .hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 30px;
            animation: rise-in 0.65s 0.16s ease both;
        }

        .hero-note {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
            color: #78859d;
            font-size: 0.8rem;
            animation: rise-in 0.65s 0.24s ease both;
        }

        .hero-note i {
            color: #26a978;
            font-size: 0.65rem;
        }

        /* =========================================================
           DASHBOARD MOCKUP
        ========================================================= */

        .dashboard-window {
            padding: 13px;
            background: var(--white);
            border: 1px solid #dfe5f0;
            border-radius: 16px;
            box-shadow: 0 27px 70px rgba(36, 60, 125, 0.16);
            transform: rotate(1.2deg);
            animation: float-in 5s ease-in-out infinite;
        }

        .window-bar {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 3px 8px 14px;
        }

        .window-bar i {
            width: 7px;
            height: 7px;
            background: #d8dfec;
            border-radius: 50%;
        }

        .window-title {
            margin-left: 8px;
            color: #8a96aa;
            font-size: 0.63rem;
        }

        .dashboard-content {
            display: grid;
            grid-template-columns: 132px minmax(0, 1fr);
            min-height: 342px;
            overflow: hidden;
            background: #f6f8fc;
            border-radius: 10px;
        }

        .mock-sidebar {
            padding: 18px 11px;
            background: #172241;
        }

        .mock-logo {
            margin-bottom: 26px;
            padding-left: 6px;
            color: var(--white);
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.68rem;
            font-weight: 700;
        }

        .mock-nav {
            margin: 5px 0;
            padding: 8px;
            color: #9ba9c5;
            border-radius: 6px;
            font-size: 0.57rem;
        }

        .mock-nav.active {
            color: var(--white);
            background: var(--primary);
        }

        .mock-main {
            min-width: 0;
            padding: 18px;
        }

        .mock-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 17px;
        }

        .mock-heading {
            color: #1a2540;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.95rem;
            font-weight: 700;
        }

        .mock-date {
            color: #96a1b5;
            font-size: 0.56rem;
        }

        .mock-kpis {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 9px;
        }

        .mock-card {
            min-width: 0;
            padding: 11px;
            background: var(--white);
            border: 1px solid #edf0f5;
            border-radius: 8px;
        }

        .mock-card .label {
            display: block;
            overflow: hidden;
            color: #99a4b7;
            font-size: 0.5rem;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .mock-card strong {
            display: block;
            margin-top: 8px;
            color: #1a2540;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.72rem;
            line-height: 1.25;
        }

        .mock-card i {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-size: 0.65rem;
        }

        .mock-lower {
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
            gap: 10px;
            margin-top: 10px;
        }

        .mock-panel {
            min-width: 0;
            padding: 12px;
            background: var(--white);
            border: 1px solid #edf0f5;
            border-radius: 8px;
        }

        .mock-panel-title {
            margin-bottom: 13px;
            color: #66728a;
            font-size: 0.58rem;
            font-weight: 700;
        }

        .bars {
            display: flex;
            align-items: end;
            gap: 8px;
            height: 112px;
        }

        .bar {
            flex: 1;
            min-width: 5px;
            background: #d8e1ff;
            border-radius: 3px 3px 0 0;
        }

        .bar:nth-child(2),
        .bar:nth-child(5) {
            background: #7290fa;
        }

        .bar:nth-child(3) {
            background: var(--primary);
        }

        .stock-line {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f0f2f6;
        }

        .stock-name {
            color: #65718a;
            font-size: 0.55rem;
        }

        .stock-status {
            padding: 3px 6px;
            border-radius: 99px;
            font-size: 0.48rem;
        }

        .status-ok {
            color: var(--success);
            background: #e3f7ee;
        }

        .status-low {
            color: var(--warning);
            background: #fff1d9;
        }

        /* =========================================================
           SECTIONS
        ========================================================= */

        .section {
            padding: 102px 0;
        }

        .section-soft {
            background: var(--soft);
        }

        .section-heading {
            max-width: 650px;
            margin: 0 auto 45px;
            text-align: center;
        }

        .section-heading .eyebrow {
            justify-content: center;
        }

        .section-heading h2,
        .multi-copy h2 {
            margin: 14px 0;
            font-size: clamp(2rem, 3.6vw, 3rem);
            line-height: 1.1;
            letter-spacing: -0.045em;
        }

        .section-heading p,
        .multi-copy p {
            margin: 0;
            color: var(--muted);
            line-height: 1.7;
        }

        /* =========================================================
           FEATURES
        ========================================================= */

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .feature {
            padding: 27px;
            background: var(--white);
            border: 1px solid var(--line);
            border-radius: 12px;
            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                transform 0.2s ease;
        }

        .feature:hover {
            border-color: #b8c9ff;
            box-shadow: 0 16px 35px rgba(31, 56, 126, 0.08);
            transform: translateY(-4px);
        }

        .feature-icon {
            width: 43px;
            height: 43px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 22px;
            color: var(--primary);
            background: #eaf0ff;
            border-radius: 9px;
        }

        .feature:nth-child(2) .feature-icon {
            color: #11976d;
            background: #e8f8f3;
        }

        .feature:nth-child(3) .feature-icon {
            color: #d38310;
            background: #fff1df;
        }

        .feature:nth-child(4) .feature-icon {
            color: #7959c9;
            background: #f1edff;
        }

        .feature:nth-child(5) .feature-icon {
            color: #2580c4;
            background: #eaf5ff;
        }

        .feature:nth-child(6) .feature-icon {
            color: #d45265;
            background: #ffecee;
        }

        .feature h3 {
            margin: 0 0 10px;
            font-size: 1.08rem;
        }

        .feature p {
            margin: 0;
            color: var(--muted);
            font-size: 0.9rem;
            line-height: 1.65;
        }

        /* =========================================================
           WORKFLOW
        ========================================================= */

        .workflow {
            display: flex;
            justify-content: center;
            max-width: 1080px;
            margin: 48px auto 0;
        }

        .workflow-step {
            display: flex;
            flex: 1;
            align-items: center;
        }

        .workflow-card {
            min-width: 140px;
            padding: 19px 12px;
            background: var(--white);
            border: 1px solid var(--line);
            border-radius: 11px;
            box-shadow: 0 9px 22px rgba(28, 51, 110, 0.06);
            text-align: center;
        }

        .workflow-number {
            width: 23px;
            height: 23px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            background: #eaf0ff;
            border-radius: 50%;
            font-size: 0.67rem;
            font-weight: 700;
        }

        .workflow-icon {
            margin-left: 8px;
            color: var(--primary);
            font-size: 1.05rem;
        }

        .workflow-card strong {
            display: block;
            margin-top: 11px;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.83rem;
        }

        .workflow-card small {
            display: block;
            margin-top: 6px;
            color: var(--muted);
            font-size: 0.67rem;
            line-height: 1.45;
        }

        .workflow-arrow {
            margin: 0 10px;
            color: #b1bdcf;
            font-size: 1.1rem;
        }

        /* =========================================================
           ENTREPRISES
        ========================================================= */

        .multi-grid {
            display: grid;
            grid-template-columns: 0.9fr 1.1fr;
            gap: 75px;
            align-items: center;
        }

        .multi-copy h2 {
            margin: 14px 0 18px;
        }

        .multi-list {
            margin: 24px 0 0;
            padding: 0;
            list-style: none;
        }

        .multi-list li {
            display: flex;
            align-items: center;
            gap: 11px;
            margin: 13px 0;
            font-size: 0.9rem;
        }

        .check {
            width: 21px;
            height: 21px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            color: var(--success);
            background: #e4f7ee;
            border-radius: 50%;
            font-size: 0.7rem;
        }

        .company-visual {
            padding: 24px;
            background: linear-gradient(140deg, #eef3ff, #f9fbff);
            border: 1px solid #dae3f7;
            border-radius: 15px;
        }

        .company-card {
            padding: 19px;
            background: var(--white);
            border: 1px solid #e4eaf3;
            border-radius: 11px;
            box-shadow: 0 13px 30px rgba(35, 61, 130, 0.1);
        }

        .company-card + .company-card {
            margin: 17px 0 0 46px;
        }

        .company-head {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .company-avatar {
            width: 34px;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            background: #e7eeff;
            border-radius: 8px;
            font-weight: 700;
        }

        .company-head strong {
            display: block;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.83rem;
        }

        .company-head small {
            color: #94a0b3;
            font-size: 0.62rem;
        }

        .company-metrics {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-top: 20px;
        }

        .company-metrics b {
            display: block;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1rem;
        }

        .company-metrics b i {
            color: var(--primary);
        }

        .company-metrics small {
            color: #8995aa;
            font-size: 0.6rem;
        }

        /* =========================================================
           BENEFITS
        ========================================================= */

        .benefits {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 42px;
        }

        .benefit {
            text-align: center;
        }

        .benefit-icon {
            width: 52px;
            height: 52px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            color: var(--primary);
            background: #eaf0ff;
            border-radius: 50%;
            font-size: 1.2rem;
        }

        .benefit:nth-child(2) .benefit-icon {
            color: #11976d;
            background: #e8f8f3;
        }

        .benefit:nth-child(3) .benefit-icon {
            color: #d38310;
            background: #fff1df;
        }

        .benefit h3 {
            margin: 0 0 10px;
            font-size: 1.1rem;
        }

        .benefit p {
            max-width: 280px;
            margin: 0 auto;
            color: var(--muted);
            font-size: 0.9rem;
            line-height: 1.65;
        }

        /* =========================================================
           CTA
        ========================================================= */

        .cta {
            position: relative;
            overflow: hidden;
            padding: 70px 30px;
            color: var(--white);
            background:
                radial-gradient(
                    circle at 12% 20%,
                    rgba(102, 139, 255, 0.25),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 80%,
                    rgba(64, 95, 207, 0.3),
                    transparent 32%
                ),
                var(--navy);
            border-radius: 17px;
            text-align: center;
        }

        .cta-content {
            position: relative;
            z-index: 1;
        }

        .cta h2 {
            margin: 0 0 12px;
            font-size: clamp(2rem, 4vw, 3.2rem);
            letter-spacing: -0.045em;
        }

        .cta p {
            margin: 0 auto 27px;
            color: #aeb9d3;
        }

        .cta .button-primary {
            color: var(--primary);
            background: var(--white);
            box-shadow: none;
        }

        .cta .button-primary:hover {
            color: var(--primary);
            background: #edf2ff;
        }

        /* =========================================================
           FOOTER
        ========================================================= */

        footer {
            padding: 30px 0;
            color: #7d899f;
            font-size: 0.82rem;
            border-top: 1px solid var(--line);
        }

        .footer-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
        }

        .footer-brand-copy {
            margin-top: 7px;
            color: #8a96aa;
            font-size: 0.75rem;
        }

        .footer-links {
            display: flex;
            flex-wrap: wrap;
            gap: 22px;
        }

        .footer-links a {
            transition: color 0.2s ease;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        /* =========================================================
           ANIMATIONS
        ========================================================= */

        @keyframes rise-in {
            from {
                opacity: 0;
                transform: translateY(15px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float-in {
            0%,
            100% {
                transform: rotate(1.2deg) translateY(0);
            }

            50% {
                transform: rotate(1.2deg) translateY(-6px);
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                scroll-behavior: auto !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* =========================================================
           TABLET
        ========================================================= */

        @media (max-width: 960px) {

            .hero-grid,
            .multi-grid {
                grid-template-columns: 1fr;
            }

            .hero-grid {
                gap: 44px;
            }

            .hero-copy,
            h1 {
                max-width: 720px;
            }

            .dashboard-window {
                max-width: 700px;
                margin: 0 auto;
                transform: none;
            }

            .multi-grid {
                gap: 42px;
            }

            .company-visual {
                max-width: 650px;
            }

            .workflow {
                flex-wrap: wrap;
                gap: 15px;
            }

            .workflow-step {
                min-width: 180px;
            }

            .workflow-arrow {
                display: none;
            }
        }

        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 760px) {

            .container {
                padding: 0 20px;
            }

            .nav {
                height: 70px;
            }

            .nav-links > a:not(.button) {
                display: none;
            }

            .nav-links {
                gap: 5px;
            }

            .nav-links .button {
                padding: 10px 12px;
                font-size: 0.76rem;
            }

            .hero {
                padding: 60px 0 72px;
            }

            .hero-actions .button {
                flex: 1;
                min-width: 175px;
            }

            .dashboard-content {
                grid-template-columns: 94px minmax(0, 1fr);
            }

            .mock-sidebar {
                padding: 16px 7px;
            }

            .mock-main {
                padding: 12px;
            }

            .mock-kpis {
                gap: 5px;
            }

            .mock-card {
                padding: 8px;
            }

            .mock-lower {
                grid-template-columns: 1fr;
            }

            .mock-lower .mock-panel:last-child {
                display: none;
            }

            .features {
                grid-template-columns: 1fr 1fr;
            }

            .section {
                padding: 75px 0;
            }

            .workflow {
                max-width: 290px;
                flex-direction: column;
                align-items: stretch;
            }

            .workflow-step {
                flex-direction: column;
            }

            .workflow-card {
                width: 100%;
            }

            .workflow-arrow {
                display: block;
                margin: 9px 0;
                transform: rotate(90deg);
            }

            .benefits {
                grid-template-columns: 1fr;
                gap: 35px;
            }

            .benefit p {
                max-width: 430px;
            }

            .footer-inner {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 480px) {

            .brand {
                font-size: 0.95rem;
            }

            .brand-mark {
                width: 33px;
                height: 33px;
            }

            .nav-links .button {
                padding: 9px 10px;
                font-size: 0.72rem;
            }

            h1 {
                font-size: 2.55rem;
            }

            .hero-copy {
                font-size: 1rem;
            }

            .hero-actions {
                flex-direction: column;
            }

            .hero-actions .button {
                width: 100%;
            }

            .features {
                grid-template-columns: 1fr;
            }

            .company-card + .company-card {
                margin-left: 20px;
            }

            .company-metrics {
                grid-template-columns: repeat(2, 1fr);
            }

            .dashboard-content {
                grid-template-columns: 1fr;
            }

            .mock-sidebar {
                display: none;
            }

            .mock-kpis {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .mock-card:nth-child(4) {
                grid-column: span 2;
            }

            .mock-card .label {
                font-size: 0.55rem;
            }

            .mock-card strong {
                font-size: 0.82rem;
            }

            .footer-links {
                gap: 14px;
            }
        }
    </style>
</head>

<body>

<div class="site-shell">

    <!-- =========================================================
         HEADER
    ========================================================== -->

    <header>
        <div class="container nav">

            <a class="brand" href="{{ url('/') }}" aria-label="Gestion de Stock - Accueil">
                <span class="brand-mark" aria-hidden="true"></span>
                <span>Gestion de Stock</span>
            </a>

            <nav class="nav-links" aria-label="Navigation principale">

                <a href="#fonctionnalites">
                    Fonctionnalités
                </a>

                <a href="#comment-ca-marche">
                    Comment ça marche
                </a>

                <a href="#entreprises">
                    Entreprises
                </a>

                @auth

                    <a class="button button-primary" href="{{ url('/dashboard') }}">
                        Tableau de bord
                        <i class="fas fa-arrow-right" aria-hidden="true"></i>
                    </a>

                @else

                    <a class="button button-ghost" href="{{ route('login') }}">
                        Se connecter
                    </a>

                    <a class="button button-primary" href="{{ route('register') }}">
                        Créer mon entreprise
                    </a>

                @endauth

            </nav>

        </div>
    </header>


    <!-- =========================================================
         MAIN
    ========================================================== -->

    <main>

        <!-- HERO -->

        <section class="hero">

            <div class="container hero-grid">

                <div>

                    <div class="eyebrow">
                        Gestion commerciale & stock
                    </div>

                    <h1>
                        Votre activité.
                        <br>
                        Votre stock.
                        <br>
                        <span>Un seul espace.</span>
                    </h1>

                    <p class="hero-copy">
                        Centralisez vos produits, vos stocks, vos clients
                        et vos documents commerciaux dans une plateforme
                        simple conçue pour votre quotidien.
                    </p>

                    <div class="hero-actions">

                        @auth

                            <a class="button button-primary"
                               href="{{ url('/dashboard') }}">
                                Accéder au tableau de bord
                                <i class="fas fa-arrow-right" aria-hidden="true"></i>
                            </a>

                        @else

                            <a class="button button-primary"
                               href="{{ route('register') }}">
                                Créer mon entreprise
                                <i class="fas fa-arrow-right" aria-hidden="true"></i>
                            </a>

                            <a class="button button-ghost"
                               href="{{ route('login') }}">
                                Se connecter
                            </a>

                        @endauth

                    </div>

                    <div class="hero-note">
                        <i class="fas fa-check-circle" aria-hidden="true"></i>
                        <span>Simple à prendre en main</span>
                        <span>·</span>
                        <span>Pensé pour les entreprises</span>
                    </div>

                </div>


                <!-- DASHBOARD PREVIEW -->

                <div class="dashboard-window"
                     aria-label="Aperçu du tableau de bord Gestion de Stock">

                    <div class="window-bar">
                        <i aria-hidden="true"></i>
                        <i aria-hidden="true"></i>
                        <i aria-hidden="true"></i>

                        <span class="window-title">
                            aperçu de votre espace de gestion
                        </span>
                    </div>

                    <div class="dashboard-content">

                        <aside class="mock-sidebar">

                            <div class="mock-logo">
                                GESTION DE STOCK
                            </div>

                            <div class="mock-nav active">
                                <i class="fas fa-chart-pie"></i>
                                &nbsp; Vue d'ensemble
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-box"></i>
                                &nbsp; Produits
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-users"></i>
                                &nbsp; Clients
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-truck"></i>
                                &nbsp; Fournisseurs
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-file-invoice"></i>
                                &nbsp; Documents
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-layer-group"></i>
                                &nbsp; Stock
                            </div>

                            <div class="mock-nav">
                                <i class="fas fa-sliders"></i>
                                &nbsp; Paramètres
                            </div>

                        </aside>


                        <div class="mock-main">

                            <div class="mock-top">

                                <span class="mock-heading">
                                    Vue d'ensemble
                                </span>

                                <span class="mock-date">
                                    Votre espace
                                </span>

                            </div>


                            <div class="mock-kpis">

                                <div class="mock-card">
                                    <i class="fas fa-box"></i>
                                    <span class="label">Produits</span>
                                    <strong>Votre catalogue</strong>
                                </div>

                                <div class="mock-card">
                                    <i class="fas fa-layer-group"></i>
                                    <span class="label">Stock</span>
                                    <strong>Suivi en temps réel</strong>
                                </div>

                                <div class="mock-card">
                                    <i class="fas fa-users"></i>
                                    <span class="label">Clients</span>
                                    <strong>Votre portefeuille</strong>
                                </div>

                                <div class="mock-card">
                                    <i class="fas fa-file-invoice"></i>
                                    <span class="label">Documents</span>
                                    <strong>Cycle commercial</strong>
                                </div>

                            </div>


                            <div class="mock-lower">

                                <div class="mock-panel">

                                    <div class="mock-panel-title">
                                        Activité de votre espace
                                    </div>

                                    <div class="bars">
                                        <span class="bar" style="height: 42%"></span>
                                        <span class="bar" style="height: 64%"></span>
                                        <span class="bar" style="height: 84%"></span>
                                        <span class="bar" style="height: 57%"></span>
                                        <span class="bar" style="height: 73%"></span>
                                        <span class="bar" style="height: 93%"></span>
                                        <span class="bar" style="height: 68%"></span>
                                    </div>

                                </div>


                                <div class="mock-panel">

                                    <div class="mock-panel-title">
                                        État du stock
                                    </div>

                                    <div class="stock-line">
                                        <span class="stock-name">
                                            Stock normal
                                        </span>

                                        <span class="stock-status status-ok">
                                            <i class="fas fa-check"></i>
                                        </span>
                                    </div>

                                    <div class="stock-line">
                                        <span class="stock-name">
                                            À surveiller
                                        </span>

                                        <span class="stock-status status-low">
                                            <i class="fas fa-eye"></i>
                                        </span>
                                    </div>

                                    <div class="stock-line">
                                        <span class="stock-name">
                                            Rupture
                                        </span>

                                        <span class="stock-status status-low">
                                            <i class="fas fa-exclamation"></i>
                                        </span>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             FEATURES
        ====================================================== -->

        <section class="section" id="fonctionnalites">

            <div class="container">

                <div class="section-heading">

                    <div class="eyebrow">
                        Une vision claire, au même endroit
                    </div>

                    <h2>
                        Tout ce dont vous avez besoin,
                        au même endroit.
                    </h2>

                    <p>
                        Une gestion centralisée pour garder le contrôle
                        de votre activité et retrouver rapidement
                        les informations importantes.
                    </p>

                </div>


                <div class="features">

                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-box" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Gestion des produits
                        </h3>

                        <p>
                            Organisez vos produits, catégories, prix
                            et informations essentielles.
                        </p>

                    </article>


                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-layer-group" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Suivi du stock
                        </h3>

                        <p>
                            Visualisez les niveaux de stock et identifiez
                            rapidement les situations à surveiller.
                        </p>

                    </article>


                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-users" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Clients & fournisseurs
                        </h3>

                        <p>
                            Centralisez vos contacts et gardez toutes
                            vos informations commerciales accessibles.
                        </p>

                    </article>


                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-file-invoice" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Documents commerciaux
                        </h3>

                        <p>
                            Devis, commandes, livraisons, factures
                            et avoirs dans un même environnement.
                        </p>

                    </article>


                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-building" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Gestion d'entreprise
                        </h3>

                        <p>
                            Un espace dédié à votre entreprise pour
                            organiser vos données et votre activité.
                        </p>

                    </article>


                    <article class="feature">

                        <div class="feature-icon">
                            <i class="fas fa-chart-line" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Tableau de bord
                        </h3>

                        <p>
                            Une vue synthétique pour suivre les informations
                            essentielles de votre activité.
                        </p>

                    </article>

                </div>

            </div>

        </section>


        <!-- =====================================================
             WORKFLOW
        ====================================================== -->

        <section class="section section-soft" id="comment-ca-marche">

            <div class="container">

                <div class="section-heading">

                    <div class="eyebrow">
                        Un flux commercial lisible
                    </div>

                    <h2>
                        Un flux commercial simple et clair.
                    </h2>

                    <p>
                        Suivez vos opérations étape par étape,
                        du premier devis jusqu'au règlement.
                    </p>

                </div>


                <div class="workflow">

                    <div class="workflow-step">

                        <div class="workflow-card">

                            <span class="workflow-number">
                                01
                            </span>

                            <i class="workflow-icon fas fa-file-signature"
                               aria-hidden="true"></i>

                            <strong>Devis</strong>

                            <small>
                                Préparez votre proposition commerciale.
                            </small>

                        </div>

                        <span class="workflow-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </span>

                    </div>


                    <div class="workflow-step">

                        <div class="workflow-card">

                            <span class="workflow-number">
                                02
                            </span>

                            <i class="workflow-icon fas fa-cart-shopping"
                               aria-hidden="true"></i>

                            <strong>Bon de commande</strong>

                            <small>
                                Transformez la demande en commande.
                            </small>

                        </div>

                        <span class="workflow-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </span>

                    </div>


                    <div class="workflow-step">

                        <div class="workflow-card">

                            <span class="workflow-number">
                                03
                            </span>

                            <i class="workflow-icon fas fa-truck-fast"
                               aria-hidden="true"></i>

                            <strong>Bon de livraison</strong>

                            <small>
                                Suivez la livraison des produits.
                            </small>

                        </div>

                        <span class="workflow-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </span>

                    </div>


                    <div class="workflow-step">

                        <div class="workflow-card">

                            <span class="workflow-number">
                                04
                            </span>

                            <i class="workflow-icon fas fa-file-invoice-dollar"
                               aria-hidden="true"></i>

                            <strong>Facture</strong>

                            <small>
                                Émettez votre facture.
                            </small>

                        </div>

                        <span class="workflow-arrow">
                            <i class="fas fa-arrow-right"></i>
                        </span>

                    </div>


                    <div class="workflow-step">

                        <div class="workflow-card">

                            <span class="workflow-number">
                                05
                            </span>

                            <i class="workflow-icon fas fa-hand-holding-dollar"
                               aria-hidden="true"></i>

                            <strong>Règlement</strong>

                            <small>
                                Gardez une vision claire des règlements.
                            </small>

                        </div>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             ENTREPRISES
        ====================================================== -->

        <section class="section" id="entreprises">

            <div class="container multi-grid">

                <div class="multi-copy">

                    <div class="eyebrow">
                        Une organisation par entreprise
                    </div>

                    <h2>
                        Chaque entreprise possède
                        son propre espace.
                    </h2>

                    <p>
                        Gestion de Stock est conçu pour permettre à chaque
                        entreprise de travailler avec ses propres produits,
                        clients, fournisseurs, documents et stocks.
                    </p>

                    <ul class="multi-list">

                        <li>
                            <span class="check">
                                <i class="fas fa-check"></i>
                            </span>

                            Un espace adapté à chaque entreprise
                        </li>

                        <li>
                            <span class="check">
                                <i class="fas fa-check"></i>
                            </span>

                            Des données organisées par entreprise
                        </li>

                        <li>
                            <span class="check">
                                <i class="fas fa-check"></i>
                            </span>

                            Une gestion indépendante de l'activité
                        </li>

                    </ul>

                </div>


                <div class="company-visual">

                    <div class="company-card">

                        <div class="company-head">

                            <span class="company-avatar">
                                <i class="fas fa-building"></i>
                            </span>

                            <div>
                                <strong>Entreprise A</strong>
                                <small>Votre espace de travail</small>
                            </div>

                        </div>


                        <div class="company-metrics">

                            <div>
                                <b><i class="fas fa-box"></i></b>
                                <small>Produits</small>
                            </div>

                            <div>
                                <b><i class="fas fa-users"></i></b>
                                <small>Clients</small>
                            </div>

                            <div>
                                <b><i class="fas fa-layer-group"></i></b>
                                <small>Stock</small>
                            </div>

                            <div>
                                <b><i class="fas fa-file"></i></b>
                                <small>Documents</small>
                            </div>

                        </div>

                    </div>


                    <div class="company-card">

                        <div class="company-head">

                            <span class="company-avatar">
                                <i class="fas fa-building"></i>
                            </span>

                            <div>
                                <strong>Entreprise B</strong>
                                <small>Un espace indépendant</small>
                            </div>

                        </div>


                        <div class="company-metrics">

                            <div>
                                <b><i class="fas fa-box"></i></b>
                                <small>Produits</small>
                            </div>

                            <div>
                                <b><i class="fas fa-users"></i></b>
                                <small>Clients</small>
                            </div>

                            <div>
                                <b><i class="fas fa-layer-group"></i></b>
                                <small>Stock</small>
                            </div>

                            <div>
                                <b><i class="fas fa-file"></i></b>
                                <small>Documents</small>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             BENEFITS
        ====================================================== -->

        <section class="section section-soft">

            <div class="container">

                <div class="section-heading">

                    <div class="eyebrow">
                        Ce qui compte au quotidien
                    </div>

                    <h2>
                        Une gestion plus claire au quotidien.
                    </h2>

                </div>


                <div class="benefits">

                    <article class="benefit">

                        <div class="benefit-icon">
                            <i class="fas fa-clock" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Gagnez du temps
                        </h3>

                        <p>
                            Retrouvez vos informations et vos documents
                            depuis un seul espace.
                        </p>

                    </article>


                    <article class="benefit">

                        <div class="benefit-icon">
                            <i class="fas fa-compass" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Gardez le contrôle
                        </h3>

                        <p>
                            Suivez vos produits et vos stocks sans multiplier
                            les fichiers et les outils.
                        </p>

                    </article>


                    <article class="benefit">

                        <div class="benefit-icon">
                            <i class="fas fa-eye" aria-hidden="true"></i>
                        </div>

                        <h3>
                            Travaillez avec une vision claire
                        </h3>

                        <p>
                            Centralisez vos opérations commerciales pour mieux
                            suivre votre activité.
                        </p>

                    </article>

                </div>

            </div>

        </section>


        <!-- =====================================================
             CTA
        ====================================================== -->

        <section class="section">

            <div class="container">

                <div class="cta">

                    <div class="cta-content">

                        <h2>
                            Prêt à simplifier votre gestion ?
                        </h2>

                        <p>
                            Créez votre entreprise et commencez à centraliser
                            votre activité dans un seul espace.
                        </p>

                        @auth

                            <a class="button button-primary"
                               href="{{ url('/dashboard') }}">
                                Accéder au tableau de bord
                                <i class="fas fa-arrow-right"></i>
                            </a>

                        @else

                            <a class="button button-primary"
                               href="{{ route('register') }}">
                                Créer mon entreprise
                                <i class="fas fa-arrow-right"></i>
                            </a>

                        @endauth

                    </div>

                </div>

            </div>

        </section>

    </main>


    <!-- =========================================================
         FOOTER
    ========================================================== -->

    <footer>

        <div class="container footer-inner">

            <div>

                <a class="brand"
                   href="{{ url('/') }}"
                   aria-label="Gestion de Stock - Accueil">

                    <span class="brand-mark" aria-hidden="true"></span>

                    <span>Gestion de Stock</span>

                </a>

                <div class="footer-brand-copy">
                    Une gestion simple et centralisée pour votre activité.
                </div>

            </div>


            <div class="footer-links">

                <a href="#fonctionnalites">
                    Fonctionnalités
                </a>

                <a href="#comment-ca-marche">
                    Comment ça marche
                </a>

                <a href="#entreprises">
                    Entreprises
                </a>

                <a href="{{ route('login') }}">
                    Se connecter
                </a>

                <a href="{{ route('register') }}">
                    Créer mon entreprise
                </a>

            </div>


            <div>
                © {{ date('Y') }} Gestion de Stock.
                Tous droits réservés.
            </div>

        </div>

    </footer>

</div>
<!-- Bouton retour en haut -->
<button id="backToTop"
        class="back-to-top"
        type="button"
        aria-label="Retour en haut"
        title="Retour en haut">
    <i class="fas fa-arrow-up" aria-hidden="true"></i>
</button>
<script>
    document.addEventListener('DOMContentLoaded', function () {

        const backToTop = document.getElementById('backToTop');

        if (!backToTop) {
            return;
        }

        window.addEventListener('scroll', function () {

            if (window.scrollY > 400) {
                backToTop.classList.add('show');
            } else {
                backToTop.classList.remove('show');
            }

        }, { passive: true });

        backToTop.addEventListener('click', function () {

            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });

        });

    });
</script>
</body>
</html>

