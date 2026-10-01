-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 18 sep. 2026 à 18:07
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `laravel`
--

-- --------------------------------------------------------

--
-- Structure de la table `achats`
--

CREATE TABLE `achats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numero_achat` varchar(255) NOT NULL,
  `num` int(10) UNSIGNED NOT NULL,
  `annee` year(4) NOT NULL,
  `fournisseur_id` bigint(20) UNSIGNED NOT NULL,
  `date_commande` date NOT NULL,
  `date_echeance` date DEFAULT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `montant_paye` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reste_a_payer` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('en_cours','partiellement_paye','paye','annule') NOT NULL DEFAULT 'en_cours',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `achat_products`
--

CREATE TABLE `achat_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `achat_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `avoirs`
--

CREATE TABLE `avoirs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numero_avoir` varchar(255) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `bon_livraison_id` bigint(20) UNSIGNED DEFAULT NULL,
  `facture_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_avoir` date NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `status` enum('en_cours','valide','annule') NOT NULL DEFAULT 'en_cours',
  `motif` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `avoirs`
--

INSERT INTO `avoirs` (`id`, `entreprise_id`, `user_id`, `numero_avoir`, `client_id`, `bon_livraison_id`, `facture_id`, `date_avoir`, `total_ht`, `tva`, `total_ttc`, `status`, `motif`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'AV001/26', 2, NULL, 1, '2026-09-15', '400.00', '20.00', '480.00', 'en_cours', NULL, 'test', '2026-09-15 18:38:35', '2026-09-15 18:38:35');

-- --------------------------------------------------------

--
-- Structure de la table `avoir_products`
--

CREATE TABLE `avoir_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `avoir_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `motif_retour` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `avoir_products`
--

INSERT INTO `avoir_products` (`id`, `entreprise_id`, `user_id`, `avoir_id`, `product_id`, `quantity`, `unit_price`, `total`, `motif_retour`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 13, 20, '20.00', '400.00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `bon_commandes`
--

CREATE TABLE `bon_commandes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numero_bon_commande` varchar(255) NOT NULL,
  `num` int(10) UNSIGNED NOT NULL,
  `annee` year(4) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `date_commande` date NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `devis_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('en_cours','recu','annule') NOT NULL DEFAULT 'en_cours',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_commandes`
--

INSERT INTO `bon_commandes` (`id`, `entreprise_id`, `user_id`, `numero_bon_commande`, `num`, `annee`, `client_id`, `date_commande`, `total_ht`, `tva`, `total_ttc`, `devis_id`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'BC001/26', 1, 2026, 7, '2026-09-16', '2000.00', '20.00', '2400.00', 3, 'recu', NULL, '2026-09-15 15:43:58', '2026-09-15 15:53:40'),
(3, 1, NULL, 'BC003/26', 3, 2026, 2, '2026-09-17', '36060.00', '20.00', '43272.00', NULL, 'recu', NULL, '2026-09-15 15:52:51', '2026-09-15 15:52:51');

-- --------------------------------------------------------

--
-- Structure de la table `bon_commande_products`
--

CREATE TABLE `bon_commande_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bon_commande_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_commande_products`
--

INSERT INTO `bon_commande_products` (`id`, `entreprise_id`, `user_id`, `bon_commande_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(3, 1, NULL, 3, 4, 100, '360.00', '36000.00', NULL, NULL),
(4, 1, NULL, 3, 8, 10, '6.00', '60.00', NULL, NULL),
(5, 1, NULL, 1, 13, 100, '20.00', '2000.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `bon_com_achats`
--

CREATE TABLE `bon_com_achats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `num` int(10) UNSIGNED NOT NULL,
  `annee` year(4) NOT NULL,
  `numero_bc_achat` varchar(255) NOT NULL,
  `fournisseur_id` bigint(20) UNSIGNED NOT NULL,
  `date_bc_achat` date NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `status` enum('brouillon','livré','accepte','refuse') NOT NULL DEFAULT 'brouillon',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_com_achats`
--

INSERT INTO `bon_com_achats` (`id`, `entreprise_id`, `user_id`, `num`, `annee`, `numero_bc_achat`, `fournisseur_id`, `date_bc_achat`, `total_ht`, `tva`, `total_ttc`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 2026, 'BC01/26', 2, '2026-09-18', '6100.00', '20.00', '7320.00', 'livré', NULL, '2026-09-17 09:45:31', '2026-09-17 09:45:31');

-- --------------------------------------------------------

--
-- Structure de la table `bon_com_product_achats`
--

CREATE TABLE `bon_com_product_achats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bon_com_achat_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_com_product_achats`
--

INSERT INTO `bon_com_product_achats` (`id`, `entreprise_id`, `user_id`, `bon_com_achat_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 2, 100, '55.00', '5500.00', NULL, NULL),
(2, 1, NULL, 1, 9, 100, '6.00', '600.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `bon_livraisons`
--

CREATE TABLE `bon_livraisons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `num` int(11) NOT NULL,
  `annee` year(4) NOT NULL,
  `numero_bon_livraison` varchar(255) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `bon_commande_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_livraison` date NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `status` enum('En attente','livré','annulé') NOT NULL DEFAULT 'En attente',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_livraisons`
--

INSERT INTO `bon_livraisons` (`id`, `entreprise_id`, `user_id`, `num`, `annee`, `numero_bon_livraison`, `client_id`, `bon_commande_id`, `date_livraison`, `total_ht`, `tva`, `total_ttc`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 2026, 'BL01/26', 2, 1, '2026-09-18', '2550.00', '20.00', '3060.00', 'livré', NULL, '2026-09-15 16:09:37', '2026-09-15 16:11:25');

-- --------------------------------------------------------

--
-- Structure de la table `bon_livraison_products`
--

CREATE TABLE `bon_livraison_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bon_livraison_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bon_livraison_products`
--

INSERT INTO `bon_livraison_products` (`id`, `entreprise_id`, `user_id`, `bon_livraison_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 13, 100, '20.00', '2000.00', NULL, NULL),
(2, 1, NULL, 1, 2, 10, '55.00', '550.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `entreprise_id`, `user_id`, `name`, `description`) VALUES
(1, 1, NULL, 'PLOMBERIE', NULL),
(2, 1, NULL, 'SANITAIRE', NULL),
(3, 1, NULL, 'QUINCAILLERIE', NULL),
(4, 1, NULL, 'ELECTRICITE', NULL),
(5, 1, NULL, 'PEINTURE', NULL),
(6, 1, NULL, 'CHAUFFE EAU', NULL),
(7, 1, NULL, 'ROBINETTERIE', NULL),
(8, 1, NULL, 'NETTOYAGE', NULL),
(9, 1, NULL, 'DIVERS', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ice` varchar(255) DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `credit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `entreprise_id`, `user_id`, `name`, `tel`, `email`, `ice`, `adresse`, `credit`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'CLIENTS DIVERS', NULL, NULL, NULL, '0', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(2, 1, NULL, 'ENDOMMAGEMENT', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(3, 1, NULL, 'ABDERAHIM', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(4, 1, NULL, 'STOCK', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(5, 1, NULL, 'AJUSTEMENT STOCK 02/05/20', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(6, 1, NULL, 'DECO PLAZA', NULL, NULL, '1764572000046,00', NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(7, 1, NULL, 'EPT SARL BANACER', NULL, NULL, '2031081000054,00', NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(8, 1, NULL, 'M AVENUE MANAGEMENT CO SARL', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(9, 1, NULL, 'Mövenpick Hotel Mansour', NULL, NULL, NULL, 'Eddahbi Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(10, 1, NULL, 'IVAM (ALSA)', NULL, NULL, '200741000062,00', 'Ferme Ahzib Achayech, Ferkat. Ain Dada, Askedjour Saada- Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(11, 1, NULL, 'Park Hyatt Marrakech', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(12, 1, NULL, 'Mandarin Oriental, Marrakech Park Palmeraie SA', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(13, 1, NULL, 'ELITE HOSITALITY MANAGEMEN S.A SELMAN MARRAKECH', NULL, NULL, '1525304000082,00', 'Km5 rte d\'Amizmiz Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(14, 1, NULL, 'FERMA DITM S.A', NULL, NULL, NULL, 'Rue Ibrahim El Mazini, Hivernage.', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(15, 1, NULL, 'MANDARIN ORIENTAL,', NULL, NULL, NULL, 'MARRAKECH Park Palmeraie SA', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(16, 1, NULL, 'MANDARIN ORIENTAL', NULL, NULL, NULL, 'MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(17, 1, NULL, 'Armonia Facilities,', NULL, NULL, NULL, 'Immeuble California Garden –Batiment A', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(18, 1, NULL, 'Alhif 1 Park Hyatt', NULL, NULL, NULL, '#NOM?', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(19, 1, NULL, 'HUM\'S MULTISERVICES', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(20, 1, NULL, 'Mandarin Oriental, Marrakech\nPark Palmeraie SA', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(21, 1, NULL, 'MAGASIN TECHNIQUE', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(22, 1, NULL, 'ELITE HOSPITALITY', NULL, NULL, NULL, 'MANAGEMENT-Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(23, 1, NULL, 'HOTEL SELMAN', NULL, NULL, NULL, 'MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(24, 1, NULL, 'M-Avenue,', NULL, NULL, NULL, 'Marrakech .', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(25, 1, NULL, 'IVAM-MARRAKECH', NULL, NULL, NULL, 'Ferme Ahzib Achayech,', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(26, 1, NULL, 'JetexExecutiveAviationMorocco', NULL, NULL, NULL, 'MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(27, 1, NULL, 'Mövenpick Hôtel Mansour Eddahbi', NULL, NULL, NULL, 'Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(28, 1, NULL, 'KEY AGENCY MAROC', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(29, 1, NULL, 'UM6P,', NULL, NULL, NULL, 'BENGUERIR', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(30, 1, NULL, 'ELITE HOSPITALITY MANAGEMENT-', NULL, NULL, NULL, 'Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(31, 1, NULL, 'ELITE HOSITALITY MANAGEMENT', NULL, NULL, NULL, 'S.A SELMAN MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(32, 1, NULL, 'PARK HYATT MARRAKECH', NULL, NULL, NULL, '145 ENNAKHIL SUD MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(33, 1, NULL, 'Mövenpick Hotel & Resorts', NULL, NULL, NULL, 'Marrakech', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(34, 1, NULL, 'Hyatt Parck03/10/2025', NULL, NULL, NULL, 'Hyatt Parck03/10/2025', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(35, 1, NULL, 'STE YASASONA SA', 'IF 4017171', NULL, 'ICE  000020071000022', 'WIDIANE, CHEMIN DU LAC-BIN EL OUIDANE                   ROUTE DE OUAOUIZERTE-BP44 AZILAL MAROC', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(36, 1, NULL, 'Hotel Park Hyatt', NULL, NULL, NULL, '#NOM?', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(37, 1, NULL, 'Hôtel Widiane -AZILAL', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(38, 1, NULL, 'Beldi Fusion Kitchen-Marrakech', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(39, 1, NULL, 'Hôtel Mandarin -Marrakech', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(40, 1, NULL, 'Hotel LONGUE VIE', NULL, NULL, NULL, 'Hassan II, 40000 Marrakech.', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(41, 1, NULL, 'ELITE HOSPITALITY MANAGEMENT S.R', NULL, NULL, NULL, 'SELMAN MARRAKECH', '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(42, 1, NULL, 'ES SAADI', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04'),
(43, 1, NULL, 'IVAM', NULL, NULL, NULL, NULL, '0.00', '2026-09-15 12:53:04', '2026-09-15 12:53:04');

-- --------------------------------------------------------

--
-- Structure de la table `devis`
--

CREATE TABLE `devis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numero_devis` varchar(255) NOT NULL,
  `num` int(10) UNSIGNED NOT NULL,
  `annee` year(4) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `date_devis` date NOT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `status` enum('brouillon','envoye','accepte','refuse') NOT NULL DEFAULT 'brouillon',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `devis`
--

INSERT INTO `devis` (`id`, `entreprise_id`, `user_id`, `numero_devis`, `num`, `annee`, `client_id`, `date_devis`, `total_ht`, `tva`, `total_ttc`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(3, 1, NULL, '01/26', 1, 2026, 7, '2026-09-16', '75.00', '20.00', '90.00', 'accepte', NULL, '2026-09-15 15:43:04', '2026-09-15 15:43:58');

-- --------------------------------------------------------

--
-- Structure de la table `devis_products`
--

CREATE TABLE `devis_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `devis_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `devis_products`
--

INSERT INTO `devis_products` (`id`, `entreprise_id`, `user_id`, `devis_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 3, 1, 1, '10.00', '10.00', NULL, NULL),
(2, 1, NULL, 3, 12, 1, '65.00', '65.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

CREATE TABLE `entreprises` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `tel` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ice` varchar(50) DEFAULT NULL,
  `adresse` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `document_background` varchar(255) DEFAULT NULL,
  `document_logo_position` varchar(100) NOT NULL DEFAULT 'left',
  `document_primary_color` varchar(100) NOT NULL DEFAULT '#315EFB',
  `document_secondary_color` varchar(100) NOT NULL DEFAULT '#64748B'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `entreprises`
--

INSERT INTO `entreprises` (`id`, `name`, `tel`, `email`, `ice`, `adresse`, `created_at`, `updated_at`, `logo`, `document_background`, `document_logo_position`, `document_primary_color`, `document_secondary_color`) VALUES
(1, 'RPSP', '065555', 'NN@gmail.com', '', '', NULL, NULL, '', '', '', '', ''),
(2, 'nezha nez', '0629888924', 'dev.nezha.25@gmail.com', NULL, 'maroc', '2026-09-15 16:19:20', '2026-09-15 16:19:20', '', '', '', '', ''),
(3, 'MALAK BOUDINI', '0629888924', 'nezhabd.elaoud@gmail.com', NULL, 'BERRADI 2 IMM 20 APP 3', '2026-09-18 15:51:52', '2026-09-18 15:51:52', NULL, NULL, 'left', '#315EFB', '#64748B');

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `num` int(11) NOT NULL,
  `annee` year(4) NOT NULL,
  `numero_facture` varchar(255) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `bon_livraison_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_facture` date NOT NULL,
  `date_echeance` date DEFAULT NULL,
  `total_ht` decimal(10,2) NOT NULL,
  `tva` decimal(5,2) NOT NULL DEFAULT 20.00,
  `total_ttc` decimal(10,2) NOT NULL,
  `montant_paye` double NOT NULL,
  `status` enum('non_payee','payee','annulee') NOT NULL DEFAULT 'non_payee',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id`, `entreprise_id`, `user_id`, `num`, `annee`, `numero_facture`, `client_id`, `bon_livraison_id`, `date_facture`, `date_echeance`, `total_ht`, `tva`, `total_ttc`, `montant_paye`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 2026, 'F001/26', 2, 1, '2026-09-18', '2026-10-18', '2550.00', '20.00', '3060.00', 0, 'payee', NULL, '2026-09-15 16:11:25', '2026-09-15 18:36:50');

-- --------------------------------------------------------

--
-- Structure de la table `facture_products`
--

CREATE TABLE `facture_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `facture_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `facture_products`
--

INSERT INTO `facture_products` (`id`, `entreprise_id`, `user_id`, `facture_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 13, 100, '20.00', '2000.00', NULL, NULL),
(2, 1, NULL, 1, 2, 10, '55.00', '550.00', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

CREATE TABLE `fournisseurs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ice` varchar(255) DEFAULT NULL,
  `tel` varchar(100) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fournisseurs`
--

INSERT INTO `fournisseurs` (`id`, `entreprise_id`, `user_id`, `name`, `email`, `ice`, `tel`, `adresse`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'SOCOP', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(2, 1, NULL, 'AMALKIS', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(3, 1, NULL, 'Somarcom', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(4, 1, NULL, 'Naamane', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(5, 1, NULL, 'SANI RAMA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(6, 1, NULL, 'Sarriri', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(7, 1, NULL, 'Tayb', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(8, 1, NULL, 'Hafid massar', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(9, 1, NULL, 'Idriss', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(10, 1, NULL, 'ALI', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(11, 1, NULL, 'KHALID ELEC', NULL, NULL, '661132798', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(12, 1, NULL, 'MONSEF', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(13, 1, NULL, 'tawfik elec', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(14, 1, NULL, 'ABDELHAKIM', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(15, 1, NULL, 'DALIL MOHAMED', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(16, 1, NULL, 'FOURNISSEURS DIVERS', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(17, 1, NULL, 'BRAHIM', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(18, 1, NULL, 'RACHID TEMME CASA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(19, 1, NULL, 'FOURNISSEUR BOULON', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(20, 1, NULL, 'HOUSSINE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(21, 1, NULL, 'ALI MASSAR', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(22, 1, NULL, 'kamal naamane', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(23, 1, NULL, 'AZROIAL', NULL, NULL, '691185352', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(24, 1, NULL, 'JAMAL', NULL, NULL, '667055758', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(25, 1, NULL, 'MOUBAREK', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(26, 1, NULL, 'HOUSSIN OLORF', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(27, 1, NULL, 'ARIHA NADAFA', NULL, NULL, '64517942', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(28, 1, NULL, 'ELECTRO AZIZI', NULL, NULL, '22980290', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(29, 1, NULL, 'SAAIDE', NULL, NULL, '673410641', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(30, 1, NULL, 'MOHAMED ROUDANI', NULL, NULL, '670505674', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(31, 1, NULL, 'SANI MARK', 'sanimark.ste@gmai.com', NULL, NULL, 'ROUTE DE CASA. SIDI ABBAD II Imm Chkili N3 Magasin 3 Marrakech', '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(32, 1, NULL, 'ARIHA FASSI', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(33, 1, NULL, 'FOURNISSEUR RUE LAAOUN', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(34, 1, NULL, 'FOURNISSEUR CLE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(35, 1, NULL, 'ELMOKHTAR', NULL, NULL, '661826576', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(36, 1, NULL, 'LYAZIDE MASSAR', NULL, NULL, '634479434', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(37, 1, NULL, 'FOURNISEUR  MOSQUEE MASSAR', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(38, 1, NULL, 'HANANE MOHAMED CIMENT', NULL, NULL, '642756087', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(39, 1, NULL, 'LAASRI RACHID TAZI', NULL, NULL, '675245029', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(40, 1, NULL, 'YOUSSEF', NULL, NULL, '707834344', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(41, 1, NULL, 'STOCK', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(42, 1, NULL, 'SANITAIRE ALOUSRA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(43, 1, NULL, 'elwardi', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(44, 1, NULL, 'AJUSTEMENT  STOCK 02/05/20', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(45, 1, NULL, 'AZIZ', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(46, 1, NULL, 'AKOJAN', NULL, NULL, '524490208', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(47, 1, NULL, 'SALAH CASA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(48, 1, NULL, 'ABDERAHIM PEINTURE', NULL, NULL, '676993895', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(49, 1, NULL, 'ABDEKARIM MSALA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(50, 1, NULL, 'droguerie chrif', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(51, 1, NULL, 'HAMID', NULL, NULL, '668049092', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(52, 1, NULL, 'MOSTAPHA', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(53, 1, NULL, 'abdelmoghit sabri', NULL, NULL, '670971301', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(54, 1, NULL, 'ASTRAL', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(55, 1, NULL, 'lotfy tounsi', NULL, NULL, '663241407', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(56, 1, NULL, 'BRICO ZAMZAM', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(57, 1, NULL, 'AHMAD (abdelah)', NULL, NULL, '662372558', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(58, 1, NULL, 'hamza', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(59, 1, NULL, 'ABDEALI', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(60, 1, NULL, 'OHAMANE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(61, 1, NULL, 'RAMADEX', NULL, NULL, '631481773', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(62, 1, NULL, 'MOHAMED PVC', NULL, NULL, '603601834', 'SIMOHAMED PVC A PARTIR DE 14/12/2023', '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(63, 1, NULL, 'BOUAIS', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(64, 1, NULL, 'SANI MARROU', NULL, NULL, '677318007', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(65, 1, NULL, 'AHAMANE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(66, 1, NULL, 'GON LED ELECTRIQUE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(67, 1, NULL, 'FASSI DAOUDIAT ABDELKRIM', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(68, 1, NULL, 'abdelah labattant', NULL, NULL, '674427493', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(69, 1, NULL, 'OMAR RUE LAAIOUN ELECTRICITE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(70, 1, NULL, 'ABDELAH RUE LAAOUN PEINTURE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(71, 1, NULL, 'SANITIRE OUCHEN (abdelah)', NULL, NULL, '707188666', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(72, 1, NULL, 'UNIDAD', NULL, NULL, '522282398', 'unidadsarl@gmail.com', '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(73, 1, NULL, 'RIDA', NULL, NULL, '676552440', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(74, 1, NULL, 'CERATUBE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(75, 1, NULL, 'HAJ OSCAR', NULL, NULL, '617129442', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(76, 1, NULL, 'saratube', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(77, 1, NULL, 'SANILED CITY', NULL, NULL, '661181868', '345 AL MASSIRA ROUTE DE SAFI', '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(78, 1, NULL, 'AHMED SANITAIRE', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(79, 1, NULL, 'SOUFIANE', NULL, NULL, '620208054', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(80, 1, NULL, 'presto ceratube', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(81, 1, NULL, 'BOUJMAA BALAI', NULL, NULL, NULL, NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(82, 1, NULL, 'araplast', 'vente@araplast.ma', NULL, '522569072', 'casa', '2026-09-15 12:53:27', '2026-09-15 12:53:27'),
(83, 1, NULL, 'YOUSSEF QUINCAIL', NULL, NULL, '648781312', NULL, '2026-09-15 12:53:27', '2026-09-15 12:53:27');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_09_11_000000_create_entreprises_table', 1),
(2, '2026_09_11_000001_create_users_table', 1),
(3, '2026_09_11_000002_create_cache_table', 1),
(4, '2026_09_11_000003_create_jobs_table', 1),
(5, '2026_09_11_000004_create_password_reset_tokens_table', 1),
(6, '2026_09_11_000005_create_sessions_table', 1),
(7, '2026_09_11_000010_create_categories_table', 1),
(8, '2026_09_11_000011_create_unites_table', 1),
(9, '2026_09_11_000012_create_clients_table', 1),
(10, '2026_09_11_000013_create_fournisseurs_table', 1),
(11, '2026_09_11_000014_create_products_table', 1),
(12, '2026_09_11_000020_create_devis_table', 1),
(13, '2026_09_11_000021_create_devis_products_table', 1),
(14, '2026_09_11_000022_create_bon_commandes_table', 1),
(15, '2026_09_11_000023_create_bon_commande_products_table', 1),
(16, '2026_09_11_000024_create_bon_livraisons_table', 1),
(17, '2026_09_11_000025_create_bon_livraison_products_table', 1),
(18, '2026_09_11_000026_create_factures_table', 1),
(19, '2026_09_11_000027_create_facture_products_table', 1),
(20, '2026_09_11_000030_create_avoirs_table', 1),
(21, '2026_09_11_000031_create_avoir_products_table', 1),
(22, '2026_09_11_000040_create_achats_table', 1),
(23, '2026_09_11_000041_create_achat_products_table', 1),
(24, '2026_09_11_000042_create_bon_com_achats_table', 1),
(25, '2026_09_11_000043_create_bon_com_product_achats_table', 1),
(26, '2026_09_11_000050_create_reglements_fournisseurs_table', 1),
(27, '2026_09_11_000051_create_reglement_clients_table', 1),
(28, '2026_09_11_000052_create_reglement_facture_table', 1),
(29, '2026_09_11_000053_create_reglement_bon_reception_table', 1),
(30, '2026_09_11_000060_create_retours_table', 1);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `marque` varchar(255) DEFAULT NULL,
  `quantity` double NOT NULL,
  `min_qte` double NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `unite_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'BOULON LAVABO 1ER BLISTER', NULL, NULL, 10, 10, '10.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(2, 1, NULL, 'ABATTANT ZOOM ABP', NULL, NULL, 0, 1, '55.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 16:09:37'),
(3, 1, NULL, 'ECHELLE ALUMINIUM 4 MARKO', NULL, NULL, 10, 0, '240.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(4, 1, NULL, 'ECHELLE ALUMINIUM 6 MARKO', NULL, NULL, 10, 0, '360.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(5, 1, NULL, 'ECHELLE ALUMINIUM 5 MARKO', NULL, NULL, 10, 0, '300.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(6, 1, NULL, 'PAPIER RESIN 60 MANGOUSTE', NULL, NULL, 10, 1, '6.00', 3, 2, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(7, 1, NULL, 'PAPIER RESIN 80 MANGOUSTE', NULL, NULL, 10, 1, '6.00', 3, 2, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(8, 1, NULL, 'PAPIER RESIN 100 MANCOUSTE', NULL, NULL, 10, 1, '6.00', 3, 2, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(9, 1, NULL, 'PAPIER RESIN 50 MANGOUSTE', NULL, NULL, 10, 1, '6.00', 3, 2, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(10, 1, NULL, 'PAPIER RESIN 40 MANGOUSTE', NULL, NULL, 10, 1, '6.00', 3, 2, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(11, 1, NULL, 'EVIER INOX 90*50 SAF', NULL, NULL, 10, 0, '100.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(12, 1, NULL, 'EVIER INOX 40*50 SAF', NULL, NULL, 10, 0, '65.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(13, 1, NULL, 'SIPHON 32CREAPLAST', NULL, NULL, -70, 5, '20.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 18:38:35'),
(14, 1, NULL, 'SIPHON 40 CREAPLAST A/B', NULL, NULL, 10, 5, '25.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(15, 1, NULL, 'SIPHON WC PM PS', NULL, NULL, 10, 5, '12.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(16, 1, NULL, 'DISQUE 180*6.5 DEBRAY  METAL', NULL, NULL, 10, 2, '15.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(17, 1, NULL, 'DISQUE 180*3.2 DEBRAY COUPE / METAL', NULL, NULL, 10, 2, '15.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(18, 1, NULL, 'DISQUE 230*6.5 DEBRAY METAL', NULL, NULL, 10, 2, '23.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(19, 1, NULL, 'DISQUE MOSAIQUE 60 CECROPS 1 ER', NULL, NULL, 10, 2, '25.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(20, 1, NULL, 'DISQUE MOSAIQUE 36 CECROPS 1 ER', NULL, NULL, 10, 2, '25.00', 3, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(21, 1, NULL, 'REDUCTION 110*50ABP', NULL, NULL, 10, 6, '8.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(22, 1, NULL, 'REDUCTION PVC110*45PS', NULL, NULL, 10, 6, '7.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(23, 1, NULL, 'REDUCTION PVC110/100PS', NULL, NULL, 10, 6, '7.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(24, 1, NULL, 'REDUCTION PVC 110*75', NULL, NULL, 10, 6, '7.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(25, 1, NULL, 'REDUCTION 3 TROUS 110*40*40 ABP', NULL, NULL, 10, 6, '13.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(26, 1, NULL, 'BOUCHON 32 ABP', NULL, NULL, 10, 10, '3.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(27, 1, NULL, 'BOUCHON 40 PS', NULL, NULL, 10, 10, '3.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(28, 1, NULL, 'BOUCHON 50 ABP', NULL, NULL, 10, 10, '4.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(29, 1, NULL, 'BOUCHON 75PS', NULL, NULL, 10, 10, '10.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(30, 1, NULL, 'BOUCHON 100PS', NULL, NULL, 10, 6, '12.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(31, 1, NULL, 'BOUCHON 110 PS', NULL, NULL, 10, 6, '12.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(32, 1, NULL, 'COLLIER GALVANISE 75+VIS (HK-15)', NULL, NULL, 10, 6, '8.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(33, 1, NULL, 'COLLIER GALVANISE 100+VIS (HK-16)', NULL, NULL, 10, 6, '9.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(34, 1, NULL, 'COLLIER GALVANISE 110+VIS (HK-17)', NULL, NULL, 10, 6, '10.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(35, 1, NULL, 'COLLIERS ATLAS 16+VIS', NULL, NULL, 10, 20, '1.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(36, 1, NULL, 'COLLIERS ATLAS 18+VIS', NULL, NULL, 10, 20, '1.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(37, 1, NULL, 'COLLIERS ATLAS NY 20+VIS', NULL, NULL, 10, 20, '1.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(38, 1, NULL, 'COLLIERS ATLAS NY 22+VIS', NULL, NULL, 10, 20, '1.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(39, 1, NULL, 'COLLIERS ATLAS NY 32+VIS', NULL, NULL, 10, 20, '2.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(40, 1, NULL, 'COLLIERS ATLAS NY 40+VIS', NULL, NULL, 10, 20, '2.00', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(41, 1, NULL, 'COLLIERS ATLAS NY 50+VIS', NULL, NULL, 10, 20, '2.50', 1, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(42, 1, NULL, 'SIEGE A LA TURQUIE RIF JACOB BLANC E1465-00', NULL, NULL, 10, 1, '165.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(43, 1, NULL, 'CUVETTE +MECNIS+ABATANT  BLANC  JACOB', NULL, NULL, 10, 1, '750.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(44, 1, NULL, 'RESERVOIR BRIVE NON EQUIPE AL BLANC JACOB', NULL, NULL, 10, 1, '0.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(45, 1, NULL, 'LAVABO50 JACOB BLANC BRIVE', NULL, NULL, 10, 1, '345.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(46, 1, NULL, 'COLONNE LAVABO BRIVE NUE BLANC JACOB', NULL, NULL, 10, 1, '170.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(47, 1, NULL, 'LAVABO55 JACOB BLANC BRIVE', NULL, NULL, 10, 1, '350.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(48, 1, NULL, 'LAVABO 60 JACOB BLANC  BRIVE', NULL, NULL, 10, 1, '290.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(49, 1, NULL, 'LAVE MAIN ORCA 45', NULL, NULL, 10, 1, '140.00', 2, 1, '2026-09-15 12:47:08', '2026-09-15 12:47:08'),
(50, 1, NULL, 'LAVE MAIN ORCA 35', NULL, NULL, 10, 1, '140.00', 2, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(51, 1, NULL, 'COUDE90* PS 50', NULL, NULL, 10, 20, '4.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(52, 1, NULL, 'COUDE 50 ABP/PS', NULL, NULL, 10, 20, '4.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(53, 1, NULL, 'COUDE 90*PS 40', NULL, NULL, 10, 20, '3.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(54, 1, NULL, 'COUDE PVC 40', NULL, NULL, 10, 20, '2.50', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(55, 1, NULL, 'COUDE PVC 32', NULL, NULL, 10, 20, '2.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(56, 1, NULL, 'COUDE 45* PS32', NULL, NULL, 10, 20, '2.50', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(57, 1, NULL, 'CULOTTE 45*  PS 32', NULL, NULL, 10, 20, '3.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(58, 1, NULL, 'CULOTTE 45*  PS 40', NULL, NULL, 10, 20, '4.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(59, 1, NULL, 'CULOTTE  45*PS 50', NULL, NULL, 10, 20, '5.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(60, 1, NULL, 'CULOTTE  45*PS 75', NULL, NULL, 10, 10, '8.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(61, 1, NULL, 'CULOTTE  45* PS 100', NULL, NULL, 10, 10, '18.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(62, 1, NULL, 'CULOTTE  45*PS 110', NULL, NULL, 10, 10, '20.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(63, 1, NULL, 'TEE 90* PS 32', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(64, 1, NULL, 'TEE 90* PS 40', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(65, 1, NULL, 'TEE 90* PS 50', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(66, 1, NULL, 'TEE 90* PS 75', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(67, 1, NULL, 'TEE 90* PS 100', NULL, NULL, 10, 6, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(68, 1, NULL, 'TEE 90* PS 110', NULL, NULL, 10, 6, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(69, 1, NULL, 'COUDE WC BLANC  INES', NULL, NULL, 10, 6, '25.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(70, 1, NULL, 'CULOTTE DOUBLE 100PS', NULL, NULL, 10, 2, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(71, 1, NULL, 'CULOTTE DOUBLE  110 PS', NULL, NULL, 10, 2, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(72, 1, NULL, 'CULOTTE COIN 100PS', NULL, NULL, 10, 2, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(73, 1, NULL, 'CULOTTE COIN 110PS', NULL, NULL, 10, 2, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(74, 1, NULL, 'REDUCTION PVC50*40 PS', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(75, 1, NULL, 'REDUCTION PVC75/50 PS', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(76, 1, NULL, 'REDUCTION PVC 75/40 PS', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(77, 1, NULL, 'REDUCTION PVC 100*40 PS', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(78, 1, NULL, 'REDUCTION PVC100*75 ABP', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(79, 1, NULL, 'REDUCTION PVC100/50 PVC', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(80, 1, NULL, 'REDUCTION PVC40*32 PS', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(81, 1, NULL, 'COFFRET RETUBE  40 PS PM', NULL, NULL, 10, 2, '35.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(82, 1, NULL, 'COFFRET RETUBE PS GM', NULL, NULL, 10, 2, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(83, 1, NULL, 'BOITE DE RANGEMENT M (COULEUR)', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(84, 1, NULL, 'BOITE DE RANGEMENT L (COULEUR)', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(85, 1, NULL, 'BACS PLASTIQUE 101', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(86, 1, NULL, 'COLLE PVC  1L QUILOSA', NULL, NULL, 10, 2, '65.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(87, 1, NULL, 'COLLE BOIS 500G SACOL/SAHARA/POLYCOLLE', NULL, NULL, 10, 1, '13.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(88, 1, NULL, 'COLLE PVC SADER GM', NULL, NULL, 10, 10, '12.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(89, 1, NULL, 'COLLE PVC QUILOSA PM', NULL, NULL, 10, 10, '7.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(90, 1, NULL, 'BAGUETTE FAIENCE  2.6 CHROME 2EME', NULL, NULL, 10, 10, '12.00', 2, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(91, 1, NULL, 'SILICONE QUILOSA TRSP 280ML', NULL, NULL, 10, 6, '23.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(92, 1, NULL, 'SILICONE 1ER', NULL, NULL, 10, 6, '60.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(93, 1, NULL, 'GAINE 25 BLEU PS', NULL, NULL, 10, 50, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(94, 1, NULL, 'GAINE 25 ROUGE PS', NULL, NULL, 10, 50, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(95, 1, NULL, 'GAINE 32 BLEU PS', NULL, NULL, 10, 50, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(96, 1, NULL, 'GAINE 32 ROUGE PS', NULL, NULL, 10, 50, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(97, 1, NULL, 'TUBE PVC 200 PS', NULL, NULL, 10, 2, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(98, 1, NULL, 'TUBE PVC 125 PS', NULL, NULL, 10, 2, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(99, 1, NULL, 'TUBE PVC 110 PS', NULL, NULL, 10, 6, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(100, 1, NULL, 'TUBE PVC 100 PS', NULL, NULL, 10, 6, '18.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(101, 1, NULL, 'TUBE PVC 75 PS', NULL, NULL, 10, 6, '18.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(102, 1, NULL, 'TUBE PVC 50 PS', NULL, NULL, 10, 10, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(103, 1, NULL, 'TUBE PVC 40 PS', NULL, NULL, 10, 10, '10.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(104, 1, NULL, 'TUBE PVC 32 PS', NULL, NULL, 10, 10, '0.00', 1, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(105, 1, NULL, 'COUDE PVC 110', NULL, NULL, 10, 10, '12.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(106, 1, NULL, 'COUDE 45*PS 110', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(107, 1, NULL, 'COUDE PVC 100', NULL, NULL, 10, 10, '10.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(108, 1, NULL, 'COUDE 45*ABP 100', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(109, 1, NULL, 'COUDE 90*PS 75', NULL, NULL, 10, 15, '0.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(110, 1, NULL, 'COUDE PVC 75 PS /ABP', NULL, NULL, 10, 15, '8.00', 1, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(111, 1, NULL, 'CABLE TV+NUMERIQUE 100+BOX BLEU BRITCH', NULL, NULL, 10, 50, '3.50', 4, 2, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(112, 1, NULL, 'COLLE FLAMBO G', NULL, NULL, 10, 6, '22.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(113, 1, NULL, 'COLLE  FLAMBO P', NULL, NULL, 10, 6, '6.00', 3, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(114, 1, NULL, 'BOITE DE RANGEMENT', NULL, NULL, 10, 0, '0.00', 1, 3, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(115, 1, NULL, 'BOITE DE RANGEMENT M', NULL, NULL, 10, 0, '0.00', 1, 3, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(116, 1, NULL, 'INTERRUPTEUR  SIMPLE LAP', NULL, NULL, 10, 10, '14.00', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(117, 1, NULL, 'DOUBLE VA ET VIENT BLANC LAP', NULL, NULL, 10, 10, '28.00', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(118, 1, NULL, 'VA ET VIENT BLANC LAP', NULL, NULL, 10, 10, '18.00', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(119, 1, NULL, 'SORTIE FIL MARRON LAP', NULL, NULL, 10, 10, '12.50', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(120, 1, NULL, 'PRISE SIMPLE BLANC LAP', NULL, NULL, 10, 20, '0.00', 4, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(121, 1, NULL, 'PRISE +T BLANC LAP', NULL, NULL, 10, 20, '0.00', 4, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(122, 1, NULL, 'INTER SIMPLE MARRON LAP', NULL, NULL, 10, 20, '0.00', 4, 5, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(123, 1, NULL, 'VA ET VIENT JADE ING', NULL, NULL, 10, 10, '18.00', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(124, 1, NULL, 'PRISE SIMPLE  MARRON', NULL, NULL, 10, 20, '0.00', 4, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(125, 1, NULL, 'PRISE +T  MARRON LAP', NULL, NULL, 10, 20, '0.00', 4, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(126, 1, NULL, 'DOUBLE VA ET VIENT MARRON LAP', NULL, NULL, 10, 10, '28.00', 4, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(127, 1, NULL, 'SORTIE FIL BLANC LAP', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(128, 1, NULL, 'AB FER GRIS 1K', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(129, 1, NULL, 'AB FER GRIS 5K', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(130, 1, NULL, 'AB FER ROUGE 1K', NULL, NULL, 10, 4, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(131, 1, NULL, 'AB FER ROUGE 5K', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(132, 1, NULL, 'ARCOPLAST 10K', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(133, 1, NULL, 'VINYLE 30KG ARCOPLAST 3CHOIX', NULL, NULL, 10, 1, '420.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(134, 1, NULL, 'ARCOL 30K ROSE MAMOUNIA', NULL, NULL, 10, 1, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(135, 1, NULL, 'ARCOL 5K ROSE MAMOUNIA', NULL, NULL, 10, 2, '85.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(136, 1, NULL, 'ARCOL 5K ROUGE MARRAKECH', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(137, 1, NULL, 'ARVINYL 5KG arcol', NULL, NULL, 10, 2, '100.00', 5, 5, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(138, 1, NULL, 'COLLE GRIFFE 1KG COLORADO', NULL, NULL, 10, 3, '0.00', 5, 3, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(139, 1, NULL, 'COLLE GRIFFE 4KG ATLAS', NULL, NULL, 10, 2, '0.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(140, 1, NULL, 'COLO FLEX 1KG ROUGE MARRAKECH', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(141, 1, NULL, 'DECAPANT 1L', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(142, 1, NULL, 'DILUANT ATLAS 5L', NULL, NULL, 10, 2, '75.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(143, 1, NULL, 'VINYLE 30KG ECOBLANC SUPRAFLEX PLUS 130J 2 CHOIX', NULL, NULL, 10, 1, '320.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(144, 1, NULL, 'ENDUIT ARCOL POUDRE 25K', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(145, 1, NULL, 'ESSENCE ATLAS 5L', NULL, NULL, 10, 2, '65.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(146, 1, NULL, 'ITAL VINYL 5K', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(147, 1, NULL, 'ITOVINYL 10KG', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(148, 1, NULL, 'ITOVINYL 1KG', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(149, 1, NULL, 'VINYLE 30 KG ITOVINYL  COLORADO 3 CHOIX', NULL, NULL, 10, 2, '340.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(150, 1, NULL, 'LOGICOLOR 1KG GRIS', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(151, 1, NULL, 'LOGICOLOR 1K MARRON', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(152, 1, NULL, 'LOGICOLOR 1KG NOIR', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(153, 1, NULL, 'LOGICOLOR 1K VERT', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(154, 1, NULL, 'LOGICOLOR 5KG BLANC', NULL, NULL, 10, 2, '130.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(155, 1, NULL, 'LOGICOLOR 5KG', NULL, NULL, 10, 2, '130.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(156, 1, NULL, 'MAT ARDOISINE 1KG', NULL, NULL, 10, 3, '25.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(157, 1, NULL, 'PLASTIVINYL 5KG', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(158, 1, NULL, 'SINTOFER 0.50KG', NULL, NULL, 10, 3, '0.00', 5, 5, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(159, 1, NULL, 'SINTOFER 1KG', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(160, 1, NULL, 'STOP ASTRAL 1KG', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(161, 1, NULL, 'SUPRAFLEX VINYL 1KG', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(162, 1, NULL, 'TEINTE ATLAS HUILE VIOLETTE', NULL, NULL, 10, 6, '12.00', 5, 3, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(163, 1, NULL, 'TEINTE ATLAS  L\' EAUX  ORANGE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(164, 1, NULL, 'ITOVINYL 5KG', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(165, 1, NULL, 'ARLAC   1K  GRIS PERLE 211', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(166, 1, NULL, 'ARLAC 1KG', NULL, NULL, 10, 3, '38.00', 5, 5, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(167, 1, NULL, 'ARLAC 1K CHAMOIS 503', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(168, 1, NULL, 'ARLAC 5K BLEU', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:09', '2026-09-15 12:47:09'),
(169, 1, NULL, 'ARLAC 5K BLANC', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(170, 1, NULL, 'ITRY LAQUE 1KG MARRON', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(171, 1, NULL, 'ITRY LAQUE 1KG NOIR', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(172, 1, NULL, 'LAQUE 20KG ITRY LAC  ATLAS', NULL, NULL, 10, 1, '640.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(173, 1, NULL, 'LAQUE 20KG ITOLAC COLORADO 2CHOIX', NULL, NULL, 10, 1, '0.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(174, 1, NULL, 'ITRY PLAST 5KG BLANC', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(175, 1, NULL, 'ITRY PLAST 10KG', NULL, NULL, 10, 1, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(176, 1, NULL, 'VINYLE 30 KG ITRY PLAST BLANC 2 CHOIX  ATLAS', NULL, NULL, 10, 1, '430.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(177, 1, NULL, 'LEADER MAT 1KG', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(178, 1, NULL, 'LEADER MAT 5KG', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(179, 1, NULL, 'VINYLE 30KG LEADER PLAST  ATLAS', NULL, NULL, 10, 1, '510.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(180, 1, NULL, 'LOGICOLOR 1K ROUGE', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(181, 1, NULL, 'LOGICOLOR 1KG', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(182, 1, NULL, 'LOGICOLOR 1KG BLEU CLAIR', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(183, 1, NULL, 'LOGICOLOR 1KG CHAMOIS', NULL, NULL, 10, 3, '30.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(184, 1, NULL, 'TEINTE ATLAS  L\' EAU BLEU', NULL, NULL, 10, 6, '0.00', 5, 5, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(185, 1, NULL, 'TEINTE ARCOL', NULL, NULL, 10, 6, '12.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(186, 1, NULL, 'TEINTE ATLAS  L\' EAU VIOLETTE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(187, 1, NULL, 'TEINT ATLAS  HUILE BLEU', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(188, 1, NULL, 'TEINTE ATLAS  HUILE CREME', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(189, 1, NULL, 'TEINTE ATLAS  HUILE JAUNE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(190, 1, NULL, 'TEINTE ATLAS  HUILE NOIR', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(191, 1, NULL, 'TEINTE ATLAS  HUILE ROUGE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(192, 1, NULL, 'TEINTE ATLAS  HUILE VERT', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(193, 1, NULL, 'TEINTE ATLAS L\' EAU  VERT PISTACHE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(194, 1, NULL, 'TEINTE ATLAS L\' EAU   CREME', NULL, NULL, 10, 6, '0.00', 5, 5, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(195, 1, NULL, 'TEINTE ATLAS L\' EAU  JAUNE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(196, 1, NULL, 'TEINTE ATLAS L\' EAU  NOIR', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(197, 1, NULL, 'TEINTE ATLAS L\' EAU  ROUGE BRIQUE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(198, 1, NULL, 'TEINTE ATLAS L\' EAU  VERT', NULL, NULL, 10, 6, '0.00', 5, 5, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(199, 1, NULL, 'VERNIS ARCOLE AOURACHE 1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(200, 1, NULL, 'VERNIS ATLAS BLEU 415 0.5L', NULL, NULL, 10, 6, '25.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(201, 1, NULL, 'VERNIS ATLAS BLEU 415 1L', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(202, 1, NULL, 'VERNIS BOCHE PORES 1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(203, 1, NULL, 'VERNIS MOGADOR  1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(204, 1, NULL, 'VERNIS MOGADOR NOYER 203 1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(205, 1, NULL, 'VERNIS MOGADOR WENGE 206 1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(206, 1, NULL, 'VERNIS WOOD ASTRAL NOYER 1L', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(207, 1, NULL, 'ATLAS AUTO 100G', NULL, NULL, 10, 6, '6.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(208, 1, NULL, 'ATLAS AUTO 100G BLEU', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(209, 1, NULL, 'ATLAS AUTO 100G JAUNE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(210, 1, NULL, 'ATLAS AUTO 100G MARRON', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(211, 1, NULL, 'ATLAS AUTO 100G NOIR', NULL, NULL, 10, 6, '6.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(212, 1, NULL, 'ATLAS AUTO 100G ROUGE', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(213, 1, NULL, 'ATLAS AUTO 100G VERT', NULL, NULL, 10, 6, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(214, 1, NULL, 'ATLAS AUTO 250G BLANC', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(215, 1, NULL, 'ATLAS AUTO 250G', NULL, NULL, 10, 3, '14.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(216, 1, NULL, 'ATLAS AUTO 250 G NOIR', NULL, NULL, 10, 3, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(217, 1, NULL, 'CHAUFFE EAU A GAZ MYJI', NULL, NULL, 10, 1, '1050.00', 6, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(218, 1, NULL, 'COLLE GRIFFE 30KG ATLAS', NULL, NULL, 10, 1, '520.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(219, 1, NULL, 'ENDUIT GOLD FACOP PATE 25KG', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(220, 1, NULL, 'ENDUIT ARCOL FACADE 25K', NULL, NULL, 10, 1, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(221, 1, NULL, 'FAYROUZ BLANC', NULL, NULL, 10, 2, '0.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(222, 1, NULL, 'CABLE 1.5 MM', NULL, NULL, 10, 5, '1.50', 4, 2, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(223, 1, NULL, 'CABLE 2.5MM', NULL, NULL, 10, 5, '2.50', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(224, 1, NULL, 'CIREFACOP 1L', NULL, NULL, 10, 3, '70.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(225, 1, NULL, 'VERNIS ARCOXIME 1L', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(226, 1, NULL, 'VERNIS ATLAS 5L BLEU 415', NULL, NULL, 10, 2, '0.00', 5, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(227, 1, NULL, 'CHEVILLE 8MM LAP', NULL, NULL, 10, 10, '10.00', 3, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(228, 1, NULL, 'cheville 10MM LAP', NULL, NULL, 10, 10, '10.00', 3, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(229, 1, NULL, 'ATTACHE 6 LAP', NULL, NULL, 10, 5, '10.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(230, 1, NULL, 'ATTACHE 7LAP', NULL, NULL, 10, 5, '10.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(231, 1, NULL, 'ATTACHE 8 LAP', NULL, NULL, 10, 5, '20.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(232, 1, NULL, 'ATTACHE 10MM2/LAP/boite', NULL, NULL, 10, 5, '0.00', 4, 3, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(233, 1, NULL, 'ATTACHE 12MM2/LAP/boite', NULL, NULL, 10, 5, '0.00', 4, 3, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(234, 1, NULL, 'TUBE FL.SN18W TLD18/54 765/965 PHILIPS/FROSTED ROHS', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(235, 1, NULL, 'TUBE FL.SN 36W PHILIPS TLD36/54 765/865 SL V/25 95047540', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(236, 1, NULL, 'CABLE ARME 2*10', NULL, NULL, 10, 10, '28.00', 4, 2, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(237, 1, NULL, 'COLLIER COLSON 7.6*340 100p/8*300', NULL, NULL, 10, 100, '1.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(238, 1, NULL, 'COLLIER COLSON 7.6*265 100p/S', NULL, NULL, 10, 100, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(239, 1, NULL, 'COLLIER COLSON 7.6*185 100p/S', NULL, NULL, 10, 100, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(240, 1, NULL, 'BOITE ETAN,7418/LAP', NULL, NULL, 10, 6, '18.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(241, 1, NULL, 'BOITE ETAN,7408/LAP', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(242, 1, NULL, 'VA ET VIENT  TICHKA', NULL, NULL, 10, 10, '9.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(243, 1, NULL, 'D,INTER TICHKA2 IVOIRE 5222/10', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(244, 1, NULL, 'PRISE 2P+T TICHKA IVOIRE 2 4226S', NULL, NULL, 10, 20, '12.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(245, 1, NULL, 'PRISE TV TICHKA IVOIRE 2 4227', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(246, 1, NULL, 'S,F TICHKA IVOIRE 2 4223/20', NULL, NULL, 10, 20, '0.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(247, 1, NULL, 'DOUBLE VA ET VIENT TICHKA', NULL, NULL, 10, 10, '15.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(248, 1, NULL, 'VA ET VIENT+PRISE TICHKA', NULL, NULL, 10, 10, '15.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(249, 1, NULL, 'LAMPE ST,B22 75W 220V DEPOLIE LIS 75B22D', NULL, NULL, 10, 30, '4.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(250, 1, NULL, 'LAMPE ST,B22 100W 220V DEPOLIE LIS 100B2', NULL, NULL, 10, 30, '4.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(251, 1, NULL, 'LAMPE ST,E27 75W 220V ING/PHILIPS', NULL, NULL, 10, 30, '4.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(252, 1, NULL, 'LAMPE ST,E27 100W 220V DEPOLIE LIS100E2', NULL, NULL, 10, 30, '4.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(253, 1, NULL, 'LAMPE A LED 10 W ST,B22 220V A60 10KH', NULL, NULL, 10, 12, '18.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(254, 1, NULL, 'LAMPE A LED 10 W ST,E27 220V A60 10KH', NULL, NULL, 10, 12, '18.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(255, 1, NULL, 'CADRE DECOR SERIE TICHKA 2 MARRON 5002M', NULL, NULL, 10, 20, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(256, 1, NULL, 'HUBLOT ROND EN VERRE B22 LAP  P', NULL, NULL, 10, 6, '35.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(257, 1, NULL, 'HUBLOT ROND EN VERRE B22 LAP G', NULL, NULL, 10, 6, '40.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(258, 1, NULL, 'HUBLOT OVAL A  GRILLAGE EN FER E27 NOIR', NULL, NULL, 10, 6, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(259, 1, NULL, 'CARTOUCHE.FUSIBLE 4FIL 32A 40A 63A', NULL, NULL, 10, 10, '6.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(260, 1, NULL, 'NEUTRE 14*51', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(261, 1, NULL, 'NEUTRE22*58', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(262, 1, NULL, 'FICHE 2P+T FEM LAP', NULL, NULL, 10, 10, '8.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(263, 1, NULL, 'FICHE 2P +T MALE LAP', NULL, NULL, 10, 10, '7.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(264, 1, NULL, 'PRISE 2P ETANCHE ENC.GRIS 4883', NULL, NULL, 10, 6, '35.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(265, 1, NULL, 'PRISE 2P+T ETAN/ENC/4886G', NULL, NULL, 10, 6, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(266, 1, NULL, 'PRISE 2P ETANCHE  APPARENT', NULL, NULL, 10, 6, '22.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(267, 1, NULL, 'PRISE 2P+T  ETAN/APP 4896', NULL, NULL, 10, 6, '0.00', 4, 5, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(268, 1, NULL, 'VA ET VIENT  ETANCHE ENC GRIS', NULL, NULL, 10, 6, '37.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(269, 1, NULL, 'VA ET VIENT / INTER ETANCHE APP  5891/20', NULL, NULL, 10, 6, '26.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(270, 1, NULL, 'DOUBLE VA ET VIENT  ETANCHE ENCASTRE', NULL, NULL, 10, 6, '55.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(271, 1, NULL, 'DOUBLE VA ET VIENT ETANCHE APP GRIS', NULL, NULL, 10, 6, '38.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(272, 1, NULL, 'INTER.TICHKA IVOIRE2 5221/10', NULL, NULL, 10, 6, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(273, 1, NULL, 'CABLE SV1V 4*1.5 ING NEX', NULL, NULL, 10, 40, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(274, 1, NULL, 'MOULURE 20*10/20*12 AVEC ADHESIVE', NULL, NULL, 10, 10, '6.00', 4, 2, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(275, 1, NULL, 'MOULURE 25*16 AVEC ADHESIVE CLO25-40', NULL, NULL, 10, 10, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(276, 1, NULL, 'PLINTHE 60*40 AVEC ADHESIVE CLO60-40', NULL, NULL, 10, 10, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(277, 1, NULL, 'DOUILLE B22 LAP1022', NULL, NULL, 10, 50, '4.00', 4, 1, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(278, 1, NULL, 'TUBE ORANGE Q11 LAP', NULL, NULL, 10, 100, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(279, 1, NULL, 'TUBE ORANGE Q13 LAP', NULL, NULL, 10, 100, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(280, 1, NULL, 'TUBE ORANGE Q16 LAP', NULL, NULL, 10, 100, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(281, 1, NULL, 'TUBE ORANGE Q09 LAP', NULL, NULL, 10, 100, '0.00', 4, 6, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(282, 1, NULL, 'STARTER 4-15-65W S10 PHILIPS', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:10', '2026-09-15 12:47:10'),
(283, 1, NULL, 'CABLE MTH 2*0.75', NULL, NULL, 10, 50, '2.50', 4, 2, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(284, 1, NULL, 'CABLE MTH 2*0.50', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(285, 1, NULL, 'DOUILLE B22 PLAFOND PATERE DROITE 2030-2030NV', NULL, NULL, 10, 10, '10.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(286, 1, NULL, 'DOUILLE E27 PLAFOND PATERE DROITE LAP', NULL, NULL, 10, 10, '10.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(287, 1, NULL, 'CABLE SV1V2*1.5 ING-NEX', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(288, 1, NULL, 'CABLE SV1V 2*2.5 ING-NEX', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(289, 1, NULL, 'CABLE SV1V 3*1.5 ING-NEX', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(290, 1, NULL, 'CABLE SV1V 3*2.5 ING-NEX', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(291, 1, NULL, 'BARRETTE 1002 10MM', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(292, 1, NULL, 'BARRETTE 1003 16MM 30A/30', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(293, 1, NULL, 'RALLONGE 2P+T 3P +VOY.BLL.1.5M', NULL, NULL, 10, 5, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(294, 1, NULL, 'RALLONGE 2P+T 4P+VOY.L.1.5M', NULL, NULL, 10, 5, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(295, 1, NULL, 'RALLONGE 2P+T 5P+ VOY.1.5M iINGL/SIMON', NULL, NULL, 10, 3, '40.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(296, 1, NULL, 'RALLONGE ROND 6M LAP', NULL, NULL, 10, 3, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(297, 1, NULL, 'FICHE MALE LAP 5500', NULL, NULL, 10, 10, '3.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(298, 1, NULL, 'FICHE FEMELLE LAP 5501', NULL, NULL, 10, 10, '3.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(299, 1, NULL, '(TUBE FLEX.ISOG.Q11 LEGER/ISOGRIS )ANNULE', NULL, NULL, 10, 50, '1.85', 4, 2, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(300, 1, NULL, 'TUBE FLEX.ISOG.Q16 LEGER/ISOGRIS', NULL, NULL, 10, 50, '2.50', 4, 2, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(301, 1, NULL, 'SCOTCH NOIR GM', NULL, NULL, 10, 10, '7.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(302, 1, NULL, 'SCOTCH NOIR MM /ET PM SIGMA/TISSU NOIR', NULL, NULL, 10, 10, '3.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(303, 1, NULL, 'SPOT A LED 18W PANEL ROND ENC.L.BLANCHE', NULL, NULL, 10, 1, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(304, 1, NULL, 'DISJ.1*10A/20A/16A/32 SECURIS', NULL, NULL, 10, 10, '16.00', 4, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(305, 1, NULL, 'DIS.1*16A SECURIS', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(306, 1, NULL, 'DISJ.2*32A/ 20A SECURIS', NULL, NULL, 10, 10, '35.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(307, 1, NULL, 'DISJ.1*32A', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(308, 1, NULL, 'CABLE CAPOTH.2*1.5', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(309, 1, NULL, 'BOITE ROUGE DENC.ROND LAP', NULL, NULL, 10, 20, '0.50', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(310, 1, NULL, 'BOITE VERTE ENC CARRE LAP', NULL, NULL, 10, 20, '2.50', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(311, 1, NULL, 'CABLE U500V 10NOIR', NULL, NULL, 10, 50, '0.00', 4, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(312, 1, NULL, 'CABLE U500V 6', NULL, NULL, 10, 50, '5.00', 4, 2, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(313, 1, NULL, 'COF.12MOD ENC.OPALE LAP', NULL, NULL, 10, 2, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(314, 1, NULL, 'COF.14MO/24MO +D2FIL/ENC/LAP', NULL, NULL, 10, 1, '40.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(315, 1, NULL, 'COF.20MO+D4FIL/ENC/OPAL', NULL, NULL, 10, 1, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(316, 1, NULL, 'PRISE SIMPLE TICHKA', NULL, NULL, 10, 10, '6.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(317, 1, NULL, 'BOITE ETAN LAP', NULL, NULL, 10, 10, '0.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(318, 1, NULL, 'RALLONGE 5M ING', NULL, NULL, 10, 1, '70.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(319, 1, NULL, 'FICHE TRIPLETE LAP (DOUBLE FICHE NOIR SIMPLE)', NULL, NULL, 10, 5, '5.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(320, 1, NULL, 'COFFRET DE COMPTEUR ONE 2FIL', NULL, NULL, 10, 1, '100.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(321, 1, NULL, 'boite dist a borne tadla rouge', NULL, NULL, 10, 1, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(322, 1, NULL, 'COFFRET 27+DISJONCTEUR /ENC/LAP', NULL, NULL, 10, 1, '90.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(323, 1, NULL, 'POUSSOIR  ROND TICHKA', NULL, NULL, 10, 5, '25.00', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(324, 1, NULL, 'inter de fil souple 5005/10 blanc', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(325, 1, NULL, 'prise 2p app rif 4083', NULL, NULL, 10, 10, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(326, 1, NULL, 'prise 2p+t app.rif 4086sb', NULL, NULL, 10, 3, '0.00', 4, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(327, 1, NULL, 'cheville plas 12', NULL, NULL, 10, 10, '16.00', 3, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(328, 1, NULL, 'TUBE ORANGE Q11 ING', NULL, NULL, 10, 100, '2.50', 4, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(329, 1, NULL, 'RACCORD M 16X1/2 RETUBE', NULL, NULL, 10, 20, '12.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(330, 1, NULL, 'RACCORD EGALE 16 RETUBE', NULL, NULL, 10, 20, '18.00', 1, 2, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(331, 1, NULL, 'COUDE FF 16X1/2 RETUBE', NULL, NULL, 10, 20, '16.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(332, 1, NULL, 'COUDE EGALE 16 RETUBE', NULL, NULL, 10, 20, '18.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(333, 1, NULL, 'TEE FF 16X1/2 RETUBE', NULL, NULL, 10, 20, '0.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(334, 1, NULL, 'TEE EGAL 16 RETUBE', NULL, NULL, 10, 20, '25.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(335, 1, NULL, 'COUDE BOITIER 16X1/2 RETUBE', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(336, 1, NULL, 'COUDE APPLIQUE 16X1/2 RETUBE', NULL, NULL, 10, 15, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(337, 1, NULL, 'RACCORD M 16X3/4 RETUBE', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(338, 1, NULL, 'RACCORD FF 16X3/4 RETUBE', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(339, 1, NULL, 'RACCORD EGALE 20 RETUBE', NULL, NULL, 10, 15, '27.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(340, 1, NULL, 'COUDE EGALE 20 RETUBE', NULL, NULL, 10, 15, '28.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(341, 1, NULL, 'TEE EGAL 20  RETUBE', NULL, NULL, 10, 5, '35.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(342, 1, NULL, 'RACCORD M 20X3/4 RETUBE', NULL, NULL, 10, 15, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(343, 1, NULL, 'RACCORD FF 20X3/4 RETUBE', NULL, NULL, 10, 15, '18.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(344, 1, NULL, 'COUDE M 20X1/2 RETUBE', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(345, 1, NULL, 'RACCORD M 20X1/2 RETUBE', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(346, 1, NULL, 'RACCORD FF 20X1/2 RETUBE', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(347, 1, NULL, 'VANNE PAPILLON 3/4 ROUGE', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(348, 1, NULL, 'VANNE PAPILLON 3/4 BLEU', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(349, 1, NULL, 'COUDE FF 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(350, 1, NULL, 'COUDE MF 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(351, 1, NULL, 'MAMELON 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(352, 1, NULL, 'MAMELON 1P LAITON', NULL, NULL, 10, 20, '25.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(353, 1, NULL, 'MANCHON FF 1/2 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(354, 1, NULL, 'MANCHON FF 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(355, 1, NULL, 'MOITIE 1/2X3/4 LAITON', NULL, NULL, 10, 20, '0.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(356, 1, NULL, 'MOITIE 1/2X3/8 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(357, 1, NULL, 'RACCORD MIX M 1/2 LAITON', NULL, NULL, 10, 30, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(358, 1, NULL, 'RACCORD MIX MF 3/8 LAITON', NULL, NULL, 10, 30, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(359, 1, NULL, 'RACCORD MIX M 3/8 LAITON', NULL, NULL, 10, 30, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(360, 1, NULL, 'RACCORD MIX M 3/4 LAITON', NULL, NULL, 10, 30, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(361, 1, NULL, 'REDUCTION 1/2X3/8 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(362, 1, NULL, 'REDUCTION 1/2X3/4 LAITON', NULL, NULL, 10, 20, '8.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(363, 1, NULL, 'REDUCTION 1X3/4 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(364, 1, NULL, 'REDUCTION 1X1/2 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(365, 1, NULL, 'REDUCTION 11/2X11/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(366, 1, NULL, 'TEE F 1/2 LAITON', NULL, NULL, 10, 20, '12.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(367, 1, NULL, 'TEE 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(368, 1, NULL, 'BOUCHON M 3/4 LAITON', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(369, 1, NULL, 'BOUCHON FF 3/4 LAITON', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(370, 1, NULL, 'MAMELON REDUIT 1/2X3/8 LAITON', NULL, NULL, 10, 20, '0.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(371, 1, NULL, 'CHAUFFE EAU JUNKERS 5L TIC TIC', NULL, NULL, 10, 0, '0.00', 6, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(372, 1, NULL, 'CHAUFFE EAU JUNKERS 6L GAZ', NULL, NULL, 10, 0, '0.00', 6, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(373, 1, NULL, 'CHAUFFE EAU 30L  ATLANTIC', NULL, NULL, 10, 0, '0.00', 6, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(374, 1, NULL, 'CHAUFFE EAU 50L ATLANTIC', NULL, NULL, 10, 0, '0.00', 6, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(375, 1, NULL, 'MELANGEUR LAVABO OSLO', NULL, NULL, 10, 1, '250.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(376, 1, NULL, 'MELANGEUR DOUCHE OSLO 15CM', NULL, NULL, 10, 3, '270.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(377, 1, NULL, 'MELANGEUR CUISINE  MUR OSLO 15CM', NULL, NULL, 10, 1, '260.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(378, 1, NULL, 'MELANGEUR CUISINE S/T OSLO', NULL, NULL, 10, 1, '300.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(379, 1, NULL, 'ROBINET S/T ITIMAT/ROBINET LAVABO FAUCET GM', NULL, NULL, 10, 2, '140.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(380, 1, NULL, 'ROBINET BEC MURAL OSLO', NULL, NULL, 10, 2, '120.00', 7, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(381, 1, NULL, 'MITIGEUR LAVABO CLEVER', NULL, NULL, 10, 3, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(382, 1, NULL, 'MITIGEUR DOUCHE  CLEVER', NULL, NULL, 10, 3, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(383, 1, NULL, 'MITIGEUR CUISINE  MURAL  CLEVER', NULL, NULL, 10, 2, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(384, 1, NULL, 'MITIGEUR CUISINE  S/T  CLEVER', NULL, NULL, 10, 2, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(385, 1, NULL, 'MITIGEUR LAVABO IBREGRIF', NULL, NULL, 10, 3, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(386, 1, NULL, 'MITIGEUR DOUCHE IBREGRIF', NULL, NULL, 10, 3, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(387, 1, NULL, 'MITIGEUR CUISINE  MURAL IBREGRIF', NULL, NULL, 10, 2, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(388, 1, NULL, 'MITIGEUR CUISINE  S/T IBREGRIF', NULL, NULL, 10, 2, '0.00', 7, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(389, 1, NULL, 'ppr 20coes', NULL, NULL, 10, 0, '0.00', 1, 6, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(390, 1, NULL, 'coude ff 20x1/2 coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(391, 1, NULL, 'tee ff 20x1/2 coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(392, 1, NULL, 'raccord m 20x1/2 coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(393, 1, NULL, 'raccord ff 20x1/2 coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(394, 1, NULL, 'TEE SIMPLE 20 COES', NULL, NULL, 10, 0, '6.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(395, 1, NULL, 'manchon 20coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(396, 1, NULL, 'coude 1/4 ppr 20coes', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(397, 1, NULL, 'BOUCHON M 1/2 PPR', NULL, NULL, 10, 0, '3.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(398, 1, NULL, 'ROBINET DARRET 20 COES', NULL, NULL, 10, 1, '110.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(399, 1, NULL, 'ROBINET DARRET 1/2 JAUNE TEMME', NULL, NULL, 10, 1, '70.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(400, 1, NULL, 'COUDE  EGALE 16 HTM', NULL, NULL, 10, 0, '38.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(401, 1, NULL, 'Coude M 16 1/2HTM1ER', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(402, 1, NULL, 'COUDE F 20 1/2 RETUBE', NULL, NULL, 10, 0, '18.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(403, 1, NULL, 'COUDE 1/2 LENIS MF', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(404, 1, NULL, 'COUDE 1/2 16M ARCO', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(405, 1, NULL, 'COUDE MF 1/2 HTM', NULL, NULL, 10, 20, '12.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(406, 1, NULL, 'COUDE M 16 1/2', NULL, NULL, 10, 20, '16.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(407, 1, NULL, 'COUDE F 16 1/2 arco', NULL, NULL, 10, 10, '32.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(408, 1, NULL, 'COUDE EGALE 16 ARCO', NULL, NULL, 10, 10, '26.00', 1, 5, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(409, 1, NULL, 'COUDE 1/2 F HTM', NULL, NULL, 10, 20, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(410, 1, NULL, 'COUDE APPLIQUE ;;/VILDA', NULL, NULL, 10, 1, '25.00', 1, 1, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(411, 1, NULL, 'TEE EGALE 16 HTM', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(412, 1, NULL, 'TEE 16 1/2 HTM', NULL, NULL, 10, 0, '0.00', 1, 4, '2026-09-15 12:47:11', '2026-09-15 12:47:11'),
(413, 1, NULL, 'TEE F 1/2 LAITON NON DSP', NULL, NULL, 10, 10, '18.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(414, 1, NULL, 'TEE  F 16 1/2 ITALY', NULL, NULL, 10, 10, '32.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(415, 1, NULL, 'TEE  EGALE 16 ARCO', NULL, NULL, 10, 10, '45.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(416, 1, NULL, 'Raccord EGALE HTM 16', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(417, 1, NULL, 'RACCORD M 16 1/2 HTM 1ER', NULL, NULL, 10, 10, '20.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(418, 1, NULL, 'Raccord azdn', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(419, 1, NULL, 'RACCORD 1/2 16 ARCOF', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(420, 1, NULL, 'RACCORD FEM 16 1/2 RETUBE', NULL, NULL, 10, 20, '12.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(421, 1, NULL, 'manchon 3/4 1/2', NULL, NULL, 10, 1, '0.00', 1, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(422, 1, NULL, 'MANCHON MF 1/2 LAITON PM', NULL, NULL, 10, 20, '7.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(423, 1, NULL, 'MANCHON LONG MF 1/2 TEMME', NULL, NULL, 10, 10, '17.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(424, 1, NULL, 'MANCHON COURT 1/2 TIEMME', NULL, NULL, 10, 10, '14.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(425, 1, NULL, 'MANCHON 3/4 1/2 MF LENIS', NULL, NULL, 10, 10, '0.00', 1, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(426, 1, NULL, 'MAMELON COURT 1/2 HTM', NULL, NULL, 10, 20, '8.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(427, 1, NULL, 'MAMELON COURT MM 1/2 3/4 HTM', NULL, NULL, 10, 10, '9.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(428, 1, NULL, 'COLLECTEUR 4 ROUGE 16', NULL, NULL, 10, 10, '105.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(429, 1, NULL, 'COLLECTEUR 3 ROUGE 16', NULL, NULL, 10, 10, '90.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(430, 1, NULL, 'COLLECTEUR 2 ROUGE 16', NULL, NULL, 10, 10, '60.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(431, 1, NULL, 'COLLECTEUR 3 BLEU 16', NULL, NULL, 10, 10, '90.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(432, 1, NULL, 'COLLECTEUR 4 BLEU 16', NULL, NULL, 10, 10, '105.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(433, 1, NULL, 'BOUCHON  F 3/4 LAITON HTM', NULL, NULL, 10, 1, '11.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(434, 1, NULL, 'FLEXIBLE MEL  1/2 F 1/4 M 50CM', NULL, NULL, 10, 15, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(435, 1, NULL, 'TETE ROBINET 1/2 COLASE', NULL, NULL, 10, 20, '12.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(436, 1, NULL, 'SCOTCH 3N', NULL, NULL, 10, 10, '8.00', 5, 5, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(437, 1, NULL, 'SERRURE A CYLINDRE  FF', NULL, NULL, 10, 10, '90.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(438, 1, NULL, 'SERRURE A CYLINDRE OSCAR', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(439, 1, NULL, 'robinet service 1/2 2eme', NULL, NULL, 10, 10, '35.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(440, 1, NULL, 'mitigeur lavabo 40 malaga/froide', NULL, NULL, 10, 3, '140.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(441, 1, NULL, 'MITIGEUR DOUCHE MALAGA 40', NULL, NULL, 10, 3, '150.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(442, 1, NULL, 'ROBINET  JARDIN 1/2x3/4 TABLEAU', NULL, NULL, 10, 6, '35.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(443, 1, NULL, 'ROBINET D ARRET 3/4 RELAX', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(444, 1, NULL, 'ROBINET SERVICE CHROME Blisterk /AZIZ', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(445, 1, NULL, 'ROBINET LAVABO EXEL /CUISINE MURAL EXEL- ZENITH-ROBTOP', NULL, NULL, 10, 3, '80.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(446, 1, NULL, 'ROBINET LAVABO FRANCI / CUISINE BEC', NULL, NULL, 10, 3, '70.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(447, 1, NULL, 'MECANISME POUSSOIR IDROPOL/AK6', NULL, NULL, 10, 2, '140.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(448, 1, NULL, 'GORGE LAVABO 32', NULL, NULL, 10, 3, '20.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(449, 1, NULL, 'COUDE FLEXIBLE WC', NULL, NULL, 10, 2, '40.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(450, 1, NULL, 'ENSEMBLE  ACCESSOIRE S/B CHROME', NULL, NULL, 10, 1, '150.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(451, 1, NULL, 'ROBINET WC ESP CHROME', NULL, NULL, 10, 1, '90.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(452, 1, NULL, 'TETE MELANGEUR VENTILATEUR', NULL, NULL, 10, 4, '35.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(453, 1, NULL, 'SIPHON 10X10 CUIVRE', NULL, NULL, 10, 1, '60.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(454, 1, NULL, 'ROBINET SERVICE  JAUNE 1/2 TAbl', NULL, NULL, 10, 3, '40.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(455, 1, NULL, 'ROBINET RIVER 1/2x1/2', NULL, NULL, 10, 3, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(456, 1, NULL, 'ROBINET RIVER 1/2x3/8', NULL, NULL, 10, 3, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(457, 1, NULL, 'ROBINET RIVER  1/2x3/4', NULL, NULL, 10, 1, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(458, 1, NULL, 'ENSEMBLE ACCESOIRE S/B PLAS RIVER', NULL, NULL, 10, 1, '130.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(459, 1, NULL, 'PORTE SAVON PLA/COL', NULL, NULL, 10, 4, '10.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(460, 1, NULL, 'PORTE SERVIETTE PLAS/COL', NULL, NULL, 10, 4, '10.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(461, 1, NULL, 'PORTE PAPIER PS', NULL, NULL, 10, 4, '15.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(462, 1, NULL, 'FLEX.MEL CHROME 40 2P', NULL, NULL, 10, 6, '34.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(463, 1, NULL, 'FLEX.MEL CHROME 50 2P', NULL, NULL, 10, 6, '34.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(464, 1, NULL, 'FLEX.MEL CHROME 60  saratube', NULL, NULL, 10, 6, '34.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(465, 1, NULL, 'FLEXIBLE MF 1/2 1/2 60 CM', NULL, NULL, 10, 6, '20.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(466, 1, NULL, 'FLEXIBLE MF 1/2 1/2 50CM RIVER', NULL, NULL, 10, 6, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(467, 1, NULL, 'FLEXIBLE 40/50/60', NULL, NULL, 10, 6, '20.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(468, 1, NULL, 'FLEXIBLE MF CHROME 30CM', NULL, NULL, 10, 6, '17.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(469, 1, NULL, 'FLEXIBLE FF 1/2 40 CM', NULL, NULL, 10, 6, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(470, 1, NULL, 'FLEXIBLE FF 1/2  50 CM', NULL, NULL, 10, 6, '17.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(471, 1, NULL, 'FLEXIBLE MF 1/2  60CM', NULL, NULL, 10, 6, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(472, 1, NULL, 'FLEXIBLE  FF  1/2  3/8 40 CM', NULL, NULL, 10, 6, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(473, 1, NULL, 'FLEXIBLE FF  1/2 3/8 50 CM RIVER', NULL, NULL, 10, 6, '17.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(474, 1, NULL, 'FLEXIBLE  MF 3/8 1/2 40CM RIVER', NULL, NULL, 10, 6, '17.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(475, 1, NULL, 'FLEXIBLE MF  3/8 1/2 50 CM RIVER', NULL, NULL, 10, 6, '17.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(476, 1, NULL, 'FLEXIBLE FF 3/8 1/2 60CM RIVER', NULL, NULL, 10, 6, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(477, 1, NULL, 'FLEXIBLE DOUCHE 1.5 M SIMPLE', NULL, NULL, 10, 6, '20.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(478, 1, NULL, 'FLEXIBLE DOUCHE 1.5M 2EME', NULL, NULL, 10, 6, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(479, 1, NULL, 'DOUCHETTE TABLEAU FLEX', NULL, NULL, 10, 2, '50.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(480, 1, NULL, 'DOUCHETTE COMPLET RELAX B83/B82 /KIT BEST', NULL, NULL, 10, 2, '85.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(481, 1, NULL, 'TETE DOUCHETTE SIMPLE CHROME', NULL, NULL, 10, 2, '15.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(482, 1, NULL, 'joint 1/2 grand bastia ep8', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(483, 1, NULL, 'joint fiber 3/8 1er dd ep1', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(484, 1, NULL, 'joint fiber 1er dd 1/2 ep2', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(485, 1, NULL, 'joint fiber 3/4 1er dd ep3', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(486, 1, NULL, 'JOINT ROBINET 1/2 G290 KAWATCH', NULL, NULL, 10, 50, '0.50', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(487, 1, NULL, 'joint kawatcho 3/4 g291', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(488, 1, NULL, 'joint kawatcho 3/8 g292', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(489, 1, NULL, 'joint tete rouge1/2 ep6', NULL, NULL, 10, 50, '0.00', 7, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(490, 1, NULL, 'FILTRE MELANGEUR ET ROBINET', NULL, NULL, 10, 5, '5.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(491, 1, NULL, 'FILTRE MELANGEUR M', NULL, NULL, 10, 5, '5.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(492, 1, NULL, 'ROBINET D ARRET 1/2  ALAMIA/TAB RIVER/SANIA', NULL, NULL, 10, 5, '34.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(493, 1, NULL, 'BOULON CHAUFFE EAUX', NULL, NULL, 10, 5, '10.00', 6, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(494, 1, NULL, 'BOULON LAVABO TABLEAU (N.D)', NULL, NULL, 10, 5, '10.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(495, 1, NULL, 'BOUCHON 1/2 CALVANISE', NULL, NULL, 10, 10, '2.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(496, 1, NULL, 'TETE MELANGEUR 20 TABLEAU RELAX', NULL, NULL, 10, 5, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(497, 1, NULL, 'CARTOUCHE MITIGEUR PM +FILTRE RELAX', NULL, NULL, 10, 5, '18.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(498, 1, NULL, 'CARTOUCHE MITIGEUR GM +FILTRE RELAX', NULL, NULL, 10, 5, '16.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(499, 1, NULL, 'VANNE A BILLE 1/2 ROUGE', NULL, NULL, 10, 5, '20.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(500, 1, NULL, 'TEFLON G', NULL, NULL, 10, 6, '10.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(501, 1, NULL, 'TEFLON P', NULL, NULL, 10, 6, '2.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(502, 1, NULL, 'DOUCHETTE TAHARA TABL REL /TIEMME', NULL, NULL, 10, 1, '70.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(503, 1, NULL, 'FIXATION  MITIGEUR CHROME', NULL, NULL, 10, 5, '10.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(504, 1, NULL, 'FIXATION MELANGEUR CHROM TABL', NULL, NULL, 10, 5, '10.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(505, 1, NULL, 'RACCORD MELANGEUR 1/2 3/8.3/4 ALSA/VEGAYE', NULL, NULL, 10, 5, '30.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(506, 1, NULL, 'FLEXIBLE MACHINE A LAVER AUTO 3/4 3/4', NULL, NULL, 10, 2, '25.00', 7, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(507, 1, NULL, 'COUDE BOITIER 16 MTR', NULL, NULL, 10, 5, '30.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(508, 1, NULL, 'ESSENCE 1/4L', NULL, NULL, 10, 10, '5.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(509, 1, NULL, 'DILUANT 1/4 L', NULL, NULL, 10, 10, '5.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(510, 1, NULL, 'DEBOUCHEUR CANALISATION 500G', NULL, NULL, 10, 5, '12.00', 8, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(511, 1, NULL, 'huile de bois 75cl', NULL, NULL, 10, 5, '0.00', 5, 3, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(512, 1, NULL, 'DILUANT 3/4 L', NULL, NULL, 10, 10, '12.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(513, 1, NULL, 'ESSENCE 3/4L', NULL, NULL, 10, 10, '12.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(514, 1, NULL, 'potassium lessive1l', NULL, NULL, 10, 7, '0.00', 5, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(515, 1, NULL, 'GANTS TISSU NOIR non disp', NULL, NULL, 10, 2, '10.00', 8, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(516, 1, NULL, 'DISQUE 115 COUPE/FER /ATLAS', NULL, NULL, 10, 5, '8.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(517, 1, NULL, 'TEINTE HUIL C MARRAKECH', NULL, NULL, 10, 5, '0.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(518, 1, NULL, 'FILM TIRABLE EMBALLAGE 2KG', NULL, NULL, 10, 3, '40.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(519, 1, NULL, 'VERNIS TOP 1L ATLAS', NULL, NULL, 10, 3, '40.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(520, 1, NULL, 'huile de lain 75cl', NULL, NULL, 10, 5, '20.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(521, 1, NULL, 'bombe chrome', NULL, NULL, 10, 5, '0.00', 5, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(522, 1, NULL, 'essence Jupiter 1/4', NULL, NULL, 10, 7, '0.00', 5, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(523, 1, NULL, 'DEBOUCHEUR 1/4KG', NULL, NULL, 10, 3, '8.00', 8, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(524, 1, NULL, 'MONTURE ROULEAU  PEINTURE PETIT', NULL, NULL, 10, 2, '8.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(525, 1, NULL, 'SCIE A METAUX GRIS SIMPLE/VERT JAUNE SOCOP', NULL, NULL, 10, 2, '20.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(526, 1, NULL, 'MINI MANCHON ROULEAU FIL', NULL, NULL, 10, 5, '4.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(527, 1, NULL, 'TRUELLE RONDE 20M PLASTIQ', NULL, NULL, 10, 2, '20.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(528, 1, NULL, 'elastique 1.50cm', NULL, NULL, 10, 2, '0.00', 3, 4, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(529, 1, NULL, 'LAME DE SCIE ../1er', NULL, NULL, 10, 10, '12.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(530, 1, NULL, 'PORTE PAPIER HYGIENIQUE', NULL, NULL, 10, 2, '30.00', 2, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(531, 1, NULL, 'ROULETTE 75 ORANGE', NULL, NULL, 10, 4, '30.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(532, 1, NULL, 'ROULETTE 50 ORANGE /FREIN', NULL, NULL, 10, 4, '0.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(533, 1, NULL, 'ROULETTE 40 ORANGE /FREIN', NULL, NULL, 10, 4, '15.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(534, 1, NULL, 'VA ET VIENT PLASTIC', NULL, NULL, 10, 10, '1.50', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(535, 1, NULL, 'CIRE MABROC', NULL, NULL, 10, 3, '32.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(536, 1, NULL, 'SUP 4 AVOIR', NULL, NULL, 10, 1, '0.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(537, 1, NULL, 'SUP 3 AVOIR', NULL, NULL, 10, 1, '0.00', 3, 5, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(538, 1, NULL, 'BOMBE PEINTURE', NULL, NULL, 10, 10, '15.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(539, 1, NULL, 'LAME DE CARRELAGE', NULL, NULL, 10, 3, '70.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(540, 1, NULL, 'BANDE PORTE 1ER', NULL, NULL, 10, 5, '23.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(541, 1, NULL, 'ABATTANT GLISSIER TIROIRE CHROME 30/35/40', NULL, NULL, 10, 10, '25.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(542, 1, NULL, 'ESSENCE MIDI', NULL, NULL, 10, 10, '18.00', 5, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(543, 1, NULL, 'POIGNEE  MARRON EUROAZRA/VINIZYA', NULL, NULL, 10, 2, '55.00', 3, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(544, 1, NULL, 'TUBE RETUBE 16 GRIF', NULL, NULL, 10, 10, '6.00', 1, 1, '2026-09-15 12:47:12', '2026-09-15 12:47:12'),
(545, 1, NULL, 'CLOU AIMANT 10', NULL, NULL, 10, 1, '0.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(546, 1, NULL, 'MASQUE 1ER', NULL, NULL, 10, 1, '0.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(547, 1, NULL, 'PITON  4*40/4*30', NULL, NULL, 10, 50, '1.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(548, 1, NULL, 'CROCHET  4X40', NULL, NULL, 10, 50, '0.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(549, 1, NULL, 'ROBINET', NULL, NULL, 10, 10, '0.00', 7, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(550, 1, NULL, 'SERRURE A TIRETTE ROND MICC', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(551, 1, NULL, 'CHARBONNE', NULL, NULL, 10, 10, '15.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(552, 1, NULL, 'DISQUE PONCEUSE 60/80/100', NULL, NULL, 10, 5, '6.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(553, 1, NULL, 'AGRAFEUSE', NULL, NULL, 10, 1, '0.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(554, 1, NULL, 'MECHE 12 FER', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(555, 1, NULL, 'MECHE 10 FER', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(556, 1, NULL, 'MECHE 8 FER', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(557, 1, NULL, 'MECHE 6 FER', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(558, 1, NULL, 'MECHE 5 FER', NULL, NULL, 10, 3, '5.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(559, 1, NULL, 'MECHE 4 FER', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(560, 1, NULL, 'PEAU DE  CHAMEAU', NULL, NULL, 10, 2, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(561, 1, NULL, 'PEAU DE CHAMEAU PETIT', NULL, NULL, 10, 2, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(562, 1, NULL, 'SCOTCH EMB GM', NULL, NULL, 10, 10, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(563, 1, NULL, 'SERRURE BARRETTE 9TA 30', NULL, NULL, 10, 5, '1.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(564, 1, NULL, 'SERRURE BARRETTE 9TA 40', NULL, NULL, 10, 5, '3.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(565, 1, NULL, 'SERRURE BARRETTE 9TA 50', NULL, NULL, 10, 5, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(566, 1, NULL, 'SERRURE BARRETTE 9TA  60', NULL, NULL, 10, 5, '4.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(567, 1, NULL, 'POIGNEE CLE SIMPLE  14', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(568, 1, NULL, 'POIGNEE RONDE OUJDA', NULL, NULL, 10, 5, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(569, 1, NULL, 'TENAILLE SIMPLE', NULL, NULL, 10, 2, '12.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(570, 1, NULL, 'SERRURE A CYLINDRE  SPECIAL 4 CM VENEZIA/ANBO', NULL, NULL, 10, 5, '90.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(571, 1, NULL, 'SERRURE CLE SIMPLE', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(572, 1, NULL, 'SERRURE WC/CLE SIMPLE', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(573, 1, NULL, 'METRE 3M TR', NULL, NULL, 10, 2, '8.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(574, 1, NULL, 'METRE  5M TR', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(575, 1, NULL, 'VIS 4*40', NULL, NULL, 10, 2, '0.20', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(576, 1, NULL, 'VIS 5*30', NULL, NULL, 10, 1, '0.20', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(577, 1, NULL, 'PINCE MOMTAZE/FRED', NULL, NULL, 10, 5, '25.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(578, 1, NULL, 'CARTE', NULL, NULL, 10, 10, '3.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(579, 1, NULL, 'MECHE 6 BETON', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(580, 1, NULL, 'MECHE 7 BETON', NULL, NULL, 10, 3, '9.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(581, 1, NULL, 'MECHE 8 BETON', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(582, 1, NULL, 'MECHE 10 BETON', NULL, NULL, 10, 3, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(583, 1, NULL, 'MECHE 12 BETON', NULL, NULL, 10, 3, '15.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(584, 1, NULL, 'CARTE 360', NULL, NULL, 10, 10, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(585, 1, NULL, 'VIS 3*20', NULL, NULL, 10, 2, '0.10', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(586, 1, NULL, 'VIS 4*30', NULL, NULL, 10, 2, '0.20', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(587, 1, NULL, 'VIS 5*60', NULL, NULL, 10, 2, '0.30', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(588, 1, NULL, 'VIS 3.5*30', NULL, NULL, 10, 2, '0.10', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(589, 1, NULL, 'VIS 4*20', NULL, NULL, 10, 2, '0.10', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(590, 1, NULL, 'VIS 5*40 / 4X60', NULL, NULL, 10, 2, '0.30', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(591, 1, NULL, 'VIS 4*50', NULL, NULL, 10, 2, '0.20', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(592, 1, NULL, 'VIS 5*50', NULL, NULL, 10, 2, '0.30', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(593, 1, NULL, 'GRATTOIR ENDUIT', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(594, 1, NULL, 'TOURNEVIS 2; BLEU /RESSORT JAUNE/ DRAP AMERIQ', NULL, NULL, 10, 5, '12.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(595, 1, NULL, 'TOURNEVIS KEMA', NULL, NULL, 10, 5, '8.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(596, 1, NULL, 'PISTOLET SILICONE 2EME', NULL, NULL, 10, 2, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(597, 1, NULL, 'soudeur kawia', NULL, NULL, 10, 1, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(598, 1, NULL, 'CUTTER P', NULL, NULL, 10, 2, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(599, 1, NULL, 'tableau clÃ©s molette Â chromee', NULL, NULL, 10, 1, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(600, 1, NULL, 'SERRURE A TIRIETTE  LINKE/FF', NULL, NULL, 10, 2, '90.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(601, 1, NULL, 'SERRURE  A TIRETTE BACCO 70', NULL, NULL, 10, 2, '100.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(602, 1, NULL, 'SERRURE  A TIRETTE FTN / FERRI', NULL, NULL, 10, 2, '100.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(603, 1, NULL, 'cles a molette simple', NULL, NULL, 10, 1, '0.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(604, 1, NULL, 'TESTEUR PIGEON /EPICA', NULL, NULL, 10, 5, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(605, 1, NULL, 'SERRURE TIROIR ELEPH G M/ CASTRE/OSCAR', NULL, NULL, 10, 5, '15.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(606, 1, NULL, 'TESTEUR SIMPLE', NULL, NULL, 10, 2, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(607, 1, NULL, 'SUPPORT RIDEAU 16 CHROME /face 28 pm jaune', NULL, NULL, 10, 10, '4.00', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(608, 1, NULL, 'CYLINDRE DE SERRURE 7.5CM/ EVERLE', NULL, NULL, 10, 1, '60.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(609, 1, NULL, 'TIGE  FENETRE', NULL, NULL, 10, 10, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(610, 1, NULL, 'CADENAS 66 JAUNE/50 CHROME', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(611, 1, NULL, 'CADENAS 65 JAUNE', NULL, NULL, 10, 5, '15.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(612, 1, NULL, 'CADENAS 63 JAUNE /40 COLOR', NULL, NULL, 10, 5, '8.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(613, 1, NULL, 'CLOU AIMANT 4', NULL, NULL, 10, 1, '0.20', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(614, 1, NULL, 'CYLINDRE DE SERRURE DOUBLE FEXA/VMEX', NULL, NULL, 10, 2, '50.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(615, 1, NULL, 'cylindre de serrure bs baco/ ROBISAN-LIVO 6CM', NULL, NULL, 10, 2, '0.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(616, 1, NULL, 'CYLINDRE DE SERRURE  FFF', NULL, NULL, 10, 0, '43.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(617, 1, NULL, 'CREMONE HILAL/ GMR', NULL, NULL, 10, 5, '25.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(618, 1, NULL, 'CREMONA BLOTA /FDR/VITRE', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(619, 1, NULL, 'SERRURE TIROIR  1ER/ANKARA', NULL, NULL, 10, 5, '25.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(620, 1, NULL, 'CROCHET FIL RIDEAUX', NULL, NULL, 10, 1, '0.20', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(621, 1, NULL, 'AGRAFE 8', NULL, NULL, 10, 5, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(622, 1, NULL, 'ROULETTE NOIR 50', NULL, NULL, 10, 2, '5.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(623, 1, NULL, 'ROULETTE BLANCHE 40', NULL, NULL, 10, 2, '5.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(624, 1, NULL, 'CHAINE JAUNE', NULL, NULL, 10, 10, '6.00', 3, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(625, 1, NULL, 'SERRURE VIDE /KEPAS', NULL, NULL, 10, 2, '50.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(626, 1, NULL, 'CYLINDR DE SERRURE SP DYAGO', NULL, NULL, 10, 5, '30.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(627, 1, NULL, 'CYLINDRE DE SERRURE SIMPLE FTN', NULL, NULL, 10, 2, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(628, 1, NULL, 'rivets 4x16', NULL, NULL, 10, 2, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(629, 1, NULL, 'GRATTOIR PEINTURE PLASTIQUE', NULL, NULL, 10, 10, '6.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(630, 1, NULL, 'COUTEAU CARROSSERIE 2EME', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(631, 1, NULL, 'CHARNIERE ELEPHO 453', NULL, NULL, 10, 10, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(632, 1, NULL, 'GRATOIRE PLATRE', NULL, NULL, 10, 5, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(633, 1, NULL, 'roulette 50frein', NULL, NULL, 10, 5, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(634, 1, NULL, 'roulette40 frein', NULL, NULL, 10, 5, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(635, 1, NULL, 'ROULETTE 75ORANGE FREIN', NULL, NULL, 10, 5, '30.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(636, 1, NULL, 'CLOU 5/6/10', NULL, NULL, 10, 1, '12.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(637, 1, NULL, 'TUYAUX JARDIN 2EME', NULL, NULL, 10, 10, '6.00', 9, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(638, 1, NULL, 'TRINGLE RIDEAUX  16M CHROME', NULL, NULL, 10, 10, '10.00', 9, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(639, 1, NULL, 'TALOCHE P', NULL, NULL, 10, 5, '7.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(640, 1, NULL, 'TALOCHE G', NULL, NULL, 10, 5, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(641, 1, NULL, 'TRUELLE LISSEUSE 0', NULL, NULL, 10, 5, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(642, 1, NULL, 'TRUELLE LISSEUSE 2EME', NULL, NULL, 10, 5, '18.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(643, 1, NULL, 'SERRIE CLE PIPE 6P/12p', NULL, NULL, 10, 1, '140.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(644, 1, NULL, 'CLE PLAT CRENEAU (SERRIE 1ER)', NULL, NULL, 10, 1, '10.35', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(645, 1, NULL, 'PINCE A GAZ', NULL, NULL, 10, 2, '40.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(646, 1, NULL, 'PINCE RIVET VERT 2/PIGON', NULL, NULL, 10, 2, '45.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(647, 1, NULL, 'CLOU 4 TP', NULL, NULL, 10, 1, '15.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(648, 1, NULL, 'CLOU 5 TP', NULL, NULL, 10, 1, '12.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(649, 1, NULL, 'CLOU 3', NULL, NULL, 10, 1, '15.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(650, 1, NULL, 'CLOU 2', NULL, NULL, 10, 1, '15.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(651, 1, NULL, 'fil noir', NULL, NULL, 10, 5, '0.00', 3, 7, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(652, 1, NULL, 'CADENAS  64', NULL, NULL, 10, 5, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(653, 1, NULL, 'perceuse bleu', NULL, NULL, 10, 1, '0.00', 3, 4, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(654, 1, NULL, 'GRILLAGE CH', NULL, NULL, 10, 10, '6.00', 3, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(655, 1, NULL, 'moustiquaire 1.20', NULL, NULL, 10, 10, '0.00', 3, 6, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(656, 1, NULL, 'moustiquaire 1.50', NULL, NULL, 10, 10, '0.00', 3, 6, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(657, 1, NULL, 'CHARNIERE 9 AMIG NOIR', NULL, NULL, 10, 10, '4.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(658, 1, NULL, 'CHARNIERE 11 AMI', NULL, NULL, 10, 10, '5.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(659, 1, NULL, 'CHARNIERE 2 AMI', NULL, NULL, 10, 10, '2.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(660, 1, NULL, 'CHARNIERE 2.50', NULL, NULL, 10, 10, '2.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(661, 1, NULL, 'PINCE COUP/CROCO/ PINCE CLASSIQUE TOREAD', NULL, NULL, 10, 2, '25.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(662, 1, NULL, 'CHAINE 17', NULL, NULL, 10, 5, '12.00', 3, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(663, 1, NULL, 'TUYAU A GAZ', NULL, NULL, 10, 5, '7.00', 9, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(664, 1, NULL, 'ROULEAU PEINTURE BRAVO PM', NULL, NULL, 10, 2, '15.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(665, 1, NULL, 'ROULEAU PEINTURE BRAVO GM', NULL, NULL, 10, 2, '18.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(666, 1, NULL, 'ROULEAU PEINTURE BLANC/MAYOR LAQUE/LAQUE DNG GM', NULL, NULL, 10, 2, '25.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(667, 1, NULL, 'BOUCHON RIDEAU 16 CHROME', NULL, NULL, 10, 10, '2.50', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(668, 1, NULL, 'PAQUET ANNEAU BLANC', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(669, 1, NULL, 'GANTS (N .D)', NULL, NULL, 10, 2, '10.00', 8, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(670, 1, NULL, 'GANTS -10dh NOIR EPAIS/LONG/CUIR/ORANGE EPAIS', NULL, NULL, 10, 2, '14.00', 8, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(671, 1, NULL, 'PINCEAU  PLASTIQUE BLEU', NULL, NULL, 10, 1, '0.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(672, 1, NULL, 'PINCEAU PLASTIQUE ROUGE', NULL, NULL, 10, 1, '0.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(673, 1, NULL, 'PINCEAU ROND AKREF', NULL, NULL, 10, 5, '18.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(674, 1, NULL, 'PINCEAU PEINT', NULL, NULL, 10, 2, '0.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(675, 1, NULL, 'PINCEAU ROND 1 ER CHOIX/ATLAS', NULL, NULL, 10, 2, '20.25', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(676, 1, NULL, 'ROULETTE 50 GRIS/ FREIN', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(677, 1, NULL, 'ATLAS CHROME 100G', NULL, NULL, 10, 6, '12.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(678, 1, NULL, 'MANCHON ROULEAU MOUSSE 11CM', NULL, NULL, 10, 5, '6.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(679, 1, NULL, 'COLLE SPECIALE MAXI', NULL, NULL, 10, 7, '7.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(680, 1, NULL, 'CHEVILLE COLOSON/EMBASSE A CHE', NULL, NULL, 10, 50, '0.50', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(681, 1, NULL, 'LAMPE REFRIGIRATUR E14 15W 220V', NULL, NULL, 10, 10, '8.00', 4, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(682, 1, NULL, 'BOITE ETAN 80*40 ROND', NULL, NULL, 10, 10, '4.50', 4, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(683, 1, NULL, 'MOULURE 40*16 UN CANAL AUTO ADHESIF', NULL, NULL, 10, 5, '10.00', 4, 8, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(684, 1, NULL, 'COLLIER COLSON 2.5*200', NULL, NULL, 10, 50, '0.30', 4, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(685, 1, NULL, 'TUBE FLEX.ISOG.Q21 LEGER/Q32 25M', NULL, NULL, 10, 25, '3.00', 4, 8, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(686, 1, NULL, 'CABLE TV NOIR +MOTEUR', NULL, NULL, 10, 50, '2.30', 4, 2, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(687, 1, NULL, 'CARTOUCHE FUSIBLE 2FIL 16A 40A 63A', NULL, NULL, 10, 10, '4.00', 4, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(688, 1, NULL, 'ACIDE CHLORYDRIQUE 17A*', NULL, NULL, 10, 10, '8.00', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(689, 1, NULL, 'GRESILINE', NULL, NULL, 10, 10, '10.00', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(690, 1, NULL, 'ACIDE NITRIQUE 40* 75CL', NULL, NULL, 10, 5, '18.00', 9, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(691, 1, NULL, 'COLLE GRIFFE ATLAS 1KG', NULL, NULL, 10, 3, '25.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(692, 1, NULL, 'ESSENCE 1L INDES', NULL, NULL, 10, 3, '17.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(693, 1, NULL, 'MECHE4.5 BOCH INOX', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(694, 1, NULL, 'MECHE 4  INOX', NULL, NULL, 10, 2, '6.00', 3, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(695, 1, NULL, 'GRILLAGE PLASTIQ', NULL, NULL, 10, 3, '10.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(696, 1, NULL, 'ATLAS CHROME 1KG', NULL, NULL, 10, 2, '45.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(697, 1, NULL, 'ASSALA COLOR 5K', NULL, NULL, 10, 0, '200.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(698, 1, NULL, 'LEADER PLAST 5K', NULL, NULL, 10, 2, '105.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(699, 1, NULL, 'VERNIS ASTRAL 704', NULL, NULL, 10, 1, '80.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(700, 1, NULL, 'ARLAC 20K', NULL, NULL, 10, 1, '590.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(701, 1, NULL, 'ARLAC 5K CHAMOIS 503', NULL, NULL, 10, 3, '155.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(702, 1, NULL, 'ARLAC 5K NOIR 900', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(703, 1, NULL, 'ATLAS AUTO 250G ROUGE', NULL, NULL, 10, 3, '13.00', 5, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(704, 1, NULL, 'ATLAS DORE 100G', NULL, NULL, 10, 3, '13.00', 5, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(705, 1, NULL, 'COLOFLEX 5K BLANC', NULL, NULL, 10, 3, '130.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(706, 1, NULL, 'COLOFLEX 5K ROUGE MARRAKECH', NULL, NULL, 10, 3, '130.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(707, 1, NULL, 'COLOSTOP 5KG', NULL, NULL, 10, 3, '80.00', 5, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(708, 1, NULL, 'ENDUIT ATLAS PATE 25K', NULL, NULL, 10, 3, '125.00', 5, 5, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(709, 1, NULL, 'LAQUE 20KG LEADER  ATLAS 1 CHOIX', NULL, NULL, 10, 2, '740.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(710, 1, NULL, 'ARLAC 0.5K GRIS PERLE 211', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(711, 1, NULL, 'ARLAC 0.5K VERT JARDIN 405', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(712, 1, NULL, 'ARLAC 1/2kg', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(713, 1, NULL, 'ARLAC 0.5K CHAMOIS 503', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(714, 1, NULL, 'ARLAC 0.5K MARRON 803', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(715, 1, NULL, 'ARLAC 0.5K VERT WAGON 407', NULL, NULL, 10, 2, '22.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(716, 1, NULL, 'ARLAC 5KG MARRON 803', NULL, NULL, 10, 2, '165.00', 5, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(717, 1, NULL, 'COUDE F 20X3/4 RETUBE', NULL, NULL, 10, 3, '20.00', 1, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(718, 1, NULL, 'BOUCHONS M 1/2 LAITON', NULL, NULL, 10, 10, '5.00', 1, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(719, 1, NULL, 'BOUCHONS F 1/2 LAITON', NULL, NULL, 10, 10, '6.00', 1, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(720, 1, NULL, 'BOULONE BIDET TABLEAU', NULL, NULL, 10, 5, '9.00', 1, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(721, 1, NULL, 'FIXATION ABATTANT', NULL, NULL, 10, 5, '10.00', 1, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(722, 1, NULL, 'L EVIER TROPL.THIN RK90X50 RIVER', NULL, NULL, 10, 0, '300.00', 2, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(723, 1, NULL, 'CORDE 36 BLEU 250G', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(724, 1, NULL, 'NIVEAU D EAU SANS VIS /2S88', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(725, 1, NULL, 'NIVEAU D EAU AVEC VIS 40CM HJ36', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(726, 1, NULL, 'NIVEAU D EAU AVEC VIS 50CM HJ37', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(727, 1, NULL, 'DISQUE230*3.2 STONE NORTON MARBRE', NULL, NULL, 10, 1, '20.00', 3, 1, '2026-09-15 12:47:13', '2026-09-15 12:47:13'),
(728, 1, NULL, 'SIPHON EVIER DOUBLE  TROP', NULL, NULL, 10, 1, '55.00', 2, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(729, 1, NULL, 'SIPHON EVIER DOUBLE  S/TROP ABP', NULL, NULL, 10, 1, '50.00', 2, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(730, 1, NULL, 'RALLONGE WC PS', NULL, NULL, 10, 1, '12.00', 1, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(731, 1, NULL, 'TRINGLE M28-7 POPULAIRE 1.6M AB', NULL, NULL, 10, 1, '45.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(732, 1, NULL, 'TRINGLE M28-7 POPULAIRE 2.5M AB', NULL, NULL, 10, 1, '45.00', 3, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(733, 1, NULL, 'TRINGLE M28 DORE 1.6', NULL, NULL, 10, 1, '15.00', 3, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(734, 1, NULL, 'TRINGLE M28 DORE 2', NULL, NULL, 10, 1, '15.00', 3, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(735, 1, NULL, 'TRINGLE M28 DORE 2.5', NULL, NULL, 10, 1, '15.00', 3, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(736, 1, NULL, 'EMBRASSE RIDEAU MARRON', NULL, NULL, 10, 1, '55.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(737, 1, NULL, 'CHARNIERE INVISIBLE GRANDE', NULL, NULL, 10, 5, '5.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(738, 1, NULL, 'SCIE A BUSH 12 VERT /ARC PM/STAM', NULL, NULL, 10, 2, '25.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(739, 1, NULL, 'MIROIR 50/40 BLANC DECOMA', NULL, NULL, 10, 2, '35.00', 2, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(740, 1, NULL, 'ESCABLEAUX 3HE-37', NULL, NULL, 10, 0, '280.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(741, 1, NULL, 'SPOT SI-04 CHROME IP20', NULL, NULL, 10, 0, '55.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(742, 1, NULL, 'PANEL LED ROND 3 3W ENCASTRE BLC/VERT', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(743, 1, NULL, 'CABLE TV NOIRE', NULL, NULL, 10, 0, '1.50', 4, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(744, 1, NULL, 'CABLE TV  BLANC', NULL, NULL, 10, 0, '2.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(745, 1, NULL, 'CABLE TV  BLANC + MOTEUR', NULL, NULL, 10, 10, '2.50', 4, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(746, 1, NULL, 'CABLE CAMERA FIL KX6A FIL  SCC2 VERT', NULL, NULL, 10, 10, '6.00', 4, 8, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(747, 1, NULL, 'PITON  4*50/4*60', NULL, NULL, 10, 10, '1.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(748, 1, NULL, 'PITON  4*40', NULL, NULL, 10, 10, '1.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(749, 1, NULL, 'CONSOLE AMIG 200*250', NULL, NULL, 10, 5, '6.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(750, 1, NULL, 'CONSOLE BLANC', NULL, NULL, 10, 5, '4.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(751, 1, NULL, 'CONSOLE AMIG 250*300/P.VERRE REGLABLE', NULL, NULL, 10, 5, '8.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(752, 1, NULL, 'ROULETTE 20M', NULL, NULL, 10, 2, '35.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(753, 1, NULL, 'KIT CLE PLAT', NULL, NULL, 10, 2, '30.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(754, 1, NULL, 'GACHE ELECTRIQUE INTERPHONE  TESA', NULL, NULL, 10, 2, '110.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(755, 1, NULL, 'SERRURE ALUMINIUM 25F901-25', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(756, 1, NULL, 'SERRURE ALUMINIUM 20F901-20', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(757, 1, NULL, 'MASSETTE 2KG PLASTIQUE', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(758, 1, NULL, 'MASSETTE 1.50KG PLASTIQUE', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(759, 1, NULL, 'MASSETTE 1KG PLASTIQUE/ FER', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(760, 1, NULL, 'MIROIR 35*35 BLANC', NULL, NULL, 10, 0, '21.00', 2, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(761, 1, NULL, 'DISQUE 230*3.2 DERBAY COUPE/ METAL', NULL, NULL, 10, 5, '15.00', 3, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(762, 1, NULL, 'RETUBE 20GRIFLEX ROUGE', NULL, NULL, 10, 10, '8.00', 1, 8, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(763, 1, NULL, 'TUBE RETUBE ALUMINIUM 16 PIPEX', NULL, NULL, 10, 10, '7.00', 1, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(764, 1, NULL, 'LAMPE A LED B22 11W 9', NULL, NULL, 10, 5, '15.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(765, 1, NULL, 'LAMPE A LED E27 11W 9', NULL, NULL, 10, 5, '15.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(766, 1, NULL, 'LAMPE A LED FLAMME  E14', NULL, NULL, 10, 5, '18.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(767, 1, NULL, 'LAMPE A LED FLAMME  E27', NULL, NULL, 10, 5, '18.00', 4, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(768, 1, NULL, 'LAMPE A LED SPOT 9W', NULL, NULL, 10, 5, '20.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(769, 1, NULL, 'LAMPE A LED 36W', NULL, NULL, 10, 5, '28.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(770, 1, NULL, 'LAQUE 20KG MIDI LAC', NULL, NULL, 10, 0, '580.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(771, 1, NULL, 'COLO7000 30KG', NULL, NULL, 10, 0, '420.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(772, 1, NULL, 'MIDI NYL 30kg', NULL, NULL, 10, 0, '420.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(773, 1, NULL, 'MAT BATIMA 30K', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(774, 1, NULL, 'METALAC NOIR COLORADO', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(775, 1, NULL, 'METALAC BLANC COLORADO 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(776, 1, NULL, 'MIDILAC BLEU 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(777, 1, NULL, 'MIDILAC MARRON 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(778, 1, NULL, 'MIDILAC BLANC 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(779, 1, NULL, 'MIDILAC VERT VAGO 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(780, 1, NULL, 'MIDILAC NOIR 21 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(781, 1, NULL, 'MIDILAC CHAMOIS 34 1K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(782, 1, NULL, 'MIDILAC CHAMOIS  1/2K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(783, 1, NULL, 'MIDILAC NOIR  1/2K', NULL, NULL, 10, 3, '35.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(784, 1, NULL, 'MIDILAC MARRON  1/2K', NULL, NULL, 10, 3, '20.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(785, 1, NULL, 'MIDILAC  BLANC1/2K', NULL, NULL, 10, 3, '20.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(786, 1, NULL, 'RACCORD MIX F 1/2', NULL, NULL, 10, 3, '8.00', 1, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(787, 1, NULL, 'SCOTCH MTM', NULL, NULL, 10, 2, '10.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(788, 1, NULL, 'CIRE EAU MIDI 1K DECO PROTECT', NULL, NULL, 10, 2, '110.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(789, 1, NULL, 'PLATRE GAZALA', NULL, NULL, 10, 5, '2.00', 9, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(790, 1, NULL, 'CIMENT NOIR', NULL, NULL, 10, 5, '2.00', 9, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(791, 1, NULL, 'CIMENT BLANC', NULL, NULL, 10, 5, '3.00', 9, 7, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(792, 1, NULL, 'MITIGEUR EVIER MURAL GALAXY PM', NULL, NULL, 10, 1, '220.00', 7, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(793, 1, NULL, 'MITIGEUR EVIER S/TABLE GALAXY PM', NULL, NULL, 10, 1, '200.00', 7, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(794, 1, NULL, 'ROBINET EVIER S/TABLE GALAXY PM/HAWAYSAN MURAL', NULL, NULL, 10, 1, '100.00', 7, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(795, 1, NULL, 'ROBINET EVIER M GALAXY PM/ lLAVABO FAUCETPM/MMLV', NULL, NULL, 10, 1, '95.00', 7, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(796, 1, NULL, 'POIGNEE MOTIF CAN/WC', NULL, NULL, 10, 1, '45.00', 3, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(797, 1, NULL, 'POIGNEE MOTIF WC', NULL, NULL, 10, 1, '45.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(798, 1, NULL, 'CHARNIERE 14', NULL, NULL, 10, 2, '8.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(799, 1, NULL, 'CHARNIERE INVISIBLE  PETITE', NULL, NULL, 10, 5, '3.50', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(800, 1, NULL, 'CHARNIERE 50 DORE', NULL, NULL, 10, 5, '3.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(801, 1, NULL, 'ANNEAU  TRINGLE JAUNE', NULL, NULL, 10, 5, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(802, 1, NULL, 'CONSOLE CHROME', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(803, 1, NULL, 'CHARNIER INVISIBLE FREIN GM', NULL, NULL, 10, 2, '14.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(804, 1, NULL, 'SUPPORT RIDEAU 18 CHROME', NULL, NULL, 10, 2, '4.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(805, 1, NULL, 'SUPPORT RIDEAU SIMPLE DOUBLE PLAFOND', NULL, NULL, 10, 2, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(806, 1, NULL, 'SUPPORT RIDEAU SIMPLE PLAFOND', NULL, NULL, 10, 2, '3.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(807, 1, NULL, 'SUPPORT RIDEAU SIMPLE DOUBLE FACE', NULL, NULL, 10, 2, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(808, 1, NULL, 'SUPPORT RIDEAU DOUBLE MARRON', NULL, NULL, 10, 2, '25.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(809, 1, NULL, 'SUPPORT RIDEAU FACE JAUNE', NULL, NULL, 10, 2, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(810, 1, NULL, 'SUPPORT RIDEAU SIMPLE FACE', NULL, NULL, 10, 2, '4.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(811, 1, NULL, 'SUPPORT RIDEAU SIMPLE COTE EN PLAST/16 FACE PLAST', NULL, NULL, 10, 2, '3.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(812, 1, NULL, 'NIVEAU  FIL', NULL, NULL, 10, 1, '40.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(813, 1, NULL, 'BROSSE FER', NULL, NULL, 10, 1, '10.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(814, 1, NULL, 'BOUCHON RIDEAU SIMPLE', NULL, NULL, 10, 5, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(815, 1, NULL, 'PIECE BLANC RIDEAU S', NULL, NULL, 10, 5, '0.20', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(816, 1, NULL, 'POIGNEE LEVER CHROME', NULL, NULL, 10, 1, '15.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(817, 1, NULL, 'CORDE BLANC 36 / 27 *WETRA*', NULL, NULL, 10, 1, '18.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(818, 1, NULL, 'CORDE BLANC 36*WETRA*', NULL, NULL, 10, 1, '18.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(819, 1, NULL, 'POIGNEE  MARRON SIMPLE wc/cle', NULL, NULL, 10, 1, '40.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(820, 1, NULL, 'POIGNEE CLEMARRON S', NULL, NULL, 10, 1, '35.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(821, 1, NULL, 'SOUDEUR KAWIA 60W VIDE', NULL, NULL, 10, 1, '30.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(822, 1, NULL, 'EQUERRE JAUNE 50MM', NULL, NULL, 10, 1, '1.50', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(823, 1, NULL, 'EQUERRE JAUNE 60MM', NULL, NULL, 10, 1, '1.50', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(824, 1, NULL, 'EQUERRE JAUNE 40 MM', NULL, NULL, 10, 1, '1.50', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(825, 1, NULL, 'SERRURE BARRETTE 80 EGLE', NULL, NULL, 10, 1, '6.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(826, 1, NULL, 'abattant glissierTIROIRE BLANC 35', NULL, NULL, 10, 1, '15.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(827, 1, NULL, 'abattant glissierTIROIRE BLANC 45', NULL, NULL, 10, 1, '15.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(828, 1, NULL, 'abattant glissierTIROIRE  CHROME35', NULL, NULL, 10, 1, '20.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(829, 1, NULL, 'CISEAU PLANTE', NULL, NULL, 10, 1, '43.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(830, 1, NULL, 'MOUSTIQUERE FER 25', NULL, NULL, 10, 1, '15.00', 3, 8, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(831, 1, NULL, 'MOUSTIQUERE FER 8 1M', NULL, NULL, 10, 1, '13.00', 3, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(832, 1, NULL, 'CLE A MOLETTE', NULL, NULL, 10, 1, '35.45', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(833, 1, NULL, 'LAMPE REGLETTE   LED 60CM', NULL, NULL, 10, 1, '50.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(834, 1, NULL, 'LAMPE AVEC CADRE LED 1.20 CM', NULL, NULL, 10, 1, '60.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(835, 1, NULL, 'FIL LED COULEUR', NULL, NULL, 10, 1, '25.00', 4, 8, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(836, 1, NULL, 'FIL LED BLANC', NULL, NULL, 10, 1, '17.00', 4, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(837, 1, NULL, 'LAMPE ROUGE E27', NULL, NULL, 10, 1, '5.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(838, 1, NULL, 'HUBLOT LED', NULL, NULL, 10, 0, '100.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(839, 1, NULL, 'CORDE 10M', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(840, 1, NULL, 'BROSSE AVEC MANCHE', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(841, 1, NULL, 'ROBINET A GAZ', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(842, 1, NULL, 'ROBINET A GAZ FOUR', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(843, 1, NULL, 'SCOTCH EMB MM', NULL, NULL, 10, 1, '8.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(844, 1, NULL, 'SCOTCH EMB PM', NULL, NULL, 10, 1, '3.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(845, 1, NULL, 'PIL 9 VOL', NULL, NULL, 10, 1, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(846, 1, NULL, 'RATOXID', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(847, 1, NULL, 'BATON BALAI', NULL, NULL, 10, 1, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(848, 1, NULL, 'BATON BALAI 120', NULL, NULL, 10, 1, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(849, 1, NULL, 'CIRAGE NOIR', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(850, 1, NULL, 'TOURNEVIS  GM ARC/ DWN 2', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(851, 1, NULL, 'SCOTCH NOIR PM', NULL, NULL, 10, 0, '2.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(852, 1, NULL, 'LAMPE A LED 9W', NULL, NULL, 10, 1, '12.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(853, 1, NULL, 'CABLE NUMERIQUE 3 FICHES 1ER', NULL, NULL, 10, 1, '12.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(854, 1, NULL, 'CABLE RCA 3X3 TV 1ER', NULL, NULL, 10, 1, '12.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(855, 1, NULL, 'LAMPE VEILLEUSE  RECHARGEABL / NOIR /COLOR', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(856, 1, NULL, 'LAMPE RECHARGEABLE MM+ MANCHE', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(857, 1, NULL, 'PIL SONI 20', NULL, NULL, 10, 2, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(858, 1, NULL, 'KIT CLE PM', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(859, 1, NULL, 'CONNECTEUR NUMERIQ 2EME', NULL, NULL, 10, 1, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(860, 1, NULL, 'PIL DORCEL 3A', NULL, NULL, 10, 2, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(861, 1, NULL, 'PIL 3A VERT', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(862, 1, NULL, 'PIL 6 SUPERLUX', NULL, NULL, 10, 1, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(863, 1, NULL, 'TOURNEVIS  PM ARC', NULL, NULL, 10, 1, '0.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(864, 1, NULL, 'TENTEUR VERT  TABLEAU', NULL, NULL, 10, 1, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(865, 1, NULL, 'CADENAS VELO', NULL, NULL, 10, 1, '0.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(866, 1, NULL, 'CABLE PRISE RADIO', NULL, NULL, 10, 1, '8.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(867, 1, NULL, 'BLOC SECOURE P', NULL, NULL, 10, 1, '120.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(868, 1, NULL, 'BLOC SECOURE G', NULL, NULL, 10, 1, '140.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(869, 1, NULL, 'LAMPE A LED SPOT ROUGE 3W', NULL, NULL, 10, 1, '20.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(870, 1, NULL, 'DISJONCTEUR DIF 32A', NULL, NULL, 10, 0, '130.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(871, 1, NULL, 'DISJONCTEUR DIF 63A / 2FIL 40A', NULL, NULL, 10, 0, '150.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(872, 1, NULL, 'SPOT PANEL CADRE 3W+3W', NULL, NULL, 10, 0, '32.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(873, 1, NULL, 'GUIRLANDE MULTICO/ RJB 10M', NULL, NULL, 10, 0, '145.00', 4, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(874, 1, NULL, 'TOBA P RAT', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(875, 1, NULL, 'GANT GARY / P(N.D)', NULL, NULL, 10, 0, '10.00', 8, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(876, 1, NULL, 'BROSSE SAHEL', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(877, 1, NULL, 'GANTS -9dh SPONTEX/ TISSU ORANGE/CUIR 8-9', NULL, NULL, 10, 0, '12.00', 8, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(878, 1, NULL, 'RACLEUR WATSAP 45/ JAMBO 55', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(879, 1, NULL, 'BALAI COCO/CAROL/ALHARCHA', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(880, 1, NULL, 'BALAI 5.50', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(881, 1, NULL, 'BALAI COCO 1ER', NULL, NULL, 10, 0, '12.00', 9, 5, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(882, 1, NULL, 'COLLIER T GAZ 1 CHOIX', NULL, NULL, 10, 10, '2.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(883, 1, NULL, 'COLLIER T GAZ 2 CHOIX', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(884, 1, NULL, 'TENDEUR  TABLEAU/ ASTRO/CHAUFFE EAU', NULL, NULL, 10, 1, '35.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(885, 1, NULL, 'TEE GAZ LAITON', NULL, NULL, 10, 1, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(886, 1, NULL, 'ENTREE GAZ 1/2 DIRECT', NULL, NULL, 10, 1, '12.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(887, 1, NULL, 'RACCORD DIRECT GAZ LAITON', NULL, NULL, 10, 2, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(888, 1, NULL, 'ROBINET ROULER GAZ 1ER CHOIX', NULL, NULL, 10, 1, '15.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(889, 1, NULL, 'ROBINET ROULER GAZ 2ER CHOIX', NULL, NULL, 10, 1, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(890, 1, NULL, 'TUYAU GAZ NOIR 1ER/ITAL', NULL, NULL, 10, 1, '13.00', 9, 2, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(891, 1, NULL, 'CHALUMEAU', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(892, 1, NULL, 'ROULEAU PEINTURE  PEINT0/ PERFECT/LAQUE', NULL, NULL, 10, 1, '25.00', 5, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(893, 1, NULL, 'TENDEUR ROUGE DIRECT', NULL, NULL, 10, 1, '35.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(894, 1, NULL, 'TENDEUR MOND/VERT', NULL, NULL, 10, 1, '30.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(895, 1, NULL, 'TENDEUR  1ER', NULL, NULL, 10, 1, '35.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(896, 1, NULL, 'RACLEUR FER/AHRAM GM', NULL, NULL, 10, 0, '14.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(897, 1, NULL, 'CAFOUR', NULL, NULL, 10, 0, '2.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(898, 1, NULL, 'PELLE', NULL, NULL, 10, 1, '5.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(899, 1, NULL, 'BROSSE A CIRAGE', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(900, 1, NULL, 'BOUTEILLE A VAPEUR', NULL, NULL, 10, 0, '4.00', 8, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(901, 1, NULL, 'PISTOLET COLLE', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(902, 1, NULL, 'CADENAS MOTO+6c velo 26dhs', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(903, 1, NULL, 'PINCE', NULL, NULL, 10, 1, '20.00', 3, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(904, 1, NULL, 'RACLEUR PLASTIQ COBRA', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(905, 1, NULL, 'P POUDRE CAFARD', NULL, NULL, 10, 5, '3.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(906, 1, NULL, 'BROSSE WC', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(907, 1, NULL, 'COLLE RAT', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:14', '2026-09-15 12:47:14'),
(908, 1, NULL, 'BALAI MARRON', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(909, 1, NULL, 'VENTEUSE G/COLOR ROSSORT', NULL, NULL, 10, 0, '17.50', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(910, 1, NULL, 'VENTEUSE P', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(911, 1, NULL, 'CHIFFON 6M', NULL, NULL, 10, 4, '0.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(912, 1, NULL, 'CHIFFON 8M', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(913, 1, NULL, 'PIL 20 DURACELL', NULL, NULL, 10, 1, '20.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(914, 1, NULL, 'PISTOLET  SILICON 1ER/CHROME', NULL, NULL, 10, 1, '30.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(915, 1, NULL, 'RUTACIDE', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(916, 1, NULL, 'CHIFFON 10', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(917, 1, NULL, 'PINCE AMPERMITRIQUE DIGITAL', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(918, 1, NULL, 'AQUADOR 003', NULL, NULL, 10, 0, '35.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(919, 1, NULL, 'TITAN ORO DORE', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(920, 1, NULL, 'DISQUE MARBRE', NULL, NULL, 10, 1, '23.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(921, 1, NULL, 'CADENAS 55 COTE', NULL, NULL, 10, 1, '18.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(922, 1, NULL, 'LAMPE A LED 32W', NULL, NULL, 10, 1, '45.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(923, 1, NULL, 'DOUBLE PRISE NOIR CHINO', NULL, NULL, 10, 1, '8.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(924, 1, NULL, 'POIGNEE PORTE PALIERE MARRON DOORLOCKS', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(925, 1, NULL, 'DISQUE 230X1.9 ATLAS METAL', NULL, NULL, 10, 1, '15.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(926, 1, NULL, 'SPOT PANEL 6W VERDI', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(927, 1, NULL, 'SPOT BAL /PANEL 5W/6W ENCASTRE', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(928, 1, NULL, 'PINCEAU ROND 2EME CHOIX', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(929, 1, NULL, 'GRILLAGE PEINTURE FER', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(930, 1, NULL, 'ROULEAU PEINTURE 1ER', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(931, 1, NULL, 'FREIN PORTE', NULL, NULL, 10, 0, '3.50', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(932, 1, NULL, 'BALANCE ELEC BANANE', NULL, NULL, 10, 0, '240.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(933, 1, NULL, 'FLOTTEUR TECHNO', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(934, 1, NULL, 'MANCHON 1/2 4CM', NULL, NULL, 10, 10, '10.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(935, 1, NULL, 'CHARNIERE 471', NULL, NULL, 10, 1, '4.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(936, 1, NULL, 'CHARNIERE 452', NULL, NULL, 10, 10, '4.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(937, 1, NULL, 'CHARNIERE 454', NULL, NULL, 10, 10, '4.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(938, 1, NULL, 'ROBINET JARDIN 1/2 3/4 JAUNE 2EME', NULL, NULL, 10, 2, '35.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(939, 1, NULL, 'POIGNEE CHROME UCAF', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(940, 1, NULL, 'GANTS-5.2dh PLASTIQUE OSCAR/TISSU BLEU SIMPLE', NULL, NULL, 10, 1, '8.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(941, 1, NULL, 'GANTS -7.5dh TISSU GARY/TISSU BLEU', NULL, NULL, 10, 2, '10.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(942, 1, NULL, 'MONTURE ROULEAU PEINTURE G', NULL, NULL, 10, 1, '8.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(943, 1, NULL, 'SERRURE A CYLINDRE ENC BRICARD 4 CM/GMB 5 CLES/ZETE/BUGATT/WEKS', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(944, 1, NULL, 'DISQUE ECO PLUS MARBRE PETIT 115 /230 SAIT/ 115 GRANETTE BOCHE', NULL, NULL, 10, 1, '35.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(945, 1, NULL, 'DISQUE ECO PLUS MARBRE GRAND', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(946, 1, NULL, 'MELANGEUR DOUCHE VENTILATEUR CLASSIQUE', NULL, NULL, 10, 0, '260.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(947, 1, NULL, 'MELANGEUR LAVABO VENTILATEUR CLASSIQUE', NULL, NULL, 10, 0, '245.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(948, 1, NULL, 'MELANGEUR CUISINE 16 VENTILATEUR CLASSIQUE', NULL, NULL, 10, 0, '235.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(949, 1, NULL, 'MELANGEUR LAVABO BIC VENTILATEUR CLASSIQUE', NULL, NULL, 10, 0, '235.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(950, 1, NULL, 'ROBINET LAVABO VENTILATEUR CLASSIQUE/HAWAY/stainlest', NULL, NULL, 10, 0, '120.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(951, 1, NULL, 'ROBINET SER VENTILATEUR CLASSIQUE', NULL, NULL, 10, 0, '120.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(952, 1, NULL, 'INTERPHONE BPT 3', NULL, NULL, 10, 0, '830.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(953, 1, NULL, 'DOUCHETTE TAHARA ESP/ IBRILIO/BOSINI', NULL, NULL, 10, 0, '65.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(954, 1, NULL, 'CHARNIERE LAITON', NULL, NULL, 10, 2, '8.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(955, 1, NULL, 'CHARNIERE 9 CHROME', NULL, NULL, 10, 1, '9.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(956, 1, NULL, 'POIGNEE TIRETTE TIROIR 96 INOX GM A', NULL, NULL, 10, 2, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(957, 1, NULL, 'POIGNEE TIRETTE TIROIR 64 INOX PM A', NULL, NULL, 10, 2, '9.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(958, 1, NULL, 'POIGNEE BOUTON TIROIR PLASTIQ CHROM/MARRON', NULL, NULL, 10, 2, '4.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(959, 1, NULL, 'POIGNEE BOUTON  TIROIR  B', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(960, 1, NULL, 'METRE TABLEAU 5M GARY', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(961, 1, NULL, 'CHARNIERE 9 AMIG JAUNE', NULL, NULL, 10, 10, '7.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(962, 1, NULL, 'ROSACE 1/2', NULL, NULL, 10, 3, '3.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(963, 1, NULL, 'ROBINET D ARRET1/2 ALAMIA/ALSA', NULL, NULL, 10, 1, '30.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(964, 1, NULL, 'CHARNIERE 87 GARY LAITON', NULL, NULL, 10, 2, '12.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(965, 1, NULL, 'POMPE GRAND FORCE', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(966, 1, NULL, 'POMPE GRAND FORCE AUTOMATIQ', NULL, NULL, 10, 0, '780.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(967, 1, NULL, 'MANCHON  ROULEAU  MOUSSE BLANCO', NULL, NULL, 10, 1, '5.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(968, 1, NULL, 'MANCHON ROULEAU FILE', NULL, NULL, 10, 1, '6.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(969, 1, NULL, 'DISQUE GARY 1.8 METAL', NULL, NULL, 10, 1, '15.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(970, 1, NULL, 'SERRURE BARRETTE 250X50 LAITON', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(971, 1, NULL, 'SERRURE BARRETTE 250X80 LAITON/CHROME', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(972, 1, NULL, 'POIGNEE CHROME EUROAZRA', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(973, 1, NULL, 'ROBINET EQUERRE 1/2 1/2 ARCO', NULL, NULL, 10, 2, '30.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(974, 1, NULL, 'ROBINET EQUERRE 1/2 3/8 ET 3/4 URKIT', NULL, NULL, 10, 2, '35.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(975, 1, NULL, 'ROBINET EQUERRE 1/2 3/4 ARCO/TEMME', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(976, 1, NULL, 'LOCTO NOIR ET BLANC /MARRON', NULL, NULL, 10, 1, '7.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(977, 1, NULL, 'SERRURE A TIRETTE  VACHETTE UMED/CLEDOR', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(978, 1, NULL, 'FAYROUZ 113', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(979, 1, NULL, 'FAYROUZ 133', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(980, 1, NULL, 'FAYROUZ 154', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(981, 1, NULL, 'FAYROUZ 162', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(982, 1, NULL, 'LAMPE A LED SPOT BLEU 3W', NULL, NULL, 10, 1, '20.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(983, 1, NULL, 'BALANCE ELECTRONIQUE', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(984, 1, NULL, 'CISEAU ARBRE PM/GM', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(985, 1, NULL, 'POIGNEE BOUTON TIROIR AHRAM C', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(986, 1, NULL, 'SERRURE BARRETTE 70 PM', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(987, 1, NULL, 'POIGNEE  PORTE PALIERE CHROME EUROAZRA', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(988, 1, NULL, 'ROBINET JARDIN 1/2 MT 1/4TOUR', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(989, 1, NULL, 'LAME SCIE RICHA/INGCO', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(990, 1, NULL, 'MAT ESSENCE MIDI 1KG', NULL, NULL, 10, 2, '28.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(991, 1, NULL, 'MIDI LAC  1KG MARRON MOY 41', NULL, NULL, 10, 2, '28.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(992, 1, NULL, 'SCOTCH 3M', NULL, NULL, 10, 2, '9.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(993, 1, NULL, 'VERNIS MIDI N2 1KG', NULL, NULL, 10, 2, '40.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(994, 1, NULL, 'MIDILAC BLANC 5KG', NULL, NULL, 10, 1, '150.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(995, 1, NULL, 'MIDILAC NOIR 5KG', NULL, NULL, 10, 1, '150.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(996, 1, NULL, 'MIDINYL 5KG', NULL, NULL, 10, 1, '85.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(997, 1, NULL, 'AB FER GRIS 5KG RAMACOLOR', NULL, NULL, 10, 1, '115.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(998, 1, NULL, 'AB FER ROUGE 5KG RAMACOLOR', NULL, NULL, 10, 1, '110.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(999, 1, NULL, 'REDUCTION 3 TROUS 100/40 PVC', NULL, NULL, 10, 2, '10.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1000, 1, NULL, 'ENDUIT COLORADO PATE 25KG', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1001, 1, NULL, 'ROBINET SERVICE HAOTIC/RIVER', NULL, NULL, 10, 0, '65.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1002, 1, NULL, 'ROBINET DOUBLE 3/8 1/2 1/2', NULL, NULL, 10, 0, '75.00', 7, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1003, 1, NULL, 'PAUMELLE A  SOUDER ELG 100', NULL, NULL, 10, 1, '6.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1004, 1, NULL, 'PAUMELLE A  SOUDER ELG 120 PM', NULL, NULL, 10, 1, '6.50', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1005, 1, NULL, 'PAUMELLE A  SOUDER ELG 120 GM', NULL, NULL, 10, 1, '10.50', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1006, 1, NULL, 'MARTEAU EN CAOUTCHOU CARRELAGE 500G', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1007, 1, NULL, 'BURIN ROUGE', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1008, 1, NULL, 'BURIN A/J POINTU STAM 14', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1009, 1, NULL, 'BURIN  DOUBLE 1ER', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1010, 1, NULL, 'BURIN  STAM PLAT 16MM 300', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1011, 1, NULL, 'BURIN  STAM PLAT 16MM 350', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1012, 1, NULL, 'BURIN  STAM', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1013, 1, NULL, 'BURIN  STAM POINTU 16MM 300', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1014, 1, NULL, 'BURIN  STAM POINTU 16MM 250', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1015, 1, NULL, 'BAGUETTE MATICA 3.50 BLC R92', NULL, NULL, 10, 0, '0.60', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1016, 1, NULL, 'BAGUETTE MATICA 2.5  BLC R92', NULL, NULL, 10, 0, '0.50', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1017, 1, NULL, 'CROCHET 3X30', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1018, 1, NULL, 'MARTEAU EN CAOUTCHOU AVEC MANCHE ACIER 500G T-120', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1019, 1, NULL, 'MARTEAU EN CAOUTCHOU CARRELAGE 300G', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1020, 1, NULL, 'TUBE FLEX.ISOG Q11 ING 11', NULL, NULL, 10, 10, '1.60', 4, 2, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1021, 1, NULL, 'TUBE FLEX.ISOG Q16 ING 16', NULL, NULL, 10, 10, '2.10', 4, 2, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1022, 1, NULL, 'TUBE FLEX.ISOG Q21 ING 21', NULL, NULL, 10, 10, '3.00', 4, 2, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1023, 1, NULL, 'CABLE CAPOTH.2*0.75', NULL, NULL, 10, 10, '2.00', 4, 2, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1024, 1, NULL, 'COF.08MOD ENC LAP', NULL, NULL, 10, 0, '24.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1025, 1, NULL, 'CHEVILLE 7MM LAP', NULL, NULL, 10, 1, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1026, 1, NULL, 'CHEVILLE 6MM LAP', NULL, NULL, 10, 1, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1027, 1, NULL, 'PRISE TV TICHKA IVOIRE2 4227', NULL, NULL, 10, 1, '15.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1028, 1, NULL, 'ITOMAT 30KG', NULL, NULL, 10, 0, '620.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1029, 1, NULL, 'ESSENCE FACOP3/4', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1030, 1, NULL, 'PINCEAU PLAT PREFCTA 70', NULL, NULL, 10, 0, '18.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1031, 1, NULL, 'PINCEAU PLAT PREFCTA 60', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1032, 1, NULL, 'TETE LAITON TRIO GAZ', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1033, 1, NULL, 'CONNECTEUR NUMERIQUE 1ER', NULL, NULL, 10, 0, '2.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1034, 1, NULL, 'SUPPORT VETEMENT /VIS', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1035, 1, NULL, 'SUPPORT VETEMENT /PORTE', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1036, 1, NULL, 'PORTE CLE V', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1037, 1, NULL, 'PORTE CLE CHROME', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1038, 1, NULL, 'CUTTER G', NULL, NULL, 10, 1, '7.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1039, 1, NULL, 'VIS P VERT', NULL, NULL, 10, 1, '2.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1040, 1, NULL, 'COLLE RAT 2EME ROUGE', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1041, 1, NULL, 'SERRIE SUP 2EME', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1042, 1, NULL, 'ELASTIQUE MOTO', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1043, 1, NULL, 'CHIFFON JAUNE', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1044, 1, NULL, 'BROSSE CIRAGE COLOR', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1045, 1, NULL, 'CADENAS TABLEAU PM', NULL, NULL, 10, 1, '8.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1046, 1, NULL, 'DOUBLE PRISE +INTERRUPTEUR', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1047, 1, NULL, 'DOUBLE FICHE /AMI/ NOIR 2eme', NULL, NULL, 10, 1, '10.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1048, 1, NULL, 'LAMPE  E14  COULEUR JAUNE', NULL, NULL, 10, 1, '4.50', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1049, 1, NULL, 'CADENAS CHROME 84', NULL, NULL, 10, 1, '65.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1050, 1, NULL, 'PRODUIT APPAREIL RED', NULL, NULL, 10, 1, '20.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1051, 1, NULL, 'TENAILLE GLOS/ TABLEAU VERT', NULL, NULL, 10, 1, '35.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1052, 1, NULL, 'LAMPE A LED FLAMME E14 2EME', NULL, NULL, 10, 0, '13.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1053, 1, NULL, 'APPAREIL PRISE  RED LIQUIDE/COMPRIME NEXIS', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1054, 1, NULL, 'APPAREIL PRISE  RED COMPRIME', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1055, 1, NULL, 'COLLE CHAUDE', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1056, 1, NULL, 'FICHE MAL/FEM SIMPLE', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1057, 1, NULL, 'GANT 7.8', NULL, NULL, 10, 0, '12.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1058, 1, NULL, 'TETE LAITON BOUTEILLE GAZ', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1059, 1, NULL, 'CADENAS 45 COTE/63 CHROME', NULL, NULL, 10, 1, '12.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1060, 1, NULL, 'CADENAS 65 COTE', NULL, NULL, 10, 0, '19.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1061, 1, NULL, 'TOURNEVIS PIGEON', NULL, NULL, 10, 1, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1062, 1, NULL, 'CISEAU ARC', NULL, NULL, 10, 1, '10.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1063, 1, NULL, 'BAIGON  POUDRE', NULL, NULL, 10, 0, '9.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1064, 1, NULL, 'GONFLEUR DANI', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1065, 1, NULL, 'GONFLEUR *GM*', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1066, 1, NULL, 'GONFLEUR *PM*SIMPLE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1067, 1, NULL, 'SERRIE SUP 1ER', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1068, 1, NULL, 'DOUILLE E 27 V/LAP', NULL, NULL, 10, 1, '6.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1069, 1, NULL, 'COLLE UHU 1', NULL, NULL, 10, 1, '7.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1070, 1, NULL, 'CADENAS TABLEAU 40', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1071, 1, NULL, 'DOUILLE E27 2EME', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1072, 1, NULL, 'TOURNEVIS P/M', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1073, 1, NULL, 'LAMPE A LED FLAMME COLOR E14', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1074, 1, NULL, 'FAYROUZ 147', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1075, 1, NULL, 'FAYROUZ 161', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1076, 1, NULL, 'FAYROUZ 164', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1077, 1, NULL, 'ITRY LAQUE 1KG', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1078, 1, NULL, 'BROSSE WC SOF', NULL, NULL, 10, 0, '15.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1079, 1, NULL, 'BOUTEILLE VAP 1ER/ ET 1L', NULL, NULL, 10, 0, '18.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1080, 1, NULL, 'EMBRASSE RIDEAU JAUNE/SERPENT', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1081, 1, NULL, 'SUPPORT CLIMA P', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1082, 1, NULL, 'SUPPORT CLIMA G', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1083, 1, NULL, 'SCOTCH ALUMINIUM', NULL, NULL, 10, 1, '25.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1084, 1, NULL, 'PINCE LINGE', NULL, NULL, 10, 1, '2.50', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1085, 1, NULL, 'BATON BLEU', NULL, NULL, 10, 1, '5.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1086, 1, NULL, 'BATON 140', NULL, NULL, 10, 1, '10.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1087, 1, NULL, 'FIL LINGE 20M', NULL, NULL, 10, 1, '20.00', 8, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1088, 1, NULL, 'COLLE EXTRAFA', NULL, NULL, 10, 1, '3.00', 3, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1089, 1, NULL, 'CARTOUCHE GAZ', NULL, NULL, 10, 1, '12.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1090, 1, NULL, 'AXE COCOTTE TABL', NULL, NULL, 10, 1, '10.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1091, 1, NULL, 'AXE COCOTTE TABL 2', NULL, NULL, 10, 1, '12.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1092, 1, NULL, 'AXE COCOTTE TABL LAITON', NULL, NULL, 10, 1, '15.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1093, 1, NULL, 'SIFFLET COCOTTE', NULL, NULL, 10, 1, '5.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1094, 1, NULL, 'RACLEUR 2EM', NULL, NULL, 10, 1, '8.00', 9, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1095, 1, NULL, 'RALLONGE 7CHROME', NULL, NULL, 10, 0, '23.00', 1, 1, '2026-09-15 12:47:15', '2026-09-15 12:47:15'),
(1096, 1, NULL, 'RALLONGE 5CHROME', NULL, NULL, 10, 0, '17.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1097, 1, NULL, 'JEU DE FIXATION ABATTANT', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1098, 1, NULL, 'SIPHON DOUCHE GP', NULL, NULL, 10, 0, '34.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1099, 1, NULL, 'KIT DOUCHETTE P14/TABLEA B117', NULL, NULL, 10, 0, '110.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1100, 1, NULL, 'KIT DOUCHETTE P18', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1101, 1, NULL, 'KIT DOUCHETTE P20', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1102, 1, NULL, 'KIT DOUCHETTE P22', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1103, 1, NULL, 'KIT DOUCHETTE EZAT', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1104, 1, NULL, 'FLEXIBLE DOUCHE 1ER', NULL, NULL, 10, 0, '85.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1105, 1, NULL, 'SIPHON DE COUR 10X10 LAITON', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1106, 1, NULL, 'SIPHON DE COUR 15X15 LAITON', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1107, 1, NULL, 'SIPHON DE COUR 20X20 LAITON', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1108, 1, NULL, 'MECANISME POUSSOIRE WERQUIN/VSA', NULL, NULL, 10, 0, '150.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1109, 1, NULL, 'ROBINET EQUERRE 3/8X3/8 JAUNE', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1110, 1, NULL, 'ROBINET EQUERRE 3/8X3/8 CHROME', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1111, 1, NULL, 'PORTE PAPIER INIANA', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1112, 1, NULL, 'PORTE SAVON INDIANA', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1113, 1, NULL, 'PORTE SERVIETTE BARRE INDIANA', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1114, 1, NULL, 'COLLE PVC SADER PM', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1115, 1, NULL, 'COUDE M 16X3/4RETUBE', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1116, 1, NULL, 'COUDE FF 16X3/4RETUBE', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1117, 1, NULL, 'PINCE RIVET SIMPLE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1118, 1, NULL, 'EQUERRE DE MENUISIER', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1119, 1, NULL, 'COLLIER 3.6X370MM', NULL, NULL, 10, 0, '0.75', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1120, 1, NULL, 'COLLE BOIS  POLY 500G', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1121, 1, NULL, 'CORDEX S/AVEC CRAIE', NULL, NULL, 10, 0, '28.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1122, 1, NULL, 'VINYLE 30KG SUPRAFLEX ECOBLANC SANS J', NULL, NULL, 10, 1, '230.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1123, 1, NULL, 'TEINTE FACOP HUIL', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1124, 1, NULL, 'COLOFLEX 1KG BLANC', NULL, NULL, 10, 1, '40.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1125, 1, NULL, 'SUPRAGEL 25KG', NULL, NULL, 10, 1, '90.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1126, 1, NULL, 'GRAISSE 230G', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1127, 1, NULL, 'BOMBE DOREE/CHROME', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1128, 1, NULL, 'ALCOOL', NULL, NULL, 10, 0, '22.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1129, 1, NULL, 'PINCEAU PLAT PICASSO/BOIS/DANI', NULL, NULL, 10, 0, '7.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1130, 1, NULL, 'COLLE DYNAGLUE 4KG', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1131, 1, NULL, 'COLLE BOIS SACOL 4KG', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1132, 1, NULL, 'COLLE DYNAGLUE 500GR SADER', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1133, 1, NULL, 'MECHE PLATRE', NULL, NULL, 10, 0, '53.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1134, 1, NULL, 'PITON 5*60/5*40', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1135, 1, NULL, 'CROCHET 5X50', NULL, NULL, 10, 1, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1136, 1, NULL, 'SUPPORT VETEMENT GARNO 10 INOX', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1137, 1, NULL, 'BANDE SECURITE', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1138, 1, NULL, 'MECHE HILTI', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1139, 1, NULL, 'MAT ESSENCE MIDI 5kg', NULL, NULL, 10, 0, '120.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1140, 1, NULL, 'MAT BATIMA 10KG', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1141, 1, NULL, 'MIDI NYL 10KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1142, 1, NULL, 'BAGUETTE FAIENCE 2.6 CHROME 1ER', NULL, NULL, 10, 0, '23.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1143, 1, NULL, 'POIGNEE CHROME CARDO/SER/dogetar', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1144, 1, NULL, 'SERRURE   MORTICE', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1145, 1, NULL, 'CYLINDRE DE SERRURE 7CLES EN BOITE', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1146, 1, NULL, 'CYLINDRE DE SERRURE GEXIN 1ER/BOITE GARYCLE/ANBO', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1147, 1, NULL, 'COSSE BATTERIE', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1148, 1, NULL, 'SCIE ARC ET JARDIN', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1149, 1, NULL, 'MOUL POLISHING', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1150, 1, NULL, 'ROULEAU PEINTURE PETIT', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1151, 1, NULL, 'EXTRACTEUR GM/20X20', NULL, NULL, 10, 0, '120.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1152, 1, NULL, 'LAME SAUTEUSE', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1153, 1, NULL, 'ANNEAU TRINGLE MARRON', NULL, NULL, 10, 1, '2.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1154, 1, NULL, 'COF.04MOD APP LAP 6104', NULL, NULL, 10, 0, '6.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1155, 1, NULL, 'COF.08MOD APP 2708/A', NULL, NULL, 10, 0, '28.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1156, 1, NULL, 'COF.12MOD APP 2713/A', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1157, 1, NULL, 'INTER.APP RIF 5081/10B', NULL, NULL, 10, 0, '8.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1158, 1, NULL, 'CABLE TV BLEU', NULL, NULL, 10, 1, '3.00', 4, 2, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1159, 1, NULL, 'SCOTCH VERT JAUNE/SIGMA GM', NULL, NULL, 10, 0, '8.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1160, 1, NULL, 'DOUILLE DOUBLE B E27', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1161, 1, NULL, 'DOUILLE DOUBLE B E14/ DOUILLE TAWFIK 24/4', NULL, NULL, 10, 0, '8.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1162, 1, NULL, 'CABLE RCA 3X1 TV', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1163, 1, NULL, 'COUDE F 1/2 16 TIEMME', NULL, NULL, 10, 0, '16.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1164, 1, NULL, 'DOUILLE PRISE', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1165, 1, NULL, 'DOUBLE PRISE + T OSAC/LAP', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1166, 1, NULL, 'CABLE TV BOUBINA', NULL, NULL, 10, 0, '2.50', 4, 2, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1167, 1, NULL, 'COLLIER TETE PARABOLE NOIR', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1168, 1, NULL, 'MANCHON ROULEAU FIL LAQUE', NULL, NULL, 10, 0, '4.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1169, 1, NULL, 'VINYLE 30KG ARVINYL 1ER CHOIX', NULL, NULL, 10, 0, '480.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1170, 1, NULL, 'VERNIS WOOD ATLAS PALISSANDRE 005 1L', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1171, 1, NULL, 'VIS  TIRE-FOND 8MMX50', NULL, NULL, 10, 10, '0.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1172, 1, NULL, 'VIS TIRE-FOND 8MMX60', NULL, NULL, 10, 10, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1173, 1, NULL, 'TIGE FILETEE  6N', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1174, 1, NULL, 'TIGE FILETEE  8N', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1175, 1, NULL, 'TIGE FILETEE  10N', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1176, 1, NULL, 'TIGE FILETEE  12N', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1177, 1, NULL, 'BOULON ECROU 10X80 / 8X100', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1178, 1, NULL, 'BOULON ECROU 10X60/ 6x100', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1179, 1, NULL, 'BOULON ECROU 10X30', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1180, 1, NULL, 'BOULON ECROU 8X80', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1181, 1, NULL, 'BOULON ECROU 8X60', NULL, NULL, 10, 0, '1.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1182, 1, NULL, 'BOULON ECROU 8X40', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1183, 1, NULL, 'BOULON ECROU 8X20/6x40', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1184, 1, NULL, 'BOULON ECROU 6X60', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1185, 1, NULL, 'BOULON ECROU 6X30', NULL, NULL, 10, 0, '0.80', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1186, 1, NULL, 'BOULON ECROU 6X25', NULL, NULL, 10, 0, '0.80', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1187, 1, NULL, 'BOULON ECROU 6X20/6x16', NULL, NULL, 10, 0, '0.70', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1188, 1, NULL, 'VIS LAVABO', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1189, 1, NULL, 'VIS PARKER 5.5/50', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1190, 1, NULL, 'VIS PARKER 5.5/25', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1191, 1, NULL, 'VIS PARKER 5.5/16', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1192, 1, NULL, 'VIS PARKER 4.8/60', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1193, 1, NULL, 'VIS PARKER 4.8/50', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1194, 1, NULL, 'VIS PARKER 4.8/38', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1195, 1, NULL, 'VIS PARKER 4.8/25', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1196, 1, NULL, 'VIS PARKER 4.8/19', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1197, 1, NULL, 'VIS PARKER 4.2/19', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1198, 1, NULL, 'VIS PARKER 4.8/16', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1199, 1, NULL, 'VIS PARKER 4.2/32', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1200, 1, NULL, 'VIS PARKER 4.2/16', NULL, NULL, 10, 0, '0.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1201, 1, NULL, 'BOUCHON METAL 6', NULL, NULL, 10, 0, '1.10', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1202, 1, NULL, 'BOUCHON METAL 8', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1203, 1, NULL, 'BOUCHON METAL 10', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1204, 1, NULL, 'BOUCHON METAL 12', NULL, NULL, 10, 0, '3.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1205, 1, NULL, 'ENDUIT SUPRAFLEX POUDRE 25KG', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1206, 1, NULL, 'SUPPORT PARABOLE', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1207, 1, NULL, 'COLLIER ING 4.7/370 blanc', NULL, NULL, 10, 0, '1.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1208, 1, NULL, 'TUBE ORANGE T 29 ING', NULL, NULL, 10, 0, '7.00', 4, 2, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1209, 1, NULL, 'REDUCTION  125*110 ABP', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1210, 1, NULL, 'REDUCTION  125*100 ABP', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1211, 1, NULL, 'REDUCTION  125*50 ABP', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1212, 1, NULL, 'EVIER ENC 50*40VC 15CM', NULL, NULL, 10, 0, '220.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1213, 1, NULL, 'COFFRET DE COMPTEUR 2F ONE 14*51 CARRE', NULL, NULL, 10, 0, '135.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1214, 1, NULL, 'TUBE RETUBE 16 TEMME', NULL, NULL, 10, 0, '6.00', 1, 2, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1215, 1, NULL, 'TUBE RETUBE 20 TIEMME', NULL, NULL, 10, 0, '10.00', 1, 2, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1216, 1, NULL, 'VANNE PAPILLON 3/4 TIEMME', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1217, 1, NULL, 'COLLECTEUR 3+VANNE TIEMME/ 3s 3/4', NULL, NULL, 10, 0, '200.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1218, 1, NULL, 'COLLECTEUR 4+VANNE TIEMME', NULL, NULL, 10, 0, '240.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1219, 1, NULL, 'COUDE FEM 20*1/2 TIEMME', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1220, 1, NULL, 'MAMELON 1/2*3/4CUIVRE TIEMME', NULL, NULL, 10, 0, '13.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1221, 1, NULL, 'COUDE BOITIER 16 1/2 TIEMME', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1222, 1, NULL, 'RACCORD M 16 1/2 TEMME', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1223, 1, NULL, 'RACCORD F 16 1/2 TIEMME', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1224, 1, NULL, 'RACCORD EGALE 16 TIEMME', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1225, 1, NULL, 'TEE F 16 1/2 TEMME', NULL, NULL, 10, 0, '37.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1226, 1, NULL, 'TEE EGALE  16  TIEMME', NULL, NULL, 10, 0, '37.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1227, 1, NULL, 'COUDE EGALE 16  TIEMME', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1228, 1, NULL, 'COUDE M 16 1/2  TIEMME', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1229, 1, NULL, 'COUDE M/F  1/2  TIEMME', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1230, 1, NULL, 'AGRAFE 6', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1231, 1, NULL, 'TETE VISSEUSE', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1232, 1, NULL, 'LAMPE A LED SPOT  6W/7W/ MR 16/GU10', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1233, 1, NULL, 'FLEXIBLE MF 1/2 40 CM RIGIDE', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1234, 1, NULL, 'FLEXIBLE MF 1/2 50 CM RIGIDE', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1235, 1, NULL, 'FLEXIBLE MF 1/2 60 CM RIGIDE', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1236, 1, NULL, 'SIPHON 15X15 COUDE  P.S', NULL, NULL, 10, 0, '20.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1237, 1, NULL, 'SIPHON 10/10 COUDE P.S', NULL, NULL, 10, 0, '20.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1238, 1, NULL, 'SIPHON 10X10 CHROME RELAX', NULL, NULL, 10, 0, '25.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1239, 1, NULL, 'SIPHON 15X15 CHROME RELAX', NULL, NULL, 10, 0, '50.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1240, 1, NULL, 'PORTE PAPIER BLANC P.S', NULL, NULL, 10, 0, '15.00', 2, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1241, 1, NULL, 'AUGE MACON', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1242, 1, NULL, 'SEAU MACON', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1243, 1, NULL, 'MECHE 10 INOX', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1244, 1, NULL, 'MECHE 8 INOX', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1245, 1, NULL, 'MAT BATIMA 5KG', NULL, NULL, 10, 0, '75.00', 5, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1246, 1, NULL, 'CADRE SPOT CRISTAL / BLANC/CHROME', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1247, 1, NULL, 'LAMPE A LED SPOT 3W', NULL, NULL, 10, 0, '18.00', 4, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1248, 1, NULL, 'BOULON ECROU 6X80', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1249, 1, NULL, 'VIS PARKER 6.3/19/25', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(1250, 1, NULL, 'ECROU 10', NULL, NULL, 10, 0, '0.50', 3, 5, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1251, 1, NULL, 'ECROU 8', NULL, NULL, 10, 0, '0.40', 3, 5, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1252, 1, NULL, 'ECROU 6', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1253, 1, NULL, 'VIS  TIRE-FOND 6MMX120', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1254, 1, NULL, 'VIS  TIRE-FOND 6MMX70', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1255, 1, NULL, 'VIS  TIRE-FOND 6MMX80', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1256, 1, NULL, 'VIS  TIRE-FOND 6MMX50', NULL, NULL, 10, 0, '0.80', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1257, 1, NULL, 'VIS  TIRE-FOND 6MMX40', NULL, NULL, 10, 0, '0.70', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1258, 1, NULL, 'VIS  TIRE-FOND 8MMX100', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1259, 1, NULL, 'VIS  TIRE-FOND 8MMX80', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1260, 1, NULL, 'ECROU 4', NULL, NULL, 10, 0, '0.15', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1261, 1, NULL, 'ECROU 5', NULL, NULL, 10, 0, '0.15', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1262, 1, NULL, 'VIS  ECROU 4X20/4x30', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1263, 1, NULL, 'VIS  ECROU 4X50', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1264, 1, NULL, 'VIS  ECROU 4X60', NULL, NULL, 10, 0, '0.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1265, 1, NULL, 'VIS  ECROU 5X20', NULL, NULL, 10, 0, '0.30', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1266, 1, NULL, 'VIS  ECROU 5X30', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1267, 1, NULL, 'VIS ECROU 5X50', NULL, NULL, 10, 0, '0.50', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1268, 1, NULL, 'VIS  ECROU 4X40', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1269, 1, NULL, 'RONDELLE 6X20', NULL, NULL, 10, 0, '0.20', 3, 5, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1270, 1, NULL, 'RONDELLE 8X20', NULL, NULL, 10, 0, '0.20', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1271, 1, NULL, 'RONDELLE 4X10', NULL, NULL, 10, 0, '0.10', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1272, 1, NULL, 'SERRIE TOURNEVIS ORANGE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1273, 1, NULL, 'SERRIE CLES 54P ORANGE', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1274, 1, NULL, 'SERRIE TOURNEVIS JAUNE', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1275, 1, NULL, 'CHALUMEAU DINGOI / PAC/ 3PCS LAMBOSS', NULL, NULL, 10, 0, '150.00', 3, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1276, 1, NULL, 'CADENAS MOTO TISSU', NULL, NULL, 10, 0, '75.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1277, 1, NULL, 'CADENAS CHAINE TISSU', NULL, NULL, 10, 0, '65.00', 9, 1, '2026-09-15 12:47:16', '2026-09-15 12:47:16'),
(1278, 1, NULL, 'ADAPTATEUR  ANGLAISE SIMPLE', NULL, NULL, 10, 0, '4.50', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1279, 1, NULL, 'RALLONGE ROND 5M ING S', NULL, NULL, 10, 0, '40.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1280, 1, NULL, 'SERRIE TOURNEVIS ROMA', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1281, 1, NULL, 'RALLONGE ING  2P+T  4 CARRE', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1282, 1, NULL, 'TESTEUR  DOUBLE P/A  SIMPLE/ COLOR', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1283, 1, NULL, 'SERRIE SUP GRIO /DANI /LONG', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1284, 1, NULL, 'TENDEUR BLEU', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1285, 1, NULL, 'FOUR BOUTEILLE GAZ 37DH', NULL, NULL, 10, 0, '45.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1286, 1, NULL, 'TUYAU  GAZ ORANGE/ BLEU', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1287, 1, NULL, 'LAMPE  B22 75W', NULL, NULL, 10, 0, '3.50', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1288, 1, NULL, 'RALLONGE 4 PHILIA', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1289, 1, NULL, 'TETE GAZ 26.50DHS', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1290, 1, NULL, 'STOP LAVABO4P', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1291, 1, NULL, 'RESISTANCE  VERT', NULL, NULL, 10, 0, '28.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1292, 1, NULL, 'GANT 11', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1293, 1, NULL, 'DOUILLE B22 SIMPLE', NULL, NULL, 10, 0, '3.50', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1294, 1, NULL, 'VENTEUSE COLOR PM/ROSSO GM', NULL, NULL, 10, 0, '11.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1295, 1, NULL, 'CADENAS 65 TAB/ 67  VACHET /60CHROME', NULL, NULL, 10, 0, '28.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1296, 1, NULL, 'PIL D 20 ROBUST', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1297, 1, NULL, 'PIL 3A SUPERLUX', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1298, 1, NULL, 'PIL 20 EVEREDI', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1299, 1, NULL, 'AGRAFEUSE P', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1300, 1, NULL, 'C GAZ JAUNE', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1301, 1, NULL, 'COMPRIME RED', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1302, 1, NULL, 'PRODUIT NETTOYAGE ARGENT  CILAR', NULL, NULL, 10, 0, '13.00', 8, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1303, 1, NULL, 'ROBINET TRIOU GAZ 1ER', NULL, NULL, 10, 0, '22.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1304, 1, NULL, 'ROBINET TRIOU GAZ 2EME', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1305, 1, NULL, 'ROBINET  GAZ FOUR 2EME', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1306, 1, NULL, 'TEE GAZ SIMPLE', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1307, 1, NULL, 'GAZ LAITON TOMA', NULL, NULL, 10, 0, '9.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1308, 1, NULL, 'GAZ LAITON GM/MM/PM', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1309, 1, NULL, 'DOUBLE TENDEUR CLE', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1310, 1, NULL, 'CABLE PRISE RADIO 2EME', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1311, 1, NULL, 'STOP LAVA PLAS', NULL, NULL, 10, 0, '2.50', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1312, 1, NULL, 'CADENAS VELO CODE/COLOR', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1313, 1, NULL, 'VAP ALLUMIN', NULL, NULL, 10, 0, '14.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1314, 1, NULL, 'GANT NOIR(N.D)', NULL, NULL, 10, 0, '14.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1315, 1, NULL, 'CAFOUR BLAN 200G', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1316, 1, NULL, 'BALAI1 10/ dur', NULL, NULL, 10, 0, '14.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1317, 1, NULL, 'SAC', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1318, 1, NULL, 'COCOT POIG', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1319, 1, NULL, 'COCOT M chin', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1320, 1, NULL, 'GAZ TETE ORGAZ 15', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1321, 1, NULL, 'CALCU', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1322, 1, NULL, 'GAZ TETE NOIR', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1323, 1, NULL, 'CINTRE', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1324, 1, NULL, 'TEST P/M 2.50', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1325, 1, NULL, 'DOUI E27', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1326, 1, NULL, 'CINTRE CHR', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1327, 1, NULL, 'CHIFFON T6', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1328, 1, NULL, 'STOP INOX', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1329, 1, NULL, 'P SAV', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1330, 1, NULL, 'CSCAS', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1331, 1, NULL, 'MEMBRA CHAUFFE', NULL, NULL, 10, 0, '10.00', 6, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1332, 1, NULL, 'GICL GAZ', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1333, 1, NULL, 'CABLE RCA 3X3 EME', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1334, 1, NULL, 'ROULEAU PLASTIQUE VERT 1.5M EPAIS', NULL, NULL, 10, 0, '8.00', 9, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1335, 1, NULL, 'ROULEAU PLASTIQUE BLANC 1.5M FINE /27-8-22PAR KG', NULL, NULL, 10, 0, '0.00', 9, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1336, 1, NULL, 'ROULEAU PLASTIQUE JAUNE 2M EPAIS', NULL, NULL, 10, 0, '0.00', 9, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1337, 1, NULL, 'JOURNAL', NULL, NULL, 10, 0, '10.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1338, 1, NULL, 'SAC COLOR', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1339, 1, NULL, 'CYLINDRE DE SERRURE LAITON LINCE', NULL, NULL, 10, 0, '45.00', 3, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1340, 1, NULL, 'CYLINDRE DE SERRURE METAL LINCE /SIMA', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1341, 1, NULL, 'CYLINDRE DE SERRURE TESA', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1342, 1, NULL, 'CYLINDR DE SERRURE VACHETTE', NULL, NULL, 10, 0, '37.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1343, 1, NULL, 'SERRURE  A TIRETTE /FREIN  OSCAR', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1344, 1, NULL, 'SERRURE TIROIR SIMPLE OSCAR /CARDO', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1345, 1, NULL, 'SERRURE TIROIR ELEPH/enix/SIMPLE/LACE', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1346, 1, NULL, 'SERRURE A CYLINDRE  7 CM CARDO', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1347, 1, NULL, 'CLOU AIMANT 8', NULL, NULL, 10, 0, '0.40', 3, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1348, 1, NULL, 'CORDE PLASTIQUE', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1349, 1, NULL, 'CORDE P/M', NULL, NULL, 10, 0, '1.50', 3, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1350, 1, NULL, 'ARVINYL 5K BLEU 365', NULL, NULL, 10, 0, '110.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1351, 1, NULL, 'ITRY PLAST 30K ROUGE MARRAK', NULL, NULL, 10, 0, '420.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1352, 1, NULL, 'LOGICOLOR 1K BLEU FONCE', NULL, NULL, 10, 0, '30.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1353, 1, NULL, 'PIQUET DE TERRE 14*1.20 A/FILET SER/CABL', NULL, NULL, 10, 0, '57.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1354, 1, NULL, 'PINCE DANCRAGE PA25', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1355, 1, NULL, 'RAIL OMEGA PERFORE 7MM L.35MM 2', NULL, NULL, 10, 0, '12.00', 4, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1356, 1, NULL, 'BOITE ETAN.7410/LAP', NULL, NULL, 10, 0, '8.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1357, 1, NULL, 'RENVOI D ANGLE 804M', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1358, 1, NULL, 'DISJONCTEUR .TEST 2F 10/30A', NULL, NULL, 10, 0, '360.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1359, 1, NULL, 'SERRIE TOURNEVIS ROND', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1360, 1, NULL, 'FLEXIBLE 60 CM', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1361, 1, NULL, 'RESEVOIRE 70/7ROCA BLANC', NULL, NULL, 10, 0, '620.00', 2, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1362, 1, NULL, 'SIEGE A LA TURQUIE ROCA BLANC', NULL, NULL, 10, 0, '180.00', 2, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1363, 1, NULL, 'CUVETTE ROCA ADEL BLANC', NULL, NULL, 10, 0, '780.00', 2, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1364, 1, NULL, 'FICHE TV COUDE M', NULL, NULL, 10, 0, '1.50', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1365, 1, NULL, 'PINCEAU RADIATEUR', NULL, NULL, 10, 0, '8.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1366, 1, NULL, 'COLOSTOP 1KG', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1367, 1, NULL, 'SILICONE TRAN/BLAN 280ML 2EME CHOIX', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1368, 1, NULL, 'LAMPE FLAMME/LAMPE PM 2EME', NULL, NULL, 10, 0, '3.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1369, 1, NULL, 'EVIER DOUBLE +SIPHON', NULL, NULL, 10, 0, '550.00', 2, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1370, 1, NULL, 'TEFLON G/G', NULL, NULL, 10, 0, '18.00', 1, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1371, 1, NULL, 'ESSENCE INDES 3/4', NULL, NULL, 10, 0, '13.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1372, 1, NULL, 'CABLE THS ALLUM 2X16M', NULL, NULL, 10, 0, '7.00', 4, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1373, 1, NULL, 'TRANSFORMATEUR FIL LED COULEUR', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1374, 1, NULL, 'TRANSFORMATEUR FIL LED BLANC', NULL, NULL, 10, 0, '7.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1375, 1, NULL, 'VIS TIRE-FOND 8MM40', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1376, 1, NULL, 'BOULON ECROU 10X50/10x40', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1377, 1, NULL, 'RONDELLE 10X30', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1378, 1, NULL, 'RONDELLE 12X30', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1379, 1, NULL, 'RONDELLE 5', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1380, 1, NULL, 'PROJECTEUR A LED 20W', NULL, NULL, 10, 0, '120.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1381, 1, NULL, 'PROJECTEUR A LED 30W', NULL, NULL, 10, 0, '140.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1382, 1, NULL, 'PROJECTEUR A LED 50W', NULL, NULL, 10, 0, '160.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1383, 1, NULL, 'LAMPE  A LED LAVABO', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1384, 1, NULL, 'LAMPE  A LED 9W ING', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1385, 1, NULL, 'LAMPE  A LED 12V 5W/12V 9W', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1386, 1, NULL, 'APPAREIL MOUSTIQUE', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1387, 1, NULL, 'ROBINET BOUTEILLE', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1388, 1, NULL, 'SUPRAGEL 25KG VERONA', NULL, NULL, 10, 0, '85.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1389, 1, NULL, 'BOMBE ROUGE', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1390, 1, NULL, 'BOMBE GRIS', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1391, 1, NULL, 'HUILE DE MACHINE', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1392, 1, NULL, 'LAMPE A LED 12W B22 et jaune', NULL, NULL, 10, 0, '17.00', 4, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1393, 1, NULL, 'FILTRE ROBINET F 1ER', NULL, NULL, 10, 0, '8.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1394, 1, NULL, 'FILTRE ROBINET M 1ER', NULL, NULL, 10, 0, '8.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1395, 1, NULL, 'ROBINET DARRET TAB1/2 2EME/ SPANIA', NULL, NULL, 10, 1, '28.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1396, 1, NULL, 'VANNE COMPTEUR MF 3/4 CUIVRE RELAX', NULL, NULL, 10, 1, '60.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1397, 1, NULL, 'CLE COMPTEUR', NULL, NULL, 10, 1, '15.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1398, 1, NULL, 'DOUCHETTE COMPLET RIVER/ITALI-NOIR', NULL, NULL, 10, 0, '90.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1399, 1, NULL, 'MECANISME FLOTTEUR RIVER', NULL, NULL, 10, 0, '125.00', 1, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1400, 1, NULL, 'ROBINET LAVABO relax/ROBINET CUISINE MUR CLIMO/MM', NULL, NULL, 10, 0, '90.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1401, 1, NULL, 'ROBINET LAVABO BEC/CUISINE RELAX', NULL, NULL, 10, 0, '90.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1402, 1, NULL, 'ROBINET LAVABO DROIT  RELAX', NULL, NULL, 10, 0, '140.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1403, 1, NULL, 'ROBINET CUISINE BEC /MUR RELAX', NULL, NULL, 10, 0, '90.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1404, 1, NULL, 'MELANGEUR DOUCHE 2EME GL', NULL, NULL, 10, 0, '220.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1405, 1, NULL, 'MELANGEUR CUISINE 2EME GL', NULL, NULL, 10, 0, '190.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1406, 1, NULL, 'GORGE SIPHON MAGIQ 40', NULL, NULL, 10, 0, '15.00', 2, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1407, 1, NULL, 'TETE DOUCHETTE  RELAX/REGLAGE INCASSABLE', NULL, NULL, 10, 0, '28.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1408, 1, NULL, 'TETE DOUCHETTE SIMPLE 2/SOPHIA /NORTA', NULL, NULL, 10, 0, '23.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1409, 1, NULL, 'SUPPORT DOUCHE 4', NULL, NULL, 10, 0, '14.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1410, 1, NULL, 'SUPPORT DOUCHE 4*', NULL, NULL, 10, 0, '14.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1411, 1, NULL, 'SUPPORT DOUCHE 2', NULL, NULL, 10, 0, '15.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1412, 1, NULL, 'SUPPORT DOUCHE REGLAGE', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1413, 1, NULL, 'ADESIVA 0.5 COLORADO', NULL, NULL, 10, 0, '58.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1414, 1, NULL, 'ATLAS DOREE 1KG', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1415, 1, NULL, 'DILUANT NIVADA 1L', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1416, 1, NULL, 'ITOLAC 5K', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1417, 1, NULL, 'VERNIS COLOXIME 1L', NULL, NULL, 10, 0, '30.00', 5, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1418, 1, NULL, 'EMBRASSE RIDEAU CRISTAL 2P/1P CRISTAL JAUNE', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1419, 1, NULL, 'TRUELLE LISSEUSE DENTEE PLATRE', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1420, 1, NULL, 'TRUELLE LISSEUSE BETON 1ER', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1421, 1, NULL, 'TRUELLE LISSEUSE BETON 2', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1422, 1, NULL, 'CHAINES COLOR', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1423, 1, NULL, 'EMBRASSE RIDEAU  ROND/MOTIF', NULL, NULL, 10, 0, '65.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1424, 1, NULL, 'METRE TABLEAU 5M', NULL, NULL, 10, 0, '25.00', 3, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1425, 1, NULL, 'METRE TABLEAU 3M', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1426, 1, NULL, 'METRE TABLEAU 8M', NULL, NULL, 10, 0, '45.00', 3, 5, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1427, 1, NULL, 'CLE 27 /24', NULL, NULL, 10, 0, '16.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1428, 1, NULL, 'GANTN-13dh BLEU /GRIS', NULL, NULL, 10, 0, '18.00', 8, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1429, 1, NULL, 'SCIE FER 1', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1430, 1, NULL, 'BAGUETTE COTE MUR', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1431, 1, NULL, 'SERRURE  A TIRETTE FTG', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1432, 1, NULL, 'SUPPORT CROCHET', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1433, 1, NULL, 'BANDE PORTE SIMPLE', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1434, 1, NULL, 'SERRURE  A TIRETTE 12 TURK', NULL, NULL, 10, 0, '160.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1435, 1, NULL, 'SERRURE  A TIRETTE DAF 14', NULL, NULL, 10, 0, '140.00', 3, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1436, 1, NULL, 'SERRURE  A TIRETTE GMB', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1437, 1, NULL, 'SUPPORT TELE W5D PM', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1438, 1, NULL, 'SUPPORT TELE G2/ DN1', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1439, 1, NULL, 'SUPPORT TELE 215', NULL, NULL, 10, 0, '80.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1440, 1, NULL, 'SUPPORT TELE  SL12D', NULL, NULL, 10, 0, '120.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1441, 1, NULL, 'SUPPORT TELE  LO45', NULL, NULL, 10, 0, '160.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1442, 1, NULL, 'TETE 1', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1443, 1, NULL, 'TETE 2', NULL, NULL, 10, 0, '40.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1444, 1, NULL, 'TETE 4', NULL, NULL, 10, 0, '90.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1445, 1, NULL, 'ECHOLINK FINDER', NULL, NULL, 10, 0, '80.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1446, 1, NULL, 'PARABOL 90 ECHOLINK', NULL, NULL, 10, 0, '110.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1447, 1, NULL, 'PARABOL 70 TECHNOSTHR', NULL, NULL, 10, 0, '90.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1448, 1, NULL, 'SUPPORT PARABOL COUDE', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1449, 1, NULL, 'SWITCH ECOLI', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1450, 1, NULL, 'TRINGLE M28 -7 POPULAIRE 2M', NULL, NULL, 10, 0, '45.00', 3, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1451, 1, NULL, 'TRINGLE M28 -7 POPULAIRE 3M', NULL, NULL, 10, 0, '45.00', 3, 2, '2026-09-15 12:47:17', '2026-09-15 12:47:17'),
(1452, 1, NULL, 'CLE A MOLETTE  CHROME DANI', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1453, 1, NULL, 'TUYAUX JARDIN SIMPLE', NULL, NULL, 10, 0, '5.00', 9, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1454, 1, NULL, 'CLOU 2 TP', NULL, NULL, 10, 0, '18.00', 3, 5, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1455, 1, NULL, 'PAPIER RESIN 60/80 SAIT', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1456, 1, NULL, 'RIVET 4X20', NULL, NULL, 10, 0, '0.20', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1457, 1, NULL, 'CLOU TAPISSIER PLASTIQUE', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1458, 1, NULL, 'DISQUE MARBRE PROTON 230', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1459, 1, NULL, 'VA ET VIENT PLACARD', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1460, 1, NULL, 'MECHE 5 INOX', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1461, 1, NULL, 'MECHE 6 INOX', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1462, 1, NULL, 'MECHE 7 INOX', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1463, 1, NULL, 'CLE PLATE 10-11', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1464, 1, NULL, 'CLE PLATE 12-13', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1465, 1, NULL, 'CLE PLATE 14-15', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1466, 1, NULL, 'CLE PLATE 16-17', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1467, 1, NULL, 'FIXATION MIROIR CHROME', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1468, 1, NULL, 'CLOU TAPISSIER PAR PIECE', NULL, NULL, 10, 0, '0.05', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1469, 1, NULL, 'COUTEAU CARROSSERIE 1ER', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1470, 1, NULL, 'ABATANT GLISSE TIROIR CBLANC 30/40/50', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1471, 1, NULL, 'CHARNIERE 521', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1472, 1, NULL, 'MECHE HILTI LONG', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1473, 1, NULL, 'PAUMELLE AILE   80', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1474, 1, NULL, 'PAUMELLE AILE   100', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1475, 1, NULL, 'PAUMELLE AILE   120', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1476, 1, NULL, 'ROULETTE 50 GRIS', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1477, 1, NULL, 'MASSETTE ENLEVE CLOU', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1478, 1, NULL, 'MASSETTE MENUISERIE', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1479, 1, NULL, 'DISQUE TR', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1480, 1, NULL, 'SCIE PLATRE/SCIE BOIS VST', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1481, 1, NULL, 'SCIE MENUISERIE', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1482, 1, NULL, 'CONNECTEUR RESEAU', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1483, 1, NULL, 'POIGNEE PORTE BOUTON', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1484, 1, NULL, 'FENETRE GAINE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1485, 1, NULL, 'POIGNEE TIRETTE ANCIEN', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1486, 1, NULL, 'MIDI  YAKOUTE 2KG', NULL, NULL, 10, 0, '300.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1487, 1, NULL, 'BROSSE BETON(jir)', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1488, 1, NULL, 'MIDI LAC MARRON CLAIRE 06 5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1489, 1, NULL, 'MIDI LAC CHAMOIS 34 5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1490, 1, NULL, 'MIDI LAC BLEU MAJORELLE  14 5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1491, 1, NULL, 'MIDI LAC ROUGE 05 5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1492, 1, NULL, 'MIDI LAC GRIS 50   5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1493, 1, NULL, 'MIDI LAC JAUNE 04   5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1494, 1, NULL, 'MIDI LAC GRIS 1/2KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1495, 1, NULL, 'MIDI LAC VERT  1/2KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1496, 1, NULL, 'MIDI LAC BLEU  1/2KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1497, 1, NULL, 'MIDI LAC ROUGE  1/2KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1498, 1, NULL, 'MIDI LAC ROUGE  1KG', NULL, NULL, 10, 0, '35.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1499, 1, NULL, 'MIDI LAC JAUNE  1KG', NULL, NULL, 10, 0, '35.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1500, 1, NULL, 'MECHE BOIS 18', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1501, 1, NULL, 'MECHE BOIS 20', NULL, NULL, 10, 0, '17.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1502, 1, NULL, 'MECHE BOIS 25', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1503, 1, NULL, 'CROCHET 4X50/4x6', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1504, 1, NULL, 'PITON 4*30/', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1505, 1, NULL, 'POIGNEE LEVER NOIR', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1506, 1, NULL, 'POIGNEE TIRETTE TIROIR G', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1507, 1, NULL, 'EPONGE', NULL, NULL, 10, 0, '1.00', 8, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1508, 1, NULL, 'SUPPORT RIDEAU 16 ALUMI', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1509, 1, NULL, 'CLOU TAPISSIER PAR PAQUET', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1510, 1, NULL, 'TOURNEVIS DOUBLE  //VAST', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1511, 1, NULL, 'SUPPORT DOUBLE RIDEAU JAUNE', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1512, 1, NULL, 'FIL LINGE 15M', NULL, NULL, 10, 0, '15.00', 8, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1513, 1, NULL, 'CLE A GRIFFE 14', NULL, NULL, 10, 0, '60.00', 3, 5, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1514, 1, NULL, 'CHAINE ANIMAUX', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1515, 1, NULL, 'COUTEAU VERRE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1516, 1, NULL, 'TETE VISSEUSE DOUBLE', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1517, 1, NULL, 'VENTEUSE SUPPOR', NULL, NULL, 10, 0, '1.50', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1518, 1, NULL, 'CLOU TAPISSIER GRAND JAUNE', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1519, 1, NULL, 'VENTEUSE SUPPORT G', NULL, NULL, 10, 0, '1.50', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1520, 1, NULL, 'CUTTER AVEC CHANGE', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1521, 1, NULL, 'MANDRIN PERCEUSE /HILTI/GRANETTE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1522, 1, NULL, 'SUPPORT RIDEAU MARRON 1', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1523, 1, NULL, 'PORTE CLE ETIQUETTE', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1524, 1, NULL, 'COLOSTOP 30KG', NULL, NULL, 10, 0, '460.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1525, 1, NULL, 'ENDUIT COLORADO POUDRE 25KG', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1526, 1, NULL, 'BOMBE VERT', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1527, 1, NULL, 'REGLETTE ALLUMINIUM 2M BETON', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1528, 1, NULL, 'CABLE ARME 4X16', NULL, NULL, 10, 0, '68.00', 4, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1529, 1, NULL, 'COLLIER POUR POTEAU', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1530, 1, NULL, 'GRILLAGE  AVERTIS', NULL, NULL, 10, 0, '3.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1531, 1, NULL, 'PLATINE INTERPHON', NULL, NULL, 10, 0, '280.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1532, 1, NULL, 'FICHE 2P+T FEM /MAL ING', NULL, NULL, 10, 0, '9.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1533, 1, NULL, 'SCOTCH DOUBLE FACE', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1534, 1, NULL, 'SERRURE TIROIR ELART RESSORT /CLE ROND/EVRUO', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1535, 1, NULL, 'PIEDS CANAPE  5CM', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1536, 1, NULL, 'PIEDS CANAPE  3 CM', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1537, 1, NULL, 'SONNETTE SANS FIL', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1538, 1, NULL, 'SONNETTE PIAN', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1539, 1, NULL, 'SONNETTE OISE', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1540, 1, NULL, 'SONNETTE SANS FIL PRISE', NULL, NULL, 10, 0, '130.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1541, 1, NULL, 'SONNETTE NAKOUSS', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1542, 1, NULL, 'COLLIER TUYAU D EAU', NULL, NULL, 10, 0, '3.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1543, 1, NULL, 'MECHE 4 BOCH INOX', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1544, 1, NULL, 'ROULETTE 50 ORANGE //', NULL, NULL, 10, 0, '9.50', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1545, 1, NULL, 'ROULETTE 40 ORANGE //', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1546, 1, NULL, 'ROBINET SERVICE 1/2 VILDA DORE', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1547, 1, NULL, 'ROBINET SERVICE 1/2 VILDA CHROME', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1548, 1, NULL, 'MATEX BLANC 30KG', NULL, NULL, 10, 0, '340.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1549, 1, NULL, 'PPR 25 COES', NULL, NULL, 10, 0, '12.00', 1, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1550, 1, NULL, 'COUDE 1/4 PPR 25COES', NULL, NULL, 10, 0, '12.00', 1, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1551, 1, NULL, 'REDUIT 25X20 COES', NULL, NULL, 10, 0, '4.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1552, 1, NULL, 'RACCORD M 25X1/2 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1553, 1, NULL, 'RACCORD FF 25X1/2 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1554, 1, NULL, 'COUDE FF 25X1/2 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1555, 1, NULL, 'TEE FF 25X1/2 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1556, 1, NULL, 'MECANISME POUSSOIRE ROCA', NULL, NULL, 10, 0, '180.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1557, 1, NULL, 'ROBINET SERVICE 1/2 JAUNE SILVER/RELAX/ AZIZ', NULL, NULL, 10, 0, '45.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1558, 1, NULL, 'ROBINET SERVICE 1/2 SILVER CHROME', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1559, 1, NULL, 'TEE SIMPLE 25 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1560, 1, NULL, 'SAC POUBELLE P VERT', NULL, NULL, 10, 0, '1.00', 8, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1561, 1, NULL, 'SAC POUBELLE G VERT', NULL, NULL, 10, 0, '3.00', 8, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1562, 1, NULL, 'SAC POUBELLE G NOIR', NULL, NULL, 10, 0, '2.50', 8, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1563, 1, NULL, 'CORDE SB', NULL, NULL, 10, 0, '0.50', 3, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1564, 1, NULL, 'LAQUE 20KG COLOLAC', NULL, NULL, 10, 0, '630.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1565, 1, NULL, 'ROULEAU PLASTIQUE BLANC 1.5M EPAIS', NULL, NULL, 10, 0, '12.00', 9, 5, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1566, 1, NULL, 'ENDUIT ATLAS PATE 1KG', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1567, 1, NULL, 'ENDUIT ATLAS  PATE 1KG 2EME', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1568, 1, NULL, 'FAYROUZ COULEUR', NULL, NULL, 10, 0, '340.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1569, 1, NULL, 'ASSALA BLANC 5K', NULL, NULL, 10, 0, '250.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1570, 1, NULL, 'MAMELON MM 1/2 cuivre G1', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1571, 1, NULL, 'TUYAUX  JARDIN 1ER', NULL, NULL, 10, 0, '10.00', 9, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1572, 1, NULL, 'ALARME', NULL, NULL, 10, 0, '70.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1573, 1, NULL, 'LUNETTE NOIR', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1574, 1, NULL, 'INTERPHON 4P MASTERPHONE', NULL, NULL, 10, 0, '850.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1575, 1, NULL, 'TENAILLE BLOTTA', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1576, 1, NULL, 'FAYROUZE116', NULL, NULL, 10, 0, '340.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1577, 1, NULL, 'LAMPE A LED 36 FILIES', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1578, 1, NULL, 'LAMPE A LED  9W PM', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1579, 1, NULL, 'ENDUIT POUDRE MIDI 25KG', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1580, 1, NULL, 'COLOLAQ 5KG', NULL, NULL, 10, 0, '170.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1581, 1, NULL, 'MAT ARDOISINE 5KG', NULL, NULL, 10, 0, '125.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1582, 1, NULL, 'VINYLE NIVADA 45KG', NULL, NULL, 10, 0, '320.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1583, 1, NULL, 'SUPRI LAQUE  1KG', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1584, 1, NULL, 'PIEGE RAT', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1585, 1, NULL, 'ARCOL 5KG BEIGE MAMOUNIA', NULL, NULL, 10, 0, '95.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1586, 1, NULL, 'VERNIS WOOD ASTRAL ACAJOU 1L', NULL, NULL, 10, 0, '95.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1587, 1, NULL, 'CHAUFFE EAU GAZ CHAUFFE-EAU TO', NULL, NULL, 10, 0, '900.00', 6, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1588, 1, NULL, 'DOUCHETTE  FLEXIBLE CHINO', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1589, 1, NULL, 'LAMPE A LED SPOT 10/16 JAUNE ET BLANC', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1590, 1, NULL, 'ESCABLEAUX  4', NULL, NULL, 10, 0, '350.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1591, 1, NULL, 'COF 02 MOD APP 2FIL', NULL, NULL, 10, 0, '7.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1592, 1, NULL, 'POUSSOIR RIDEAU GALAXY MARRON', NULL, NULL, 10, 0, '40.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1593, 1, NULL, 'PRISE TV GALAXY', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1594, 1, NULL, 'DOUILLE  E 27 PORCELAINE', NULL, NULL, 10, 0, '3.50', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1595, 1, NULL, 'TIRE CABLE 15M', NULL, NULL, 10, 0, '80.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1596, 1, NULL, 'BOITE DIST A BORNE LAP', NULL, NULL, 10, 0, '140.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1597, 1, NULL, 'VA ET VIENT  PRISE 2P GALAXY BLANC', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1598, 1, NULL, 'VA ET VIENT PRISE 2P GALAXY MARRON', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1599, 1, NULL, 'DOUILLE B 22 ING 7422B', NULL, NULL, 10, 0, '4.50', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1600, 1, NULL, 'ROULEAU PEINTURE VINYLE/LAQUE GM', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1601, 1, NULL, 'ROULEAU PEINTURE VINYLE/LAQUE PM', NULL, NULL, 10, 0, '18.00', 5, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1602, 1, NULL, 'PINCEAU ROND  1/ 2 CHOIX', NULL, NULL, 10, 0, '15.00', 5, 2, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1603, 1, NULL, 'SERRURE A TIRETTE  FREIN  DOOR LOCK NOIR', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1604, 1, NULL, 'TENDEUR FILE LINGE PM', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1605, 1, NULL, 'TENDEUR FILE LINGE GM', NULL, NULL, 10, 0, '7.00', 9, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1606, 1, NULL, 'BOUCHON ELEC 25A PORCELAINE', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1607, 1, NULL, 'BOUCHON ELEC 10A PORCELAINE', NULL, NULL, 10, 0, '6.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1608, 1, NULL, 'PORTE DISJ 2F', NULL, NULL, 10, 0, '28.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1609, 1, NULL, 'PORTE DISJ 4F', NULL, NULL, 10, 0, '38.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1610, 1, NULL, 'TRANSFORMATEUR CABLE LED COULEUR AVEC TELECOMMANDE', NULL, NULL, 10, 0, '65.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1611, 1, NULL, 'LAMPE A LED 10W 12V/9W', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1612, 1, NULL, 'DOUBLE PRISE + T ING', NULL, NULL, 10, 0, '25.00', 4, 5, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1613, 1, NULL, 'LAVABO 50 ADELE BLANC', NULL, NULL, 10, 0, '230.00', 2, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1614, 1, NULL, 'COLONNE  ADELE BLANC ROCA', NULL, NULL, 10, 0, '200.00', 2, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1615, 1, NULL, 'MITIGEUR CUISINE S/T 40 MALAGA', NULL, NULL, 10, 0, '130.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1616, 1, NULL, 'MITIGEUR CUISINE/MUR 40 MALAGA', NULL, NULL, 10, 0, '130.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1617, 1, NULL, 'MITIGEUR BAIGNOIRE CLIMO', NULL, NULL, 10, 0, '180.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1618, 1, NULL, 'COUDE FLEXIBLE WC 2EME', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1619, 1, NULL, 'ROBINET SERVICE 1/2 CHROME SANI/TABL SARRIR', NULL, NULL, 10, 0, '34.00', 7, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1620, 1, NULL, 'COLLE PVC QUILOSA  GM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1621, 1, NULL, 'RALLONGE 5CM LAITON', NULL, NULL, 10, 0, '25.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1622, 1, NULL, 'RALLONGE 10CM LAITON', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:18', '2026-09-15 12:47:18'),
(1623, 1, NULL, 'COUDE FLEXIBLE WC FIX', NULL, NULL, 10, 0, '45.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1624, 1, NULL, 'RALLONGE 7 CM LAITON', NULL, NULL, 10, 0, '27.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1625, 1, NULL, 'ROSACE 1/2 1ER', NULL, NULL, 10, 0, '3.00', 1, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1626, 1, NULL, 'VIS MECANISSME', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1627, 1, NULL, 'SIPHON  10 X 10 PLASTIQUE', NULL, NULL, 10, 0, '10.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1628, 1, NULL, 'SIPHON  15 X 15 PLASTIQUE', NULL, NULL, 10, 0, '15.00', 2, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1629, 1, NULL, 'TETE ROBINET 1/2 CHROME', NULL, NULL, 10, 0, '15.00', 7, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1630, 1, NULL, 'COIN SALLE DE BAIN PLSTIQ', NULL, NULL, 10, 0, '50.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1631, 1, NULL, 'BROSSE WC ROUGE', NULL, NULL, 10, 0, '25.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1632, 1, NULL, 'NETTOYEUR DE VITRE AVEC VAPORISATEUR', NULL, NULL, 10, 0, '35.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1633, 1, NULL, 'POUBELLE WC PLASTIQUE 6L', NULL, NULL, 10, 0, '30.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1634, 1, NULL, 'MIROIR 60*45 AVEC SPOT', NULL, NULL, 10, 0, '150.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1635, 1, NULL, 'SIPHON 10*10 POUSSOIR', NULL, NULL, 10, 0, '50.00', 2, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1636, 1, NULL, 'NIVEAU D TUYAU 8', NULL, NULL, 10, 0, '2.50', 3, 2, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1637, 1, NULL, 'NIVEAU D TUYAU 10', NULL, NULL, 10, 0, '3.00', 3, 2, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1638, 1, NULL, 'PIED CANAPE ROND 4', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1639, 1, NULL, 'PIED CANAPE ROND 5', NULL, NULL, 10, 0, '5.50', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1640, 1, NULL, 'FIL GALVANISE 16', NULL, NULL, 10, 0, '1.00', 3, 2, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1641, 1, NULL, 'EQUERRE JAUNE 30MM', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1642, 1, NULL, 'FIXATION MEUBLE 1ER', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1643, 1, NULL, 'SERRURE BARRETTE CHAINE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1644, 1, NULL, 'SERRURE BARRETTE CHAINE 1ER', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1645, 1, NULL, 'CYLINDRE DE SERRURE LINKE BLEU', NULL, NULL, 10, 0, '55.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1646, 1, NULL, 'SAUTEUSE BLEU', NULL, NULL, 10, 0, '280.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1647, 1, NULL, 'CLE PIPE 13', NULL, NULL, 10, 0, '15.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1648, 1, NULL, 'CLE PIPE 10', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1649, 1, NULL, 'CISEAU A BOIS PIGEON 14', NULL, NULL, 10, 0, '35.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1650, 1, NULL, 'WOOD CHISEL*MEBRA MOMTAZ*', NULL, NULL, 10, 0, '30.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1651, 1, NULL, 'PERCEUSE 2EME', NULL, NULL, 10, 0, '180.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1652, 1, NULL, 'SIPHON 10*10 P/INOX /COUDE INOX', NULL, NULL, 10, 0, '55.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1653, 1, NULL, 'MOUSTIQUAIRE FER 8 1.20M', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1654, 1, NULL, 'BARRETTE RIDEAU 24/16', NULL, NULL, 10, 0, '12.00', 9, 2, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1655, 1, NULL, 'EQUERRE PLAT JAUNE', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1656, 1, NULL, 'VIS 6X8/6X100', NULL, NULL, 10, 0, '0.50', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1657, 1, NULL, 'CADENAS 55 JAUNE 1ER GMB', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1658, 1, NULL, 'CADENAS 65 JAUNE 1ER GMB/GOWOD', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1659, 1, NULL, 'LAME CUTTER', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1660, 1, NULL, 'FIXATION BOIS PLIABLE', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1661, 1, NULL, 'CYLINDRE ORANGE LINKE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1662, 1, NULL, 'VIS 6X60', NULL, NULL, 10, 0, '0.40', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1663, 1, NULL, 'DISQUE MARBRE 120/220 NOIR', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1664, 1, NULL, 'CLE PLAT CRENEAU   13', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1665, 1, NULL, 'CLE PLAT CRENEAU 17', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1666, 1, NULL, 'LOCTO SOUDEUR', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1667, 1, NULL, 'POIGNEE PORTE PALIERE FER-FORGE', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1668, 1, NULL, 'POIGNEE TIRETTE CHINO', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(1669, 1, NULL, 'POIGNEE TIRETTE COULISSE', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1670, 1, NULL, 'FIXATION MIROIR PLASTIQUE', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1671, 1, NULL, 'SERRURE A TIRETTE AVEC FREIN CARDO', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1672, 1, NULL, 'CYLINDRE BOITE LINKE /MEGGO', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1673, 1, NULL, 'METRE 5M BETTA', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1674, 1, NULL, 'DOUILLE SPOT', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1675, 1, NULL, 'CADENAS SPECIALE 64 CHROME/ 40 CHROME', NULL, NULL, 10, 0, '16.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1676, 1, NULL, 'POIGNEE TIRETTE TIROIR B', NULL, NULL, 10, 0, '5.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1677, 1, NULL, 'POIGNEE TIRETTE TIROIR GM C', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1678, 1, NULL, 'POIGNEE TIRETTE TIROIR D', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1679, 1, NULL, 'POIGNEE BOUTON TIROIR D', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1680, 1, NULL, 'POIGNEE TIRETTE  TIROIR M', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1681, 1, NULL, 'POIGNEE BOUTON TIROIR F', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1682, 1, NULL, 'CLE PLAT CRENEAU  10', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1683, 1, NULL, 'CLE PIPE 17', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1684, 1, NULL, 'MEBRAD', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1685, 1, NULL, 'RALLONGE 50M 4 PRISE ING', NULL, NULL, 10, 0, '480.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1686, 1, NULL, 'TIRE CABLE 30M', NULL, NULL, 10, 0, '130.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1687, 1, NULL, 'PINCE AMPERMETRIQUE MASTECH', NULL, NULL, 10, 0, '140.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1688, 1, NULL, 'SIPHON POUSSOIR 15X15 INOX', NULL, NULL, 10, 0, '70.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1689, 1, NULL, 'RACCORD MELAN 1/2 X 3/4 RELAX', NULL, NULL, 10, 0, '80.00', 7, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1690, 1, NULL, 'MACHINE PPR 20-32', NULL, NULL, 10, 0, '180.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1691, 1, NULL, 'MACHINE PPR 20-63', NULL, NULL, 10, 0, '260.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1692, 1, NULL, 'BEC CUISINE/LAVABO', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1693, 1, NULL, 'ROBINET D ARRET 25 COES', NULL, NULL, 10, 0, '130.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1694, 1, NULL, 'FILASSE', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1695, 1, NULL, 'COUDE 1/8 PPR 20 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1696, 1, NULL, 'COUDE 1/8 PPR 25 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1697, 1, NULL, 'MANCHON 25 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1698, 1, NULL, 'COUDE DOS D ANE 20 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1699, 1, NULL, 'COUDE DOS D ANE 25 COES', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1700, 1, NULL, 'ENDUIT ATLAS POUDRE 25KG', NULL, NULL, 10, 0, '130.00', 5, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1701, 1, NULL, 'CLE A GRIFFE  6/8', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1702, 1, NULL, 'CLE A GRIFFE  10/12 /ORANGE 6/8 8/10', NULL, NULL, 10, 0, '38.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1703, 1, NULL, 'PINCE AMPERMITRIQUE PM 2EME/ TOSUN', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1704, 1, NULL, 'COLLIER 3X200', NULL, NULL, 10, 0, '0.50', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1705, 1, NULL, 'COLLIER 4.8*250/4.8*400', NULL, NULL, 10, 0, '0.50', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1706, 1, NULL, 'LAMPE A LED PROJECTEUR 300W', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1707, 1, NULL, 'LAMPE A LED REFRIGERATEUR', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1708, 1, NULL, 'CROCHET FIL TORSAD', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1709, 1, NULL, 'CHAINE 19', NULL, NULL, 10, 0, '14.00', 3, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1710, 1, NULL, 'CISEAU GAZON PIGEON', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1711, 1, NULL, 'CISEAU GAZON ORANGE', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1712, 1, NULL, 'BINETTE JARDIN', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1713, 1, NULL, 'GRILLAGE FER 1M G', NULL, NULL, 10, 0, '12.00', 3, 2, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1714, 1, NULL, 'PINCE CIRCLIP', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1715, 1, NULL, 'SUPPORT RIDEAUX  MARRON SIMPLE/FACE/COTE', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1716, 1, NULL, 'SUPPORT RIDEAUX JAUNE', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1717, 1, NULL, 'SUPPORT 4 V PS', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1718, 1, NULL, 'CLE PERCEUSE /DOUILLE VISSEUSE 13-10', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1719, 1, NULL, 'CHAUFFE EAU 50L ELECT JUNKER', NULL, NULL, 10, 0, '1300.00', 6, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1720, 1, NULL, 'ACCESSOIRE 6P VERT SALLE DE BAIN', NULL, NULL, 10, 0, '130.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1721, 1, NULL, 'CHIFFON AVEC MANCHE', NULL, NULL, 10, 0, '65.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1722, 1, NULL, 'CHIFFON AVEC MANCHE/VAPORISATEUR', NULL, NULL, 10, 0, '90.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1723, 1, NULL, 'RACLETTE A VITRE AVEC MANCHE', NULL, NULL, 10, 0, '70.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1724, 1, NULL, 'PORTE BALAI MURAL 5', NULL, NULL, 10, 0, '55.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1725, 1, NULL, 'PORTE BALAI MURAL 3', NULL, NULL, 10, 0, '40.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1726, 1, NULL, 'SIPHON 32 2EME', NULL, NULL, 10, 0, '20.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1727, 1, NULL, 'CHAUFFE EAU ELECTRI 30L JUNKERS', NULL, NULL, 10, 0, '1200.00', 6, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1728, 1, NULL, 'PORTE EPONGE /LIQUIDE', NULL, NULL, 10, 0, '16.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1729, 1, NULL, 'SEAU SERPILIERE', NULL, NULL, 10, 0, '130.00', 8, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1730, 1, NULL, 'TRINGLE CRISTAL2M', NULL, NULL, 10, 0, '65.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1731, 1, NULL, 'COIN SALLE D/B GM', NULL, NULL, 10, 0, '130.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1732, 1, NULL, 'LAMPE A LED SPOT 5W', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1733, 1, NULL, 'BOUCHON RIDE MARRO', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1734, 1, NULL, 'TIGE GALVANISE 8', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1735, 1, NULL, 'TIGE GALVANISE 10', NULL, NULL, 10, 0, '11.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1736, 1, NULL, 'TIGE GALVANISE 12', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1737, 1, NULL, 'ITRY LAQUE 5K BLANC', NULL, NULL, 10, 0, '165.00', 5, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1738, 1, NULL, 'DISQUE 180 ATLAS', NULL, NULL, 10, 0, '16.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1739, 1, NULL, 'ITOLAC 15K', NULL, NULL, 10, 0, '440.00', 5, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1740, 1, NULL, 'CLE PLAT CRENEAU (SERRIE 2EME)', NULL, NULL, 10, 0, '4.12', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1741, 1, NULL, 'FILASSE PLATRE', NULL, NULL, 10, 0, '40.00', 9, 5, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1742, 1, NULL, 'FICHE F TELE', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1743, 1, NULL, 'NUMERIQUE REVOLUTION HD 1.1', NULL, NULL, 10, 0, '200.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1744, 1, NULL, 'RECEPTEUR NUMERIQUE HD', NULL, NULL, 10, 0, '150.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1745, 1, NULL, 'NUMERIQUE TABSAT', NULL, NULL, 10, 0, '200.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1746, 1, NULL, 'SUPPORT TELE  D3', NULL, NULL, 10, 0, '120.00', 9, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1747, 1, NULL, 'KIT DOUCHETTE POLYESTER /VARIO', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1748, 1, NULL, 'SIPHON 40 2EME', NULL, NULL, 10, 0, '20.00', 2, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1749, 1, NULL, 'SPOT A LED 3W ENC BLANCHE', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1750, 1, NULL, 'SPOT A LED 6W ENC BLANCHE', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1751, 1, NULL, 'SPOT A LED 12W ENC BLANCHE', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1752, 1, NULL, 'SPOT A LED 18W ENC BLANCHE', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1753, 1, NULL, 'SPOT A LED 18W APPARENT BLANCHE/ encast ZASS', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1754, 1, NULL, 'SPOT A LED 24W APPARENT BLANCHE/20W APPAR', NULL, NULL, 10, 0, '55.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1755, 1, NULL, 'SPOT A LED 30W COB APPARENT BLANCHE', NULL, NULL, 10, 0, '75.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1756, 1, NULL, 'SPOT A LED 30W COB ENCA BLANCHE', NULL, NULL, 10, 0, '70.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1757, 1, NULL, 'LAMPE AVEC CADRE REGLETTE  DOUBLE 54W 120CM', NULL, NULL, 10, 0, '85.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1758, 1, NULL, 'HUBLOT A LED ROND 2  24W', NULL, NULL, 10, 0, '85.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1759, 1, NULL, 'HUBLOT A LED OVALE  15W IP65', NULL, NULL, 10, 0, '85.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1760, 1, NULL, 'TRANSFORMATEUR LED AVEC TELECOMANDE  1ER', NULL, NULL, 10, 0, '110.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1761, 1, NULL, 'DOUILLE E27 B22 SIMPLE', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1762, 1, NULL, 'CLE VIERGE JMA', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1763, 1, NULL, 'CLE VIERGE  JMA MOTO', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1764, 1, NULL, 'PROJECTEUR A LED 100W', NULL, NULL, 10, 0, '170.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1765, 1, NULL, 'ATTACHE 14 LAP', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1766, 1, NULL, 'POIGNEE BOUTON SIMPLE', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1767, 1, NULL, 'MANCHON FF 1/2 TEMME 16', NULL, NULL, 10, 0, '14.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1768, 1, NULL, 'MAMELON MM LONG 1/2 1/2 16 TEMME', NULL, NULL, 10, 0, '22.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1769, 1, NULL, 'TEE F 1/2  TEMME', NULL, NULL, 10, 0, '18.00', 1, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1770, 1, NULL, 'LAMPE SECOUR', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1771, 1, NULL, 'CADENAS CHROME 70', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1772, 1, NULL, 'CADENAS CHROME 80', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:19', '2026-09-15 12:47:19'),
(1773, 1, NULL, 'CADENAS CHROME 90', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1774, 1, NULL, 'EAU VITRE', NULL, NULL, 10, 0, '8.00', 8, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1775, 1, NULL, 'SERRIE TOURNEVIS  PM', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1776, 1, NULL, 'GANT-5.5dh TISSU NOIR FINE/ OURDA', NULL, NULL, 10, 0, '6.00', 8, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1777, 1, NULL, 'CISEAU ARC PM', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1778, 1, NULL, 'NOVAL', NULL, NULL, 10, 0, '45.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1779, 1, NULL, 'TUYAU MACHINE A LAVER 1ER', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1780, 1, NULL, 'TUYAU MACHINE A LAVER 2EME', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1781, 1, NULL, 'TUYAU MACHINE A LAVER SIMPLE BLANC', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1782, 1, NULL, 'TUYAU GONFLEUR', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1783, 1, NULL, 'FLASH WOOD', NULL, NULL, 10, 0, '60.00', 8, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1784, 1, NULL, 'GECLOR PLAQUE', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1785, 1, NULL, 'DECRBOU AB 80', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1786, 1, NULL, 'JOINT COCOT', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1787, 1, NULL, 'COLLIER SERRE PVC 110/50 STOCK VIDE', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1788, 1, NULL, 'RACLETTE  YAKOUTE', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1789, 1, NULL, 'CABLE CAPOTH 2*2.5', NULL, NULL, 10, 0, '6.00', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1790, 1, NULL, 'CABLE SV 4*2.5 ING -NEX', NULL, NULL, 10, 0, '13.00', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1791, 1, NULL, 'EXTRACTEUR PM', NULL, NULL, 10, 0, '100.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1792, 1, NULL, 'ESSENCE COLORADO 4.5L', NULL, NULL, 10, 0, '65.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1793, 1, NULL, 'TEINTE L EAU', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1794, 1, NULL, 'RESSORT PORTE TESA', NULL, NULL, 10, 0, '310.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1795, 1, NULL, 'CABLE RIGIDE 1.5', NULL, NULL, 10, 0, '1.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1796, 1, NULL, 'CABLE RIGIDE 2.5', NULL, NULL, 10, 0, '2.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1797, 1, NULL, 'CABLE  CAPOTH 2*1', NULL, NULL, 10, 0, '2.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1798, 1, NULL, 'MIDILAC 1KG', NULL, NULL, 10, 0, '35.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1799, 1, NULL, 'MIDILAC 1/2KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1800, 1, NULL, 'ENDUIT GOLD FACOP 5KG', NULL, NULL, 10, 0, '65.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1801, 1, NULL, 'DILUANT TAOUSS 3/4', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1802, 1, NULL, 'ESSENCE  TAOUSS /SODESCO 3/4', NULL, NULL, 10, 0, '13.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1803, 1, NULL, 'POIGNEE BOUTON BB', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1804, 1, NULL, 'POIGNEE TIRETTE TIROIR MN', NULL, NULL, 10, 0, '8.50', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1805, 1, NULL, 'KHAYAL BLANC ATLAS', NULL, NULL, 10, 0, '320.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1806, 1, NULL, 'COLORADO ROSE MAMOUNIA 30KG', NULL, NULL, 10, 0, '490.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1807, 1, NULL, 'L EAUX DE BATTERIE 1L', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1808, 1, NULL, 'L EAUX D ANTIGEL 1L', NULL, NULL, 10, 0, '6.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1809, 1, NULL, 'DILUANT 3/4 SODISCO', NULL, NULL, 10, 0, '16.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1810, 1, NULL, 'VISION DE PORTE PM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1811, 1, NULL, 'VIS POIGNEE', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1812, 1, NULL, 'COUTEAU CARRLAGE 1ER', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1813, 1, NULL, 'COUTEAU CARRLAGE 2EME', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1814, 1, NULL, 'CABLE WIFI  4F', NULL, NULL, 10, 0, '4.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1815, 1, NULL, 'TENAILLE ATLAS / STAM', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1816, 1, NULL, 'TUBE ORANGE 13 ING', NULL, NULL, 10, 0, '2.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1817, 1, NULL, 'TUBE ORANGE 16 ING', NULL, NULL, 10, 0, '3.20', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1818, 1, NULL, 'ENDUIT ARCOL PATE 25KG', NULL, NULL, 10, 0, '125.00', 5, 5, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1819, 1, NULL, 'SiPHON 7/7 CHROME', NULL, NULL, 10, 0, '17.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1820, 1, NULL, 'GROUPE SECURITE CHAUFFE EAU ELECTRICI', NULL, NULL, 10, 0, '30.00', 6, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1821, 1, NULL, 'RESISTANCE  CHAUFFE EAU ELECTRIC', NULL, NULL, 10, 0, '80.00', 6, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1822, 1, NULL, 'SIPHON 40 SANS BANDE', NULL, NULL, 10, 0, '18.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1823, 1, NULL, 'SIPHON 40 GRANDE BANDE GM', NULL, NULL, 10, 0, '60.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1824, 1, NULL, 'POIGNEE MARRON KUPA/ISTAMBUL', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1825, 1, NULL, 'SIPHON 10/10 COUDE MADRID', NULL, NULL, 10, 0, '35.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1826, 1, NULL, 'ENSEMBLE ACCESSOIRE SALLE DE BAIN 7PCS CERAMIQUE', NULL, NULL, 10, 0, '180.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1827, 1, NULL, 'MANCHON MF 1/2 GM LAITON', NULL, NULL, 10, 0, '16.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1828, 1, NULL, 'MIDILAC 5KG', NULL, NULL, 10, 0, '155.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1829, 1, NULL, 'LAME SAUTEUSE 1ER', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1830, 1, NULL, 'ECHELLE ALUMINIUM 5 /4+1NOIR/4+1ROUGE/4+1 ECO BLEU', NULL, NULL, 10, 0, '250.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1831, 1, NULL, 'ECHELLE ALUMINIUM 6/ 5 acier color', NULL, NULL, 10, 0, '300.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1832, 1, NULL, 'CACHE VIS PLASTIQUE BLANC', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1833, 1, NULL, 'DISQUE PLASTIQUE PONCEUSE', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1834, 1, NULL, 'BAVETTE BLANC', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1835, 1, NULL, 'MASQUE GRIS 2EME', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1836, 1, NULL, 'MASQUE GRIS 1ER', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1837, 1, NULL, 'BOUCHON M 1/2 NOIR', NULL, NULL, 10, 0, '2.50', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1838, 1, NULL, 'RIDEAU  DOUCHE 1.80X1.80', NULL, NULL, 10, 0, '60.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1839, 1, NULL, 'COLLIER SELLE 110X50', NULL, NULL, 10, 0, '8.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1840, 1, NULL, 'CYLINDRE DE SERRURE 8 CLES  QARO', NULL, NULL, 10, 0, '140.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1841, 1, NULL, 'MASTIQUE', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1842, 1, NULL, 'SUPPORT VETEMENT 5 INOX', NULL, NULL, 10, 0, '33.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1843, 1, NULL, 'SONNETTE SR', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1844, 1, NULL, 'MINUTERIE DESCALIER HAJAR', NULL, NULL, 10, 0, '185.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1845, 1, NULL, 'INTER DE FIL SOUPLE 5005', NULL, NULL, 10, 0, '6.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1846, 1, NULL, 'TUBE ORANGE Q21 ING', NULL, NULL, 10, 0, '4.90', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1847, 1, NULL, 'INTER OPTIMO', NULL, NULL, 10, 0, '9.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1848, 1, NULL, 'PRISE SIMPLE  OPTIMO', NULL, NULL, 10, 0, '9.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1849, 1, NULL, 'PRISE  T  OPTIMO', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1850, 1, NULL, 'TEINTE HUILE', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1851, 1, NULL, 'APPRET SODECSO', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1852, 1, NULL, 'TRINGLE 28 DORE', NULL, NULL, 10, 0, '20.00', 9, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1853, 1, NULL, 'TESTEUR DINGQ', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1854, 1, NULL, 'TESTEUR ERGO/DANI', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1855, 1, NULL, 'PERCEUSE MAKUTE 12V', NULL, NULL, 10, 0, '600.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1856, 1, NULL, 'PERCEUSE MAKUTE 16V', NULL, NULL, 10, 0, '700.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1857, 1, NULL, 'TOURNEVIS KRIT 1ER', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1858, 1, NULL, 'GRATTOIR PEINTURE ROUGE/NOIR123', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1859, 1, NULL, 'PISTOLET  PEINTURE GONFLEUR', NULL, NULL, 10, 0, '300.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1860, 1, NULL, 'CLE PIPE 22', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1861, 1, NULL, 'BURIN HILTI', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1862, 1, NULL, 'SERRURE A CYLINDRE GMB/ VERONA/BACO BORAQ ZETE/KILIT', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1863, 1, NULL, 'SERRURE A CYLINDRE CASTRE KONOF/DALAS', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1864, 1, NULL, 'PINCE RIVET 1ER', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1865, 1, NULL, 'MOULE 115 PM/ KEMAX/MAKITA850W', NULL, NULL, 10, 0, '400.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1866, 1, NULL, 'TIGE FILETEE 5MM', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1867, 1, NULL, 'ECROU 12 ecrou 10 electric', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1868, 1, NULL, 'VIS TIRE-FOND 6MMX60', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1869, 1, NULL, 'VIS PARKER 6.3/38', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1870, 1, NULL, 'VIS PARKER 6.3/50', NULL, NULL, 10, 0, '1.20', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1871, 1, NULL, 'VIS ECROU 5X60', NULL, NULL, 10, 0, '0.75', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1872, 1, NULL, 'CABLE WIFI 7P', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1873, 1, NULL, 'CABLE WIFI 2P', NULL, NULL, 10, 0, '2.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1874, 1, NULL, 'CREMONA S', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1875, 1, NULL, 'EVIER INOX 50X90', NULL, NULL, 10, 0, '400.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1876, 1, NULL, 'RACCORD M 16 3/4 TEMME', NULL, NULL, 10, 0, '33.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1877, 1, NULL, 'RACCORD F16 3/4 TEMME', NULL, NULL, 10, 0, '33.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1878, 1, NULL, 'COUDE APPLIQUE F 16 1/2 TEMME', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1879, 1, NULL, 'COUDE F 16 3/4 TEMME', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1880, 1, NULL, 'COUDE  F 16 3/4 TEMME', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1881, 1, NULL, 'VANNE COMPTEUR  MF  3/4 TEMME', NULL, NULL, 10, 0, '100.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1882, 1, NULL, 'COLLECTEUR 2 VANNE  TEMME', NULL, NULL, 10, 0, '150.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1883, 1, NULL, 'TUBE RETUBE ALUMINIUM 16 TEMME', NULL, NULL, 10, 0, '10.00', 1, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1884, 1, NULL, 'SIPHON 10X40 CANIVEAU RELAX', NULL, NULL, 10, 0, '230.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1885, 1, NULL, 'ROBINET FLOTEUR RIVER/GHOEN/SANILI 0011', NULL, NULL, 10, 0, '55.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1886, 1, NULL, 'ROBINET FLOTEUR TETE DROIT 2EME', NULL, NULL, 10, 0, '25.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1887, 1, NULL, 'ROBINET FLOTEUR COTE RELAX', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1888, 1, NULL, 'SPOT PANEL COLOR 3W +3W', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1889, 1, NULL, 'FIL LED COULEUR DOUBLE RJB', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1890, 1, NULL, 'LAMPE A LED 40W', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1891, 1, NULL, 'LAMPE A LED 50W', NULL, NULL, 10, 0, '60.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1892, 1, NULL, 'LAMPE A LED 60W', NULL, NULL, 10, 0, '70.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1893, 1, NULL, 'SPOT LED PANEL PLAT 75W TOPAGE', NULL, NULL, 10, 0, '100.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1894, 1, NULL, 'CABLE S 2*0.75 SIMPLE', NULL, NULL, 10, 0, '2.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1895, 1, NULL, 'CABLE S 2*1.5  SIMPLE', NULL, NULL, 10, 0, '3.50', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1896, 1, NULL, 'CABLE S 2*2.5  SIMPLE', NULL, NULL, 10, 0, '5.50', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1897, 1, NULL, 'SU¨PRAFLEX VINYL 10K', NULL, NULL, 10, 0, '80.00', 5, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1898, 1, NULL, 'POUSSOIR  ROND LAP', NULL, NULL, 10, 0, '32.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1899, 1, NULL, 'PRISE TELEPHON GALAXY LAP', NULL, NULL, 10, 0, '42.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1900, 1, NULL, 'CADRE DECO 2P GALAXY', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1901, 1, NULL, 'CADRE DECO 3P GALAXY', NULL, NULL, 10, 0, '13.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1902, 1, NULL, 'CADRE DECO 4P GALAXY', NULL, NULL, 10, 0, '18.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1903, 1, NULL, 'BORNE CABLE 35', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1904, 1, NULL, 'PRISE TELEPHONE TICHKA', NULL, NULL, 10, 0, '22.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1905, 1, NULL, 'COMPTEUR 2F', NULL, NULL, 10, 0, '130.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1906, 1, NULL, 'BARRETTE 12M 2EME', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1907, 1, NULL, 'DISJ 1*16 SIMPLE', NULL, NULL, 10, 0, '9.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1908, 1, NULL, 'ANTI RUST GM', NULL, NULL, 10, 0, '28.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1909, 1, NULL, 'DEGRIPPANT PM', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1910, 1, NULL, 'CONSOLE BLANC REGLABLE', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1911, 1, NULL, 'SCOTCH DOUBLE FACE EPAIS', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1912, 1, NULL, 'INTERRUPTEUR RALLONGE', NULL, NULL, 10, 0, '6.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1913, 1, NULL, 'GILET', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1914, 1, NULL, 'RONDELLE CLE', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1915, 1, NULL, 'GRANITEUSE', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1916, 1, NULL, 'PAUMELLE 14 NOIR', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1917, 1, NULL, 'PAUMELLE 11 NOIR', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1918, 1, NULL, 'VISION DE  PORTE GM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1919, 1, NULL, 'TRINGLE 28 MARRON', NULL, NULL, 10, 0, '45.00', 3, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1920, 1, NULL, 'FIXATION BOIS PLIABLE 2EME', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1921, 1, NULL, 'VANNE D ARRET 3/4 TIEMME', NULL, NULL, 10, 0, '100.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1922, 1, NULL, 'PINCE TABLEAU 2P', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1923, 1, NULL, 'CHAUFFE EAU THERMO TEC 30L', NULL, NULL, 10, 0, '850.00', 6, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1924, 1, NULL, 'CABLE S 2.1.5 SIMPLE', NULL, NULL, 10, 0, '3.50', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1925, 1, NULL, 'GRILLE SIPHON GM', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1926, 1, NULL, 'MECANISME POUSSOIR SEMA', NULL, NULL, 10, 0, '80.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1927, 1, NULL, 'SIFFLET COCOTTE  EXPRESSE', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1928, 1, NULL, 'MASQUE DE SECURITE', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1929, 1, NULL, 'TUYAU MACHINE A LAVER 3M', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1930, 1, NULL, 'TUBE FLEXIBLE 9', NULL, NULL, 10, 0, '1.40', 4, 2, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1931, 1, NULL, 'LAME DE CUTTER', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1932, 1, NULL, 'CUTTER AVEC CHANGE SIMPLE', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1933, 1, NULL, 'RACLETTE A VITRE AVEC MANCHE', NULL, NULL, 10, 0, '70.00', 8, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1934, 1, NULL, 'ADAPTATEUR FICHE 2P ENGLZ', NULL, NULL, 10, 0, '17.00', 4, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1935, 1, NULL, 'ANTENNE TV INOX', NULL, NULL, 10, 0, '80.00', 9, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1936, 1, NULL, 'BAVETTE SIMPLE', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1937, 1, NULL, 'MELANGEUR CUISINE JP', NULL, NULL, 10, 0, '150.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1938, 1, NULL, 'MELANGEUR LAVABO JP', NULL, NULL, 10, 0, '150.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1939, 1, NULL, 'ROBINET BEC JP', NULL, NULL, 10, 0, '75.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1940, 1, NULL, 'ROBINET LAVABO JP', NULL, NULL, 10, 0, '80.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1941, 1, NULL, 'KIT DOUCHETTE OPP', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1942, 1, NULL, 'TUBE RETUBE ALUMINIUM 16 SIMPLE', NULL, NULL, 10, 0, '4.50', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1943, 1, NULL, 'FLEXIBLE MACHINE A LAVER SIMPLE GRIS', NULL, NULL, 10, 0, '25.00', 7, 5, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1944, 1, NULL, 'RACCORD EGALE 25X25', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1945, 1, NULL, 'RACCORD F 25X3/4', NULL, NULL, 10, 0, '28.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1946, 1, NULL, 'RACCORD M 25X3/4', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1947, 1, NULL, 'DOUCHETTE REGLAG CHROME', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1948, 1, NULL, 'ENSEMBLE PLAS COL MIR SDB', NULL, NULL, 10, 0, '70.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1949, 1, NULL, 'DOUCHETTE TAHARA 1ER', NULL, NULL, 10, 0, '110.00', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1950, 1, NULL, 'PORTE SERVIETTE STANLEST', NULL, NULL, 10, 0, '65.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1951, 1, NULL, 'PORTE SERVIETTE ANNEAU STANLEST', NULL, NULL, 10, 0, '55.00', 2, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1952, 1, NULL, 'JOINT CONIK 1 1/4 32', NULL, NULL, 10, 0, '0.50', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1953, 1, NULL, 'JOINT CONIK 1 1/2 40', NULL, NULL, 10, 0, '0.50', 7, 1, '2026-09-15 12:47:20', '2026-09-15 12:47:20'),
(1954, 1, NULL, 'LEADER LAC 5KG', NULL, NULL, 10, 0, '220.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1955, 1, NULL, 'FICHE TRIPLETE 3X2  T /INGEL', NULL, NULL, 10, 0, '22.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1956, 1, NULL, 'BORNE DE CONN 25', NULL, NULL, 10, 0, '8.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1957, 1, NULL, 'CONSOLE NOIR FER FORGE 35', NULL, NULL, 10, 0, '15.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1958, 1, NULL, 'CONSOLE NOIR FER FORGE 25/30', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1959, 1, NULL, 'SUPPORT TELE N001/D4', NULL, NULL, 10, 0, '75.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1960, 1, NULL, 'CABLE TV NOIR 1ER', NULL, NULL, 10, 0, '2.00', 9, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1961, 1, NULL, 'SUPPORT TETE A400', NULL, NULL, 10, 0, '160.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1962, 1, NULL, 'FICHE CONNECTEUR HD 1.5M', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1963, 1, NULL, 'ATTACHE 5MM LAP', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1964, 1, NULL, 'DISQUE MARBRE 115', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1965, 1, NULL, 'RALLONGE SORTIE ROBINET', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1966, 1, NULL, 'SAC POUBELLE', NULL, NULL, 10, 0, '22.00', 8, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1967, 1, NULL, 'SUPPORT REFRIGERATEUR', NULL, NULL, 10, 0, '130.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1968, 1, NULL, 'COLLE FLAMBO 5KG', NULL, NULL, 10, 0, '140.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1969, 1, NULL, 'PERCEUSE GSB BOSCH', NULL, NULL, 10, 0, '430.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1970, 1, NULL, 'BOITE A OUTILS P////// PLASSTIQ PM', NULL, NULL, 10, 0, '110.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1971, 1, NULL, 'BOITE A OUTILS G/n16//// PLASTIQUE MM', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1972, 1, NULL, 'ABATTANT SAGA', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1973, 1, NULL, 'PORTE SERVIETTE ABP', NULL, NULL, 10, 0, '13.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1974, 1, NULL, 'TABLETTE   TIROIRE BLANC', NULL, NULL, 10, 0, '15.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1975, 1, NULL, 'CYLINDRE DE SERRURE BOITE', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1976, 1, NULL, 'CYLINDRE DE SERRURE ZETE/BOITE ANKARA/GARYCLE', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1977, 1, NULL, 'SUPPORT TABLEAU PM', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1978, 1, NULL, 'EMBRASSE RIDEAU CRISTAL 1P', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1979, 1, NULL, 'MASSETTE MENUISERIE 1ER', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1980, 1, NULL, 'CONSOLE NOIR FER FORGER 15', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1981, 1, NULL, 'CONSOLE NOIR FER FORGER 20', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1982, 1, NULL, 'POIGNEE CHROME 75 FER FORGER 20', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1983, 1, NULL, 'CLE 27/24 1ER', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1984, 1, NULL, 'MECHE 10 INOX 1ER', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1985, 1, NULL, 'CLE A GRIFFE 14 EPICA', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1986, 1, NULL, 'CLE PIPE 7', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1987, 1, NULL, 'CLE PIPE 8', NULL, NULL, 10, 0, '16.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1988, 1, NULL, 'POIGNEE PALIERE MOTIF', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1989, 1, NULL, 'DISQUE 300 SAIT', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1990, 1, NULL, 'CHAINE 15', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1991, 1, NULL, 'DISQUE TRONCONNEUSE 300 2EME', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1992, 1, NULL, 'TOURNEVIS IPICA', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1993, 1, NULL, 'TOURNEVIS DANI', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1994, 1, NULL, 'TOURNEVIS KRIT PM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1995, 1, NULL, 'PINCE DANI/KRIT/WHITEFOX', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1996, 1, NULL, 'PERCEUSE DANI', NULL, NULL, 10, 0, '240.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1997, 1, NULL, 'PERCEUSE MAKUTE', NULL, NULL, 10, 0, '340.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1998, 1, NULL, 'PERCEUSE MAKUTE', NULL, NULL, 10, 0, '340.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(1999, 1, NULL, 'RROULETTE 50M', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2000, 1, NULL, 'SERRURE A TIRETTE ROND 1ER', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2001, 1, NULL, 'BROSSE FER AVEC MANCHE', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2002, 1, NULL, 'MOULE DANI 115 GM/ PG/PIGEON', NULL, NULL, 10, 0, '240.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2003, 1, NULL, 'MECHE PLATRE GM', NULL, NULL, 10, 0, '95.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2004, 1, NULL, 'SOUDEUR KAWIA PLEINE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2005, 1, NULL, 'GOLASE SPAYER 16L', NULL, NULL, 10, 0, '250.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2006, 1, NULL, 'SIPHON TROPLAN 40', NULL, NULL, 10, 0, '45.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2007, 1, NULL, 'BOITE A OUTILLAGE METALIQUE v/// PLASTIQ GM', NULL, NULL, 10, 0, '150.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2008, 1, NULL, 'GELATINE VERSICOLOR 25 3EME', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2009, 1, NULL, 'CABLE ARME 4X10', NULL, NULL, 10, 0, '55.00', 4, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2010, 1, NULL, 'COLLIER PM 3.6X150', NULL, NULL, 10, 0, '0.50', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2011, 1, NULL, 'FICHE CONNECTEUR HD 0.90 CM', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2012, 1, NULL, 'COUDE M 20 3/4 RETUBE', NULL, NULL, 10, 0, '25.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2013, 1, NULL, 'MITIGEUR LAVABO ROBIMED', NULL, NULL, 10, 0, '250.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2014, 1, NULL, 'MITIGEUR CUISINE MURAL ROBIMED', NULL, NULL, 10, 0, '370.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2015, 1, NULL, 'GROUPE SECURITE CHAUFFE EAU ELECTRIC LAITON', NULL, NULL, 10, 0, '60.00', 6, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2016, 1, NULL, 'BOUCHON A SOUDER 20COES', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2017, 1, NULL, 'BOUCHON A SOUDER 25COES', NULL, NULL, 10, 0, '6.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2018, 1, NULL, 'COLLIER PPR 20 VERT', NULL, NULL, 10, 0, '1.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2019, 1, NULL, 'COLLIER PPR 25 VERT', NULL, NULL, 10, 0, '1.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2020, 1, NULL, 'COUDE M 20X3/4 RETUBE', NULL, NULL, 10, 0, '22.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2021, 1, NULL, 'RALLONGE 5M  BOUTON ING', NULL, NULL, 10, 0, '80.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2022, 1, NULL, 'TRANSFORMATEUR CABLE TELECOMMANDE LED RJB 2EME', NULL, NULL, 10, 0, '60.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2023, 1, NULL, 'TRANSFORMATEUR CABLE TELECOMMANDE LED RJB 1ER', NULL, NULL, 10, 0, '75.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2024, 1, NULL, 'FIL LED RJB', NULL, NULL, 10, 0, '20.00', 4, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2025, 1, NULL, 'CADRE SPOT 3 3', NULL, NULL, 10, 0, '28.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2026, 1, NULL, 'ALCOOL 1/4', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2027, 1, NULL, 'VERNIS FAYROUZ', NULL, NULL, 10, 0, '85.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2028, 1, NULL, 'TETE ROBINET 3/4 JAUNE', NULL, NULL, 10, 0, '22.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2029, 1, NULL, 'ROBINET JARDIN 1/2 3/4 RIVER', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2030, 1, NULL, 'SIPHON 10X10 CHROME SANIA AVEC FREIN', NULL, NULL, 10, 0, '20.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2031, 1, NULL, 'SIPHON 10X10 CHROME SANIA', NULL, NULL, 10, 0, '18.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2032, 1, NULL, 'TEE F 20 3/4', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2033, 1, NULL, 'TEE F 20 3/4', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2034, 1, NULL, 'RACCORD MIX F 1/2 TEMME', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2035, 1, NULL, 'COUDE FLEXIBLE WC 55', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2036, 1, NULL, 'BOUCHON RIDEAU JAUNE', NULL, NULL, 10, 0, '7.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2037, 1, NULL, 'VAPORISATEUR/ BOUTEILLE REGLAGE', NULL, NULL, 10, 0, '25.00', 8, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2038, 1, NULL, 'PORTE MANTEAU', NULL, NULL, 10, 0, '20.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2039, 1, NULL, 'TENAILLE BLOTTA 2EME', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2040, 1, NULL, 'TRANSFORMATEUR FIL LED SIMPLE', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2041, 1, NULL, 'POUDRE MOUCHE', NULL, NULL, 10, 0, '3.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2042, 1, NULL, 'BAIGON', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2043, 1, NULL, 'SIPHON 10X10 COUVERCLE PLASTIQUE SOCOP', NULL, NULL, 10, 0, '30.00', 2, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2044, 1, NULL, 'ECOVINYL 1KG', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2045, 1, NULL, 'ECOVINYL 10KG', NULL, NULL, 10, 0, '75.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2046, 1, NULL, 'ECOVINYL 5KG', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2047, 1, NULL, 'BARRETTE 1001 6 ING', NULL, NULL, 10, 0, '9.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2048, 1, NULL, 'CABLE 29 T CUIVRE', NULL, NULL, 10, 0, '35.00', 4, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2049, 1, NULL, 'CABLE S 4*6', NULL, NULL, 10, 0, '35.00', 4, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2050, 1, NULL, 'DISJ.4P 63 ING', NULL, NULL, 10, 0, '115.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2051, 1, NULL, 'VARIATEUR GX MARRON', NULL, NULL, 10, 0, '150.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2052, 1, NULL, 'CHANTE DE CABLE', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2053, 1, NULL, 'VERNIS PARQUET', NULL, NULL, 10, 0, '120.00', 5, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2054, 1, NULL, 'CATALYSEUR VERNIS PARQUET', NULL, NULL, 10, 0, '80.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2055, 1, NULL, 'DISQUE VIBREUR 60', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2056, 1, NULL, 'SERRURE ENCASTREE', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2057, 1, NULL, 'POIGNEE PORTE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2058, 1, NULL, 'MITIGEUR DOUCHE GALAXY GF8804', NULL, NULL, 10, 0, '270.00', 7, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2059, 1, NULL, 'CLOU TAPISSIER NOIR', NULL, NULL, 10, 0, '0.20', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2060, 1, NULL, 'DISQUE GRANETTE 180', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2061, 1, NULL, 'TELERUPTEUR HAJAR', NULL, NULL, 10, 0, '90.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2062, 1, NULL, 'CORDEX', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2063, 1, NULL, 'PRISE BALANCOIRE', NULL, NULL, 10, 0, '16.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2064, 1, NULL, 'POIGNEE TIRETTE CIGARE 1', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2065, 1, NULL, 'POIGNEE TIRETTE CIGARE 2', NULL, NULL, 10, 0, '9.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2066, 1, NULL, 'POIGNEE TIRETTE CIGARE 3', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2067, 1, NULL, 'ENTRE BOITE A LETTRES', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2068, 1, NULL, 'PIL ROND 12V', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2069, 1, NULL, 'CHARNIER 1.5', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2070, 1, NULL, 'CHARNIER 3', NULL, NULL, 10, 0, '2.50', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2071, 1, NULL, 'COLLIER 16/26', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2072, 1, NULL, 'PISTOLET SILICON DANI', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2073, 1, NULL, 'HILTI 1900W', NULL, NULL, 10, 0, '1000.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2074, 1, NULL, 'TITAN ORO DOREE 250G', NULL, NULL, 10, 0, '85.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2075, 1, NULL, 'VINYLE NOIR /JAUNE/BLEU 1KG', NULL, NULL, 10, 0, '25.00', 5, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2076, 1, NULL, 'MIDILAC 15KG', NULL, NULL, 10, 0, '500.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2077, 1, NULL, 'ARGANA VIVACOLOR 2.5KG', NULL, NULL, 10, 0, '300.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2078, 1, NULL, 'HILTI BOCH', NULL, NULL, 10, 0, '1300.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2079, 1, NULL, 'PRODUIT YUKI INSECTES', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2080, 1, NULL, 'OUTIL DECORA PEINTURE', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2081, 1, NULL, 'DETECTEUR APPARENT', NULL, NULL, 10, 0, '95.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2082, 1, NULL, 'DETECTEUR ENCASTRE', NULL, NULL, 10, 0, '110.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2083, 1, NULL, 'APPRET MIDI 5KG', NULL, NULL, 10, 0, '130.00', 5, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2084, 1, NULL, 'NIVEAU D EAU ALUMINIUM 50', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(2085, 1, NULL, 'FICHE 2P INGLIZ 2EME', NULL, NULL, 10, 0, '7.00', 4, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2086, 1, NULL, 'MITIGEUR LAVABO GALAXY G07701', NULL, NULL, 10, 0, '250.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2087, 1, NULL, 'MITIGEUR DOUCHE GALAXY GF8804', NULL, NULL, 10, 0, '280.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2088, 1, NULL, 'MITIGEUR BAIGNOIRE GALAXY GO7703', NULL, NULL, 10, 0, '320.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2089, 1, NULL, 'MITIGEUR CUININE GALAXY GO7708', NULL, NULL, 10, 0, '290.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2090, 1, NULL, 'MECHE 3 INOX', NULL, NULL, 10, 0, '3.50', 3, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2091, 1, NULL, 'CYLINDRE DE SERRURE VERT LINKE/osqar', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2092, 1, NULL, 'BOITE A OUTIL NOIR', NULL, NULL, 10, 0, '107.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2093, 1, NULL, 'RATEAU JARDIN', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2094, 1, NULL, 'TETE ROBINRT 1/2 JAUNE MTR', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2095, 1, NULL, 'DILUANT 2L SODISCO', NULL, NULL, 10, 0, '39.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2096, 1, NULL, 'SERRURE A CYLINDRE  7 CM SIMA/TURKET 5CLS 6.5CM/RBT', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2097, 1, NULL, 'ROBINET EQUERRE 1/2X3/8 TEMME', NULL, NULL, 10, 0, '45.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2098, 1, NULL, 'MIDINYLE 1KG', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2099, 1, NULL, 'CULOTTE COIN PVC 125', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2100, 1, NULL, 'CISEAU PPR PM', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2101, 1, NULL, 'CISEAU PPR GM', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2102, 1, NULL, 'COLLECTEUR 3 VANNE MTR', NULL, NULL, 10, 0, '95.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2103, 1, NULL, 'COLLECTEUR 4 VANNE MTR', NULL, NULL, 10, 0, '120.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2104, 1, NULL, 'COLLECTEUR 2 VANNE MTR', NULL, NULL, 10, 0, '75.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2105, 1, NULL, 'ROULEAU PLASTIQUE BLANC 2M EPAIS', NULL, NULL, 10, 0, '17.00', 9, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2106, 1, NULL, 'COUDE PVC 125', NULL, NULL, 10, 0, '22.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2107, 1, NULL, 'TEE PVC 90*125', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2108, 1, NULL, 'CULOTTE PVC 45*125', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2109, 1, NULL, 'TETE DOUCHETTE ROND GM', NULL, NULL, 10, 0, '55.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2110, 1, NULL, 'BOUCHON LEVIER', NULL, NULL, 10, 0, '14.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2111, 1, NULL, 'PELLE 29', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2112, 1, NULL, 'PIOCHE MOMTAZE', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2113, 1, NULL, 'RATEAU BALAI', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2114, 1, NULL, 'RATEAU ROUGE', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2115, 1, NULL, 'CHALUMEAU ZEFT', NULL, NULL, 10, 0, '150.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2116, 1, NULL, 'MMMM HILTI', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2117, 1, NULL, 'CONSOLE CHROME 1ER', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2118, 1, NULL, 'FIXATION MEUBLE 2EME', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2119, 1, NULL, 'EMBRASSE RIDEAU CHROME', NULL, NULL, 10, 0, '16.00', 9, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2120, 1, NULL, 'NIVEAU D EAU ALUMINIUM 60', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2121, 1, NULL, 'NIVEAU D EAU ALUMINIUM 40', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2122, 1, NULL, 'POIGNEE TIRETTE 160', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2123, 1, NULL, 'POIGNEE TIRETTE 192', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2124, 1, NULL, 'SERRURE BARRETTE 70 CHROME', NULL, NULL, 10, 0, '28.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2125, 1, NULL, 'COLLE ARABIA', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2126, 1, NULL, 'BEC CUISINE FLEXIBLE', NULL, NULL, 10, 0, '60.00', 7, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2127, 1, NULL, 'CHARNIERE 421', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2128, 1, NULL, 'MECHE CHARNIERE', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2129, 1, NULL, 'COLOFLEX 20KG/LEADERFLEX 20KG', NULL, NULL, 10, 0, '500.00', 5, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2130, 1, NULL, 'COUDE PVC 200', NULL, NULL, 10, 0, '50.00', 1, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2131, 1, NULL, 'CABLE TV NOIR ING', NULL, NULL, 10, 0, '0.00', 4, 2, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2132, 1, NULL, 'ROBINET DARRET 3/4 TEMME', NULL, NULL, 10, 0, '100.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2133, 1, NULL, 'TETE ROBINET 1/2 JAUNE TEMME', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2134, 1, NULL, 'TETE ROBINET 1/2 CHROME TEMME', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2135, 1, NULL, 'ROBINET DOUBLE TEMME', NULL, NULL, 10, 0, '120.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2136, 1, NULL, 'COUDE WC REGLAGE IMERGIE', NULL, NULL, 10, 0, '70.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2137, 1, NULL, 'LALANCE 3/4 PLASTIQUE 4P', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2138, 1, NULL, 'LALANCE 3/4 PLASTIQUE COMPLET 1P', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2139, 1, NULL, 'LALANCE 1/2 CUIVRE1ER TAB', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2140, 1, NULL, 'MITIGEUR CUISINE TABLE LIFE', NULL, NULL, 10, 0, '275.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2141, 1, NULL, 'MITIGEUR CUISINE MUR LIFE/BAIGNOIRE/WEKTS', NULL, NULL, 10, 0, '350.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2142, 1, NULL, 'EXTRACTEUR MM 18X18', NULL, NULL, 10, 0, '100.00', 4, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2143, 1, NULL, 'MACHINE COUPE CARRELAGE/60DNG', NULL, NULL, 10, 0, '380.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2144, 1, NULL, 'MITIGEUR LAVABO 40 BASCO', NULL, NULL, 10, 0, '170.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2145, 1, NULL, 'MITIGEUR DOUCHE 40 BASCO/ OUCHAN', NULL, NULL, 10, 0, '200.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2146, 1, NULL, 'MITIGEUR CUISINE MUR 40 BASCO', NULL, NULL, 10, 0, '200.00', 7, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2147, 1, NULL, 'CLOU (chwika)', NULL, NULL, 10, 0, '25.00', 3, 5, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2148, 1, NULL, 'CISEAU JARDIN GM', NULL, NULL, 10, 0, '90.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2149, 1, NULL, 'SECATEUR JARDIN', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2150, 1, NULL, 'PIED CANAPE ROND 8', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2151, 1, NULL, 'RESSORT PORTE', NULL, NULL, 10, 0, '250.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2152, 1, NULL, 'POIGNEE BOUTON TIROIR CHROME CARRE', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2153, 1, NULL, 'MECHE CHARNIERE 35', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2154, 1, NULL, 'PITON 2*10 PM', NULL, NULL, 10, 0, '0.25', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2155, 1, NULL, 'CROCHET 6X6', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2156, 1, NULL, 'PIECE ETAGERE MIROIR PM', NULL, NULL, 10, 0, '6.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2157, 1, NULL, 'PIECE ETAGERE MIROIR MM', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2158, 1, NULL, 'PINCE COUPANTE PM', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2159, 1, NULL, 'PINCE SOUDURE', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2160, 1, NULL, 'SERRIE CLE PIPE 12P', NULL, NULL, 10, 0, '150.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2161, 1, NULL, 'POIGNEE PORTE BOUTON MARRON', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2162, 1, NULL, 'GRAFEUSE 1ER', NULL, NULL, 10, 0, '200.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2163, 1, NULL, 'MANOMETRE GONFLEUR', NULL, NULL, 10, 0, '110.00', 3, 1, '2026-09-15 12:47:21', '2026-09-15 12:47:21'),
(2164, 1, NULL, 'MANOMETRE GONFLEUR', NULL, NULL, 10, 0, '110.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2165, 1, NULL, 'MECANISME RIDEAU', NULL, NULL, 10, 0, '80.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2166, 1, NULL, 'GAINE RIDEAU', NULL, NULL, 10, 0, '3.00', 9, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2167, 1, NULL, 'SERRURE REFRIGERATEUR', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2168, 1, NULL, 'POIGNEE TIRETTE FER FORGER/ POIGNE FER FORGE 75', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2169, 1, NULL, 'CHAINE MARRON', NULL, NULL, 10, 0, '6.00', 3, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2170, 1, NULL, 'SERRURE BARRETTE CHROME 70', NULL, NULL, 10, 0, '3.00', 3, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2171, 1, NULL, 'CADENAS 65 CHROME', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2172, 1, NULL, 'CADENAS 66 CHROME', NULL, NULL, 10, 0, '27.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2173, 1, NULL, 'SERRURE TIROIR MAN/CARDO/ROBISAN/EV555', NULL, NULL, 10, 0, '22.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2174, 1, NULL, 'SERRURE BARRETTE CHROME P3', NULL, NULL, 10, 0, '3.50', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2175, 1, NULL, 'SERRURE A TIRETTE BACCO/LINKE BLEU', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2176, 1, NULL, 'SERRURE A TIRETTE ROND DRAGON', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2177, 1, NULL, 'PAUMELLE A SOUDER 80', NULL, NULL, 10, 0, '4.50', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2178, 1, NULL, 'PAPOIGNEE TIRETTE CHROME H', NULL, NULL, 10, 0, '17.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2179, 1, NULL, 'FLEXIBLE TAHARA 1.2M 3/8', NULL, NULL, 10, 0, '55.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2180, 1, NULL, 'ELASTIQUE ROND MOTO', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2181, 1, NULL, 'LAMPE LAVABO', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2182, 1, NULL, 'FIXATION MIROIR RESSORT', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2183, 1, NULL, 'PIL TELECOMMANDE 2032', NULL, NULL, 10, 0, '3.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2184, 1, NULL, 'LAMPE FOOTBALL', NULL, NULL, 10, 0, '75.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2185, 1, NULL, 'CHARNIERE  INVISIBLE AVEC FREIN 1ER', NULL, NULL, 10, 0, '14.00', 3, 5, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2186, 1, NULL, 'COF.14MO D4FIL/LAP', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2187, 1, NULL, 'LAMPE A LED 9W SAVIA', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2188, 1, NULL, 'NIVEAU D EAU ROUGE VIS SIMPLE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2189, 1, NULL, 'SCOTCH MM SIGMA', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2190, 1, NULL, 'ESSENCE JUPITER 3/4', NULL, NULL, 10, 0, '12.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2191, 1, NULL, 'TIGE 10 ELECTRIC', NULL, NULL, 10, 0, '15.00', 4, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2192, 1, NULL, 'COLLE BOIS 250G', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2193, 1, NULL, 'COTON', NULL, NULL, 10, 0, '16.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2194, 1, NULL, 'RALLONGE ROND 5M ALTEC', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2195, 1, NULL, 'DISQUE 230 GRANETTE', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2196, 1, NULL, 'LENAS FOUR', NULL, NULL, 10, 0, '10.00', 8, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2197, 1, NULL, 'CLE CROISE 4', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2198, 1, NULL, 'LAMPE A LED FLAMME 5W', NULL, NULL, 10, 0, '12.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2199, 1, NULL, 'PIECE ETAGERE BLANC', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2200, 1, NULL, 'HUBLOT ROND PLASTIQUE LAP', NULL, NULL, 10, 0, '29.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2201, 1, NULL, 'CHEVILLE 14MM LAP', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2202, 1, NULL, 'TIRETTE MELANGEUR', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2203, 1, NULL, 'SIPHON 10X10 inox relax', NULL, NULL, 10, 0, '75.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2204, 1, NULL, 'FLEXIBLE DOUCHE 33/ rossort fishdi/NW360', NULL, NULL, 10, 0, '50.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2205, 1, NULL, 'ROBINET JARDIN 1/2X3/4 RELAX PM', NULL, NULL, 10, 0, '50.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2206, 1, NULL, 'METRE 3M BETTA', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2207, 1, NULL, 'METRE 5M FACOM', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2208, 1, NULL, 'COUPE CARRELAGE 60 AVEC PORTE', NULL, NULL, 10, 0, '650.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2209, 1, NULL, 'COUPE CARRELAGE 60', NULL, NULL, 10, 0, '550.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2210, 1, NULL, 'COUPE CARRLAGE 50', NULL, NULL, 10, 0, '450.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2211, 1, NULL, 'SERRURE A TIRETTE ROND VIRONA/DINGO/KILIT', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2212, 1, NULL, 'LAMPE VENTILATEUR', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2213, 1, NULL, 'TUBE POLY FERROPLAS 16BARRE 20', NULL, NULL, 10, 0, '4.40', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2214, 1, NULL, 'RACCORD F 20X1/2 POLY', NULL, NULL, 10, 0, '6.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2215, 1, NULL, 'TEE F90 20X1/2X20 POLY', NULL, NULL, 10, 0, '8.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2216, 1, NULL, 'MANCHON EGALE 20 POLY', NULL, NULL, 10, 0, '8.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2217, 1, NULL, 'LAVABO ROCA 40', NULL, NULL, 10, 0, '200.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2218, 1, NULL, 'ABATTANT ROCA', NULL, NULL, 10, 0, '120.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2219, 1, NULL, 'CHAUFFE EAU A GAZ 6l VEGA', NULL, NULL, 10, 0, '1300.00', 6, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2220, 1, NULL, 'DISQUE BOIS 230/ 9', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2221, 1, NULL, 'DISQUE BOIS 115 P', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2222, 1, NULL, 'VINYLE 30KG CELLAQUA ASTRAL', NULL, NULL, 10, 0, '520.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2223, 1, NULL, 'ESSENCE FACOP 5L/ARCOL 5L', NULL, NULL, 10, 0, '60.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2224, 1, NULL, 'VERNIS MIDIXIME 1L', NULL, NULL, 10, 0, '30.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2225, 1, NULL, 'MECHE HILTI 12 ERGO', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2226, 1, NULL, 'LAMPE A LED 9W PHILIPS/ttlux', NULL, NULL, 10, 0, '16.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2227, 1, NULL, 'TESTEUR YADET', NULL, NULL, 10, 0, '27.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2228, 1, NULL, 'CHAINE 21', NULL, NULL, 10, 0, '17.00', 3, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2229, 1, NULL, 'SIPHON WC GM ABP', NULL, NULL, 10, 0, '25.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2230, 1, NULL, 'ECHELLE ECO 3 1 ACIER BLEU', NULL, NULL, 10, 0, '180.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2231, 1, NULL, 'TRINGLE RIDEAU NOIR', NULL, NULL, 10, 0, '35.00', 9, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2232, 1, NULL, 'ABATTANT GLISSIER TIROIRE CHROME 50/45', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2233, 1, NULL, 'ARABIA 5KG ARCOL', NULL, NULL, 10, 0, '200.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2234, 1, NULL, 'MECANISME POUSSOIR OLI', NULL, NULL, 10, 0, '95.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2235, 1, NULL, 'VINYLE VERONA 5K', NULL, NULL, 10, 0, '35.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2236, 1, NULL, 'DILUANT ARCOL 5L', NULL, NULL, 10, 0, '70.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2237, 1, NULL, 'ARM POLYSTER 510*400*200', NULL, NULL, 10, 0, '380.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2238, 1, NULL, 'SUPPORT RIDEAUX MARRON FACE GM', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2239, 1, NULL, 'EXTINCTEUR PM', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2240, 1, NULL, 'P DE PANNE', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2241, 1, NULL, 'ARABYA 5KG COULEUR', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2242, 1, NULL, 'ODALAC 5KG ODASSIA', NULL, NULL, 10, 0, '230.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2243, 1, NULL, 'TIGE FENETRE 1.20 maron', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2244, 1, NULL, 'DOUCHETTE TAHARA SIMPLE', NULL, NULL, 10, 0, '35.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2245, 1, NULL, '(poig rgila)', NULL, NULL, 10, 0, '7.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2246, 1, NULL, 'ROBINET SERVICE 1/4 DE TOUR MSA', NULL, NULL, 10, 0, '45.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2247, 1, NULL, 'SCOTCH MM DINGO', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2248, 1, NULL, 'TRANSFORMATEUR SPOT', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2249, 1, NULL, 'MANCHON WC', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2250, 1, NULL, 'CYLINDRE DE SERRURE WC AVEC CLE', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2251, 1, NULL, 'POIGNEE TIRETTE CIGARE 5', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2252, 1, NULL, 'AANRBA COLORADO BLANC 5KG', NULL, NULL, 10, 0, '270.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2253, 1, NULL, 'MIDI VINYL 30KG', NULL, NULL, 10, 0, '400.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2254, 1, NULL, 'MIDI ROSE MAMOUNIA 5KG', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2255, 1, NULL, 'CHIFFON 12', NULL, NULL, 10, 0, '7.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2256, 1, NULL, 'CYLINDRE DE SERRURE WC SIMPLE', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2257, 1, NULL, 'SIPHON 20*20INOX', NULL, NULL, 10, 0, '95.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2258, 1, NULL, 'RALLONGE ROBINET FLEXIBLE', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2259, 1, NULL, 'COFFRE FORT', NULL, NULL, 10, 0, '700.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2260, 1, NULL, 'METRE 3 DYNGO', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2261, 1, NULL, 'SONNETTE NAKOUSS MM', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2262, 1, NULL, 'SONNETTE NAKOUSS GM', NULL, NULL, 10, 0, '70.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2263, 1, NULL, 'CABLE 1*1.5 SIMPLE', NULL, NULL, 10, 0, '2.50', 4, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2264, 1, NULL, 'DISQUE BOIS 180', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2265, 1, NULL, 'LAME SCIE GM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2266, 1, NULL, 'PINCE SOUDEUR', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2267, 1, NULL, 'PEAU DE CHAMEAU 1ER N2', NULL, NULL, 10, 0, '40.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2268, 1, NULL, 'FLEXIBLE VIDANGE MACHINE A LAVE AUTOMATIQUE', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2269, 1, NULL, 'COUPE TUBE GM', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2270, 1, NULL, 'TUYAU JARDIN FLEXIBLE 30M', NULL, NULL, 10, 0, '100.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2271, 1, NULL, 'PORTE SAVON LIQUIDE', NULL, NULL, 10, 0, '75.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2272, 1, NULL, 'SCOTCH GGM NOIR SIMPLE', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2273, 1, NULL, 'PRISE +T JADE ING', NULL, NULL, 10, 0, '18.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2274, 1, NULL, 'DOUBLE VA ET VIENT JADE ING', NULL, NULL, 10, 0, '32.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2275, 1, NULL, 'PRISE TELEPHONE JADE ING', NULL, NULL, 10, 0, '36.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2276, 1, NULL, 'INTERRUPTEUR SIMPLE JADE ING', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2277, 1, NULL, 'PRISE SIMPLE JADE ING', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2278, 1, NULL, 'POUSSOIRE RIDEAUX JADE ING', NULL, NULL, 10, 0, '42.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2279, 1, NULL, 'CLE CHAINE 4', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2280, 1, NULL, 'CADENAS MOTO GM 1.20M', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2281, 1, NULL, 'ROBINET TANG', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2282, 1, NULL, 'PRODUIT MORTINE PM', NULL, NULL, 10, 0, '13.00', 8, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2283, 1, NULL, 'CISEAU A BOIS 2 EME 12', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2284, 1, NULL, 'POIGNEE BEQUILLE CHROME', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2285, 1, NULL, 'POIGNEE BEQUILLE NOIR', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2286, 1, NULL, 'BOITE A MONNAIE 4P', NULL, NULL, 10, 0, '50.14', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2287, 1, NULL, 'BOITE A PHARMACIE', NULL, NULL, 10, 0, '175.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2288, 1, NULL, 'EVIER ENC 52*43 SIPHON', NULL, NULL, 10, 0, '300.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2289, 1, NULL, 'TUBE PVC 100 ABP', NULL, NULL, 10, 0, '30.00', 1, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2290, 1, NULL, 'TUBE PVC 110 ABP', NULL, NULL, 10, 0, '35.00', 1, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2291, 1, NULL, 'POIGNEE TIRETTE CIGARE 4', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2292, 1, NULL, 'SERRURE A CYLINDRE PETIT OVALE', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2293, 1, NULL, 'RESSORT FENETRES ET MEUBLE', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2294, 1, NULL, 'JOINT FENETRES', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2295, 1, NULL, 'ROULETTE 160', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2296, 1, NULL, 'MOUSSE', NULL, NULL, 10, 0, '55.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2297, 1, NULL, 'ELASSTIQUE MOTO 2M', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2298, 1, NULL, 'ACIDE CHLORYDRIQUE 17A 5L', NULL, NULL, 10, 0, '33.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2299, 1, NULL, 'EMBRASSE RIDEAU CRISTAL WENGE', NULL, NULL, 10, 0, '45.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2300, 1, NULL, 'COFFERT RETUBE 50GM ABP', NULL, NULL, 10, 0, '65.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2301, 1, NULL, 'COFFERT RETUBE 40PM ABP', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2302, 1, NULL, 'TUBE PVC 40 ABP', NULL, NULL, 10, 0, '15.00', 1, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2303, 1, NULL, 'ARMOIRE 50/40', NULL, NULL, 10, 0, '390.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2304, 1, NULL, 'TOURNEVIS TL', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2305, 1, NULL, 'TETE 8', NULL, NULL, 10, 0, '200.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2306, 1, NULL, 'SIPHON 30 CANIVEAU RELAX', NULL, NULL, 10, 0, '180.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2307, 1, NULL, 'DOUCHETTE DOUBLE GM', NULL, NULL, 10, 0, '450.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2308, 1, NULL, 'TEFLON MM SIMPLE', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2309, 1, NULL, 'PORTE CLOU MACON', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2310, 1, NULL, 'BOUCHON M.F 3/4 TEMME', NULL, NULL, 10, 0, '18.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2311, 1, NULL, 'TUBE PVC 32 ABP', NULL, NULL, 10, 0, '12.00', 1, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2312, 1, NULL, 'TUBE PVC 50 ABP', NULL, NULL, 10, 0, '18.00', 1, 2, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2313, 1, NULL, 'TUBE PVC 75 ABP', NULL, NULL, 10, 0, '25.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2314, 1, NULL, 'CABLE HDMI 5M', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2315, 1, NULL, 'cache trou', NULL, NULL, 10, 0, '13.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2316, 1, NULL, 'CABLE RVK 1*25 NOIR', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2317, 1, NULL, 'PRODUIT NETTOYAGE TISSU', NULL, NULL, 10, 0, '25.00', 8, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2318, 1, NULL, 'COUDE M 16 3/4 TEMME', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2319, 1, NULL, 'SERRURE TIROIRE SIMPLE', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2320, 1, NULL, 'SERRURE A TIRETTE LINKE BLANC/IZO/UNIMAX 14', NULL, NULL, 10, 0, '95.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2321, 1, NULL, 'SUPPORT RIDEAUX MARRON OVALE', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2322, 1, NULL, 'TENAILLE ORANGE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2323, 1, NULL, 'CLE CHAINE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2324, 1, NULL, 'STOP ODASSIA', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2325, 1, NULL, 'ROBINET FLOTEUR IDRO SPAN', NULL, NULL, 10, 0, '60.00', 1, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2326, 1, NULL, 'SIPHON GORGE 40 CHROME', NULL, NULL, 10, 0, '25.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2327, 1, NULL, 'SICATIF FORT', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2328, 1, NULL, 'ROULEAU PEINTURE BRICO/ COLORADO', NULL, NULL, 10, 0, '55.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2329, 1, NULL, 'SERRURE A TIRETTE SIMPLE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2330, 1, NULL, 'RIDEAU SALLE DE BAIN N2', NULL, NULL, 10, 0, '80.00', 2, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2331, 1, NULL, 'RAPVINYL 5KG', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2332, 1, NULL, 'RAPVINYL 10KG', NULL, NULL, 10, 0, '150.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2333, 1, NULL, 'RAPVINYL 30KG', NULL, NULL, 10, 0, '330.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2334, 1, NULL, 'BOULON AVEC CHEVILLE 10X80', NULL, NULL, 10, 0, '6.00', 3, 5, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2335, 1, NULL, 'BOULON AVEC CHEVILLE 10X100', NULL, NULL, 10, 0, '7.00', 3, 5, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2336, 1, NULL, 'VIS TIRE-FOND 6X100', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2337, 1, NULL, 'BOULON AVEC CHEVILLE 8X90', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2338, 1, NULL, 'BOULON AVEC CHEVILLE 8X120', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2339, 1, NULL, 'BOULON AVEC CHEVILLE 12X80', NULL, NULL, 10, 0, '7.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2340, 1, NULL, 'BOULON AVEC CHEVILLE 12X100', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2341, 1, NULL, 'BOULON AVEC CHEVILLE 16X100', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2342, 1, NULL, 'BOULON AVEC CHEVILLE 12X100', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2343, 1, NULL, 'BOULON AVEC CHEVILLE 12X120', NULL, NULL, 10, 0, '9.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2344, 1, NULL, 'BLOC SECOURE 12V', NULL, NULL, 10, 0, '55.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2345, 1, NULL, 'BOITE ETAN 7424/LAP', NULL, NULL, 10, 0, '28.00', 4, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2346, 1, NULL, 'COLLIER GAZ 32-50', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2347, 1, NULL, 'BROSSE MOULE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2348, 1, NULL, 'TETE DOUCHETTE VESCO', NULL, NULL, 10, 0, '35.00', 7, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2349, 1, NULL, 'CELLAQUA BLANC 10KG', NULL, NULL, 10, 0, '210.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2350, 1, NULL, 'CELLAQUA 5 KG', NULL, NULL, 10, 0, '120.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2351, 1, NULL, 'STOP ASTRAL 1KG', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2352, 1, NULL, 'STOP ASTRAL 1KG', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2353, 1, NULL, 'TUBE SUPER TEINTE ASTRAL', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2354, 1, NULL, 'ENDUIT FINILISS 25KG', NULL, NULL, 10, 0, '130.00', 5, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2355, 1, NULL, 'CYREX', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2356, 1, NULL, 'FROMAGE RAT', NULL, NULL, 10, 0, '8.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2357, 1, NULL, 'MORTEX POIS', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2358, 1, NULL, 'MORTEX SERINGUE', NULL, NULL, 10, 0, '40.00', 9, 1, '2026-09-15 12:47:22', '2026-09-15 12:47:22'),
(2359, 1, NULL, 'MALFOSSE 50', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2360, 1, NULL, 'CLE A MOLETTE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2361, 1, NULL, 'EVIER DOUBLE ROND 90*47', NULL, NULL, 10, 0, '400.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2362, 1, NULL, 'TETE DOUCHETTE G9020', NULL, NULL, 10, 0, '80.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2363, 1, NULL, 'RACCORD COMPTEUR LAITON', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2364, 1, NULL, 'RALLONGE 10CM CHROME SIMPLE', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2365, 1, NULL, 'ROBINET CUISINE TABLE G9054/ AL/222 223', NULL, NULL, 10, 0, '130.00', 7, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2366, 1, NULL, 'ECROU ROBINET JARDIN', NULL, NULL, 10, 0, '6.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2367, 1, NULL, 'CLAPET 1/3', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2368, 1, NULL, 'CLAPET 3/4', NULL, NULL, 10, 0, '35.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2369, 1, NULL, 'BANDE LAVABO POUSSOIR relax', NULL, NULL, 10, 0, '45.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2370, 1, NULL, 'BANDE LAVABO POUSSOIR RIVER', NULL, NULL, 10, 0, '65.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2371, 1, NULL, 'MAMELON 1/2 CHROME', NULL, NULL, 10, 0, '14.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2372, 1, NULL, 'COUDE MF 1/2 CHROME', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2373, 1, NULL, 'COUDE MF 1/2 CHROME', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2374, 1, NULL, 'RALLONGE 7CM CHROME 2EME', NULL, NULL, 10, 0, '15.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2375, 1, NULL, 'PIECES COSSE BATTERIE', NULL, NULL, 10, 0, '20.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2376, 1, NULL, 'MECHE HILTI 14', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2377, 1, NULL, 'SCOTCH DOUBLE FACE SILIC', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2378, 1, NULL, 'RACCORD1/2 SORTIE ROBINETAVEC JOINT', NULL, NULL, 10, 0, '10.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2379, 1, NULL, 'RACCORD3/4 SORTIE ROBINETAVEC JOINT', NULL, NULL, 10, 0, '10.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2380, 1, NULL, 'MIROIRE AVEC ACCESSOIRE', NULL, NULL, 10, 0, '280.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2381, 1, NULL, 'CABLE SOU 3*2.5 CAB STAR', NULL, NULL, 10, 0, '11.00', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2382, 1, NULL, 'FAYROUZ BLANC 20KG', NULL, NULL, 10, 0, '1230.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2383, 1, NULL, 'LAQUE D EAU ATLAS 15KG', NULL, NULL, 10, 0, '575.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2384, 1, NULL, 'ROSE MAMOUNIA ODASSIA 5KG', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2385, 1, NULL, 'STOP MIDI 1KG', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2386, 1, NULL, 'CHAUFFE-EAU ELECTRI MYJY 30L', NULL, NULL, 10, 0, '900.00', 6, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2387, 1, NULL, 'CHAUFFE-EAU ELECTRI MYJY 50L', NULL, NULL, 10, 0, '950.00', 6, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2388, 1, NULL, 'GELATINE SUPER VERSICOLOR 25KG', NULL, NULL, 10, 0, '85.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2389, 1, NULL, 'BOUTEILLE A VAPEUR AVEC PRESSION 2L', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2390, 1, NULL, 'CUTTER EPICA/ERGO', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2391, 1, NULL, 'VERNIS REXIME ATLAS 3L', NULL, NULL, 10, 0, '110.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2392, 1, NULL, 'RECEPTEUR NUMERIQUE INTERNET', NULL, NULL, 10, 0, '210.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2393, 1, NULL, 'LAVE MAIN YVELINE RECTONGULAIRE', NULL, NULL, 10, 0, '170.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2394, 1, NULL, 'TEINTE A LEAU SADVEL', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2395, 1, NULL, 'POIGNEE BEC 1', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2396, 1, NULL, 'TRUELLE LISSEUSE SIMPLE', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2397, 1, NULL, 'TOURNEVIS DOUBLE P', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2398, 1, NULL, 'CADENAS VELO MM', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2399, 1, NULL, 'PIL TELECOMMANDE ROBIST', NULL, NULL, 10, 0, '3.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2400, 1, NULL, 'ATLAS METALE DOREE 1KG', NULL, NULL, 10, 0, '80.00', 5, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2401, 1, NULL, 'VISSEUSE EN BOITE+OUTILLE INCCO', NULL, NULL, 10, 0, '480.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2402, 1, NULL, 'ESSENCE MIDI 5L', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2403, 1, NULL, 'YACOUT MIDI 2K', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2404, 1, NULL, 'ATLAS DOREE 250G', NULL, NULL, 10, 0, '27.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2405, 1, NULL, 'VISSEUSE INCCO', NULL, NULL, 10, 0, '300.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2406, 1, NULL, 'INTERRUPTEUR SIMPLE NOIR/BLANC', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2407, 1, NULL, 'DISQUE INOX 115*22MM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2408, 1, NULL, 'LAMPE A LED 12W RECHARGABLE', NULL, NULL, 10, 0, '38.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2409, 1, NULL, 'TUYAU GAZ N1', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2410, 1, NULL, 'RACLEUR AHRAM PM', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2411, 1, NULL, 'FIL GALVANISE 12', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2412, 1, NULL, 'TRINGLE RIDEAU OVALE', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2413, 1, NULL, 'SCOTCH 3M 5CM', NULL, NULL, 10, 0, '15.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2414, 1, NULL, 'MECHE 12 INOX', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2415, 1, NULL, 'ROBINET CUISIN TABLE 1/4TOUR SUS 304', NULL, NULL, 10, 0, '130.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2416, 1, NULL, 'SIPHON 20*10 CANIVEAU S RELAX', NULL, NULL, 10, 0, '100.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2417, 1, NULL, 'SIPHON 30*10 CANIVEAU S RELAX', NULL, NULL, 10, 0, '120.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2418, 1, NULL, 'PIL 20 TELEFUNKEN 2PAIRE', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2419, 1, NULL, 'ADAPTATEUR AMERICAINE SIMPLE', NULL, NULL, 10, 0, '3.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2420, 1, NULL, 'DOUCHETTE INCASSABLE', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2421, 1, NULL, 'SIPHON 40 GAND BANDE PM', NULL, NULL, 10, 0, '60.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2422, 1, NULL, 'DOUILLE SPOT GU10', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2423, 1, NULL, 'LOCTO SOUDEUR 1', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2424, 1, NULL, 'BOTTE EN CAOUTCHOUC', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2425, 1, NULL, 'HUBLOT A LED SIMPLE', NULL, NULL, 10, 0, '55.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2426, 1, NULL, 'LAMPE A LED 65W', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2427, 1, NULL, 'ROBINET CUI.ROSOL TABLE RELAX', NULL, NULL, 10, 0, '160.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2428, 1, NULL, 'MITIGEUR CUISIN ROSSORT HAWAYSA', NULL, NULL, 10, 0, '1100.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2429, 1, NULL, 'SIPHON 20*20 CHROME RELAX', NULL, NULL, 10, 0, '120.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2430, 1, NULL, 'PINCEAUX ROND PM', NULL, NULL, 10, 0, '6.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2431, 1, NULL, 'INTERRUPTEUR ETANCHE GRIS LAP', NULL, NULL, 10, 0, '32.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2432, 1, NULL, 'PROJECTEUR A LED AVEC TABLET SOLAI 60W', NULL, NULL, 10, 0, '160.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2433, 1, NULL, 'PROJECTEUR A LED AVEC TABLET SOLAI', NULL, NULL, 10, 0, '160.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2434, 1, NULL, 'DOUCHETTE REGLABLE/+FLEX SHOWER', NULL, NULL, 10, 0, '60.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2435, 1, NULL, 'MASSETTE 1KG BOIS', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2436, 1, NULL, 'LAMPE B22 60W ¨PM', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2437, 1, NULL, 'LINAS CARRLAGE', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2438, 1, NULL, 'MIDI PLAST 20KG', NULL, NULL, 10, 0, '395.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2439, 1, NULL, 'MIDI BEIGE TIZNIT 30KG', NULL, NULL, 10, 0, '390.00', 5, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2440, 1, NULL, 'TUBE SINTOFER', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2441, 1, NULL, 'ALCOOL 1L', NULL, NULL, 10, 0, '35.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2442, 1, NULL, 'douille 1/2 melangeur', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2443, 1, NULL, 'COLLE SPECIALE FERRI', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2444, 1, NULL, 'EMBRASSE RIDEAU PAEN', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2445, 1, NULL, 'TESTEUR  MULTIMETRE DINGO 1000V', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2446, 1, NULL, 'SERRURE A TIRETTE SPECIALE LAITON', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2447, 1, NULL, 'GRATTOIR PLATRE INOX', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2448, 1, NULL, 'EMBRASSE RIDEAU PLUME', NULL, NULL, 10, 0, '55.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2449, 1, NULL, 'ECOUTEAU VERRE 2EME', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2450, 1, NULL, 'CRAYON MENUISIER', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2451, 1, NULL, 'SUPPORT RIDEAU 20 ALUM', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2452, 1, NULL, 'HUBLOT LED ENCASTRE 36W ATTA', NULL, NULL, 10, 0, '85.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2453, 1, NULL, 'TUBE PVC  75 SIMPLE', NULL, NULL, 10, 0, '15.00', 1, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2454, 1, NULL, 'LAMPE A LED 30W ING', NULL, NULL, 10, 0, '65.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2455, 1, NULL, 'CHAUFFE EAU SOLAIRE JUNKERS 300L', NULL, NULL, 10, 0, '20000.00', 6, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2456, 1, NULL, 'CABLE AQUA 3*2.5MM', NULL, NULL, 10, 0, '22.00', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2457, 1, NULL, 'CABLE SV1V 4*4 ING', NULL, NULL, 10, 0, '33.00', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2458, 1, NULL, 'TUBE PVC 110 FERROPLASTE 1ER', NULL, NULL, 10, 0, '75.00', 1, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2459, 1, NULL, 'TUBE PVC 100 FERROPLASTE 1ER', NULL, NULL, 10, 0, '65.00', 1, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2460, 1, NULL, 'TUBE PVC 50 FERROPLASTE 1ER', NULL, NULL, 10, 0, '30.00', 1, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2461, 1, NULL, 'TUBE PVC 63 FERROPLASTE PRESSION', NULL, NULL, 10, 0, '56.00', 1, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2462, 1, NULL, 'TUBE RETUBE 25 TEMME', NULL, NULL, 10, 0, '14.00', 1, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2463, 1, NULL, 'REDUCTION 100*50 FERROPLASTE', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2464, 1, NULL, 'COUDE 45 FERROPLAST 100', NULL, NULL, 10, 0, '14.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2465, 1, NULL, 'COUDE 45 FERROPLAST 50', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2466, 1, NULL, 'CULOTTE 45 FERROPLAST 100', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2467, 1, NULL, 'COUDE 90° FERROPLASTE 63 PRESSION', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2468, 1, NULL, 'COFFRET RETUBE 50 INES', NULL, NULL, 10, 0, '90.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2469, 1, NULL, 'COFFRET RETUBE 40 INES', NULL, NULL, 10, 0, '70.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2470, 1, NULL, 'RACCORD M 20 3/4 TEMME', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2471, 1, NULL, 'COUDE 20 3/4 TEMME', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2472, 1, NULL, 'SPOT LED PANEL PLAT 75W TOPAGE GM', NULL, NULL, 10, 0, '80.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2473, 1, NULL, 'CLE PLAT CRENEAU 8', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2474, 1, NULL, 'PORTE FUSIBLE 1P 14X51 63A', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2475, 1, NULL, 'MAT ESSENCE 30KG MIDI', NULL, NULL, 10, 0, '500.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2476, 1, NULL, 'THERMOSTAT CHAUFFE EAU ELEC', NULL, NULL, 10, 0, '90.00', 6, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2477, 1, NULL, 'COLLE PVC 0.5KG QUILOSA', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2478, 1, NULL, 'CABLE TV BLANC SIMPLE', NULL, NULL, 10, 0, '1.50', 9, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2479, 1, NULL, 'CABLE TV BLANC 1ER', NULL, NULL, 10, 0, '2.50', 9, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2480, 1, NULL, 'SCOTCH 3N ATLAS', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2481, 1, NULL, 'PIECE ETAGERE TRANSPARENTE', NULL, NULL, 10, 0, '0.50', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2482, 1, NULL, 'LAME VIANDE', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2483, 1, NULL, 'CONSOLE VERRE GM', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2484, 1, NULL, 'METRE 8M FACOM', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2485, 1, NULL, 'MASQUE SOUDEUR', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2486, 1, NULL, 'TUYAU GAZ TRANSPARANT', NULL, NULL, 10, 0, '9.00', 3, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2487, 1, NULL, 'SCIE ARBRE', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2488, 1, NULL, 'VERNIS 1691 PRODEC', NULL, NULL, 10, 0, '45.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2489, 1, NULL, 'TALOCHE GRIFFE', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2490, 1, NULL, 'PERCEUSE INGCO', NULL, NULL, 10, 0, '285.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2491, 1, NULL, 'MECHE 2 FER', NULL, NULL, 10, 0, '3.50', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2492, 1, NULL, 'NOVAL 1ER', NULL, NULL, 10, 0, '70.00', 9, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2493, 1, NULL, 'MECANISME POUSSOIR CABLE EDRO ESPAGN', NULL, NULL, 10, 0, '160.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2494, 1, NULL, 'ROBINET D ARRET 3/4 ALAMIA', NULL, NULL, 10, 0, '45.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2495, 1, NULL, 'FLEXIBLE DOUCHE 1.5M PLASTIQ COULEUR', NULL, NULL, 10, 0, '25.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2496, 1, NULL, 'ROBINET FLOTEUR CASA', NULL, NULL, 10, 0, '45.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2497, 1, NULL, 'MITIGEUR LAVABO 40 ROMIO', NULL, NULL, 10, 0, '180.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2498, 1, NULL, 'MITIGEUR CUISINE MURAL 40 ROMIO', NULL, NULL, 10, 0, '220.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2499, 1, NULL, 'MITIGEUR CUISINE TABLE 40 ROMIO', NULL, NULL, 10, 0, '190.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(2500, 1, NULL, 'FLEXIBLE DOUCHE 1.70M LUXZ EXTENSIBLE', NULL, NULL, 10, 0, '70.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2501, 1, NULL, 'ATLAS CHROME 250G', NULL, NULL, 10, 0, '17.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2502, 1, NULL, 'ROBINET JARDIN BACO S', NULL, NULL, 10, 0, '50.00', 7, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2503, 1, NULL, 'ROBINET JARDIN BACO T', NULL, NULL, 10, 0, '60.00', 7, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2504, 1, NULL, 'ROBINET SERVICE 1/2 CHROMEE RELAX', NULL, NULL, 10, 0, '70.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2505, 1, NULL, 'ROBINET SERVICE 1/2 JAUNE RIVER/SOMALIN', NULL, NULL, 10, 0, '65.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2506, 1, NULL, 'ROBINET SERVICE 1/2 CHROME RIVER', NULL, NULL, 10, 0, '70.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2507, 1, NULL, 'DOUCHETTE RELAX B99', NULL, NULL, 10, 0, '70.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2508, 1, NULL, 'DOUCHETTE RIVER B111/SOQOP', NULL, NULL, 10, 0, '90.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2509, 1, NULL, 'MELANGEUR CUISINE RELAX', NULL, NULL, 10, 0, '250.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2510, 1, NULL, 'MITIGEUR LAVABO RIVER/WEKTS', NULL, NULL, 10, 0, '285.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2511, 1, NULL, 'ROBINET LAVABO RELAX G9053/WEKIS/meram/ADKCO', NULL, NULL, 10, 0, '130.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2512, 1, NULL, 'FLEXIBLE MACHINE A LAVER 1ER BW68', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2513, 1, NULL, 'TETE MELANGEUR RELAX G22', NULL, NULL, 10, 0, '35.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2514, 1, NULL, 'TEE EGAL 16 TQM FIN', NULL, NULL, 10, 0, '30.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2515, 1, NULL, 'COUDE EGAL 25/25 CHROME', NULL, NULL, 10, 0, '55.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2516, 1, NULL, 'SIPHON TROPLINE AVEC BANDE GM 40 NW294B', NULL, NULL, 10, 0, '60.00', 2, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2517, 1, NULL, 'SUPPORT DOUCHE B79', NULL, NULL, 10, 0, '14.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2518, 1, NULL, 'SUPPORT DOUCHE B77', NULL, NULL, 10, 0, '15.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2519, 1, NULL, 'RALLANGE CHROME 10CM RELAX', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2520, 1, NULL, 'FACILAC 4.5KG SADVEL', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2521, 1, NULL, 'FACILAC 850G SADVEL', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2522, 1, NULL, 'RACCORD DIRECT GAZ SIMPLE', NULL, NULL, 10, 0, '6.00', 9, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2523, 1, NULL, 'CABLE CAOPTH 2*1.5 SOMCABLE', NULL, NULL, 10, 0, '4.50', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2524, 1, NULL, 'CABLE S 3*1.5 SIMPLE', NULL, NULL, 10, 0, '7.00', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2525, 1, NULL, 'RACCORD MELANG', NULL, NULL, 10, 0, '60.00', 7, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2526, 1, NULL, 'HUBLOT LED DETECTEUR GL', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2527, 1, NULL, 'CHARNIERE PAPILLON', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2528, 1, NULL, 'FIXATION MEUBLE PAPILLON', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2529, 1, NULL, 'CASQUE CONSTRUCTION', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2530, 1, NULL, 'CHALUMEAU LAITON GM', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2531, 1, NULL, 'SCOTCH EMB GM 100M', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2532, 1, NULL, 'RABOT', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2533, 1, NULL, 'CHARNIERE 14 MARON CHROME', NULL, NULL, 10, 0, '14.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2534, 1, NULL, 'PRISE RJ45 CAT5GALAXY 20228', NULL, NULL, 10, 0, '40.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2535, 1, NULL, 'SONNETTE PIANO 220V AC', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2536, 1, NULL, 'LAMPE A LED ARIC LAVABO 6W', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2537, 1, NULL, 'FICHE MAL 2P ING', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2538, 1, NULL, 'CONNECTEUR TORSADE', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2539, 1, NULL, 'INTERRUPTEUR APPAR OPTIMO LAP', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2540, 1, NULL, 'PRISE APPAR OPTIMO LAP', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2541, 1, NULL, 'CABLE CAPOTH 2*1.5 TUMAG', NULL, NULL, 10, 0, '5.50', 4, 2, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2542, 1, NULL, 'APPLIQUE JARDIN', NULL, NULL, 10, 0, '100.00', 4, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2543, 1, NULL, 'MECANISME CABLE USK', NULL, NULL, 10, 0, '180.00', 1, 5, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2544, 1, NULL, 'MECANISME  ITIMAT', NULL, NULL, 10, 0, '180.00', 1, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2545, 1, NULL, 'CISEAU A BOIS N14 TOTAL', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2546, 1, NULL, 'SERIE SUP SIMPLE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2547, 1, NULL, 'PINCEAU ROND N6', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2548, 1, NULL, 'CHARNIERE PM A CLOU', NULL, NULL, 10, 0, '2.50', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2549, 1, NULL, 'RIVET 5*20', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2550, 1, NULL, 'SERRURE WC /CLE CLEDOOR', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2551, 1, NULL, 'AGRAFE 8 A PISTOLET', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2552, 1, NULL, 'CLOU TAPISSIER GRAND NOIR', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:23', '2026-09-15 12:47:23'),
(2553, 1, NULL, 'MOUSTIQUAIRE FER 1.5', NULL, NULL, 10, 0, '35.00', 3, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2554, 1, NULL, 'KHAYAL ATLAS 20KG', NULL, NULL, 10, 0, '850.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2555, 1, NULL, 'ponceuse incco 450w', NULL, NULL, 10, 0, '580.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2556, 1, NULL, 'MASSETTE EN FER SIMPLE', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2557, 1, NULL, 'CLE PLAT CRENEAU 21', NULL, NULL, 10, 0, '30.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2558, 1, NULL, 'MECANISME PRISE 2P JADE', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2559, 1, NULL, 'MECANISME SORTIE FIL JADE', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2560, 1, NULL, 'CADRE 2 JADE', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2561, 1, NULL, 'CADRE 3 JADE', NULL, NULL, 10, 0, '14.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2562, 1, NULL, 'CADRE 4 JADE', NULL, NULL, 10, 0, '18.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2563, 1, NULL, 'MIDI YAKOUT 20KG', NULL, NULL, 10, 0, '950.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2564, 1, NULL, 'TUBE PVC 100 BATIPLAST', NULL, NULL, 10, 0, '35.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2565, 1, NULL, 'TUBE PVC 40 BATIPLAST', NULL, NULL, 10, 0, '15.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2566, 1, NULL, 'TUBE PVC 32 BATIPLAST', NULL, NULL, 10, 0, '13.50', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2567, 1, NULL, 'OSMOSEUR DOMESTIQUE 6ETAPES AVEC POMPE', NULL, NULL, 10, 0, '1500.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2568, 1, NULL, 'COLLIER COLSON 7.6*400', NULL, NULL, 10, 0, '1.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2569, 1, NULL, 'COLLIER COLSON 4.8*400', NULL, NULL, 10, 0, '1.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2570, 1, NULL, 'CABLE CAPOTH 2*1.5 SIMPLE', NULL, NULL, 10, 0, '4.00', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2571, 1, NULL, 'MAMELON PARABOLE', NULL, NULL, 10, 0, '3.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2572, 1, NULL, 'TEE PARABOLE', NULL, NULL, 10, 0, '5.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2573, 1, NULL, 'ROBINET EQUERRE 1/2 1/2 TEMME', NULL, NULL, 10, 0, '45.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2574, 1, NULL, 'DOUCHETTE TAHARA TEMME', NULL, NULL, 10, 0, '85.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2575, 1, NULL, 'EVIER ENC 50*40 INOX SWET', NULL, NULL, 10, 0, '300.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2576, 1, NULL, 'PORTE SAVON LIQUIDE SOPHIA', NULL, NULL, 10, 0, '50.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2577, 1, NULL, 'DOUCHETTE COMPLET B90', NULL, NULL, 10, 0, '75.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2578, 1, NULL, 'TETE DOUCHETTE  B128', NULL, NULL, 10, 0, '50.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2579, 1, NULL, 'TETE DOUCHETTE  B129', NULL, NULL, 10, 0, '55.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2580, 1, NULL, 'RALLONGE SORTIE ROBINET PM', NULL, NULL, 10, 0, '20.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2581, 1, NULL, 'ROBINET LAVABO G9022', NULL, NULL, 10, 0, '180.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2582, 1, NULL, 'SIPHON DOUCHE COUDE', NULL, NULL, 10, 0, '25.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2583, 1, NULL, 'DOUCHETTE COMPLET SOPHIA B69/ IDEAL', NULL, NULL, 10, 0, '80.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2584, 1, NULL, 'PRODUIT YUKI PM/ZENTEK', NULL, NULL, 10, 0, '14.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2585, 1, NULL, 'PRODUIT DETOX GM', NULL, NULL, 10, 0, '123.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2586, 1, NULL, 'CADRE SPOT 20', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2587, 1, NULL, 'DISQUE PONCAGE FER 115', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2588, 1, NULL, 'COLOPRIM 1K', NULL, NULL, 10, 0, '45.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2589, 1, NULL, 'NIVEAU D TUYAU 6', NULL, NULL, 10, 0, '2.00', 3, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2590, 1, NULL, 'LAQUE D EAU ATLAS 5KG', NULL, NULL, 10, 0, '170.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2591, 1, NULL, 'LAMPE REGLETTE PRISE T INTERR INGELEC', NULL, NULL, 10, 0, '65.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2592, 1, NULL, 'BOITE JAUNE CARRE INGELEC 2014', NULL, NULL, 10, 0, '3.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2593, 1, NULL, 'TUBE BI-MAX D20 ORANGE', NULL, NULL, 10, 0, '3.00', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2594, 1, NULL, 'TUBE BI-MAX D25 ORANGE', NULL, NULL, 10, 0, '4.00', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2595, 1, NULL, 'HUBLOT ROND EN VERRE ING 7201V', NULL, NULL, 10, 0, '55.00', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2596, 1, NULL, 'CADRE DECO 5P GALAXY', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2597, 1, NULL, 'TUBE ORANGE D11 INAS 10108', NULL, NULL, 10, 0, '2.80', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2598, 1, NULL, 'CHEVILLE  8 ING 1908', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2599, 1, NULL, 'CHEVILLE  10 ING 1910', NULL, NULL, 10, 0, '13.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2600, 1, NULL, 'SERRURE A CYLINDRE  SPECIALE GARYCLE/DOORLOK', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2601, 1, NULL, 'CYLINDRE DE SERRURE SPECIALE EV K-55/UMED', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2602, 1, NULL, 'VASQUE OVAL PM BLANC PORCHER', NULL, NULL, 10, 185, '0.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2603, 1, NULL, 'MAMELON COURT 1/2 TEMME', NULL, NULL, 10, 0, '16.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2604, 1, NULL, 'balai marbre', NULL, NULL, 10, 0, '18.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2605, 1, NULL, 'CLE A GRIFFE 13', NULL, NULL, 10, 0, '49.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2606, 1, NULL, 'TUBE PVC 125 BATIPLAST', NULL, NULL, 10, 0, '48.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2607, 1, NULL, 'DEGRIPPANT GM', NULL, NULL, 10, 0, '30.00', 9, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2608, 1, NULL, 'SCOTCH PAPIER MYACO', NULL, NULL, 10, 0, '10.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2609, 1, NULL, 'INTERRUP DOUBL SIMP MILLENIUM', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2610, 1, NULL, 'INTERRUP SIMP MILLENIUM', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2611, 1, NULL, 'INTERRUP VA ET VIENT MILLENIUM', NULL, NULL, 10, 0, '22.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2612, 1, NULL, 'CADRE MILLENIUM 1POSTE 34ROUGE', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2613, 1, NULL, 'CADRE MILLENIUM 1POSTE 10BLANC', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2614, 1, NULL, 'INTERRUP DOUBL VA ET VIENT MILLENIUM', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2615, 1, NULL, 'PRISE 2P T MILLENIUM', NULL, NULL, 10, 0, '22.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2616, 1, NULL, 'PRISE SIMPLE MILLENIUM', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2617, 1, NULL, 'SORTIE DE FIL MILLENIUM', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2618, 1, NULL, 'PRISE TV MILLENIUM', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2619, 1, NULL, 'PRISE SIMPLE ETANCH ENC MILLENIUM', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2620, 1, NULL, 'MIDI ALWAN DECO 1KG', NULL, NULL, 10, 0, '30.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2621, 1, NULL, 'VERNIS MAT MIDI 1KG', NULL, NULL, 10, 0, '50.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2622, 1, NULL, 'lampe detecteur 9w', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2623, 1, NULL, 'PRODUIT POUDRE CAFARD JAUNE', NULL, NULL, 10, 0, '6.00', 9, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2624, 1, NULL, 'TUYAU MACHINE A LAVER  FF 3/4', NULL, NULL, 10, 0, '45.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2625, 1, NULL, 'THERMOSTAT CHAUFFE EAU  ITALY', NULL, NULL, 10, 0, '70.00', 6, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2626, 1, NULL, 'ROBINET SERVICE JAUNE TAB FOREX', NULL, NULL, 10, 0, '35.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2627, 1, NULL, 'CALCULATRICE PM', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2628, 1, NULL, 'PIL SUPERLUK 20 2PCS', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2629, 1, NULL, 'TENAILLE DANI NOIR', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2630, 1, NULL, 'SERIE SUP PM', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2631, 1, NULL, 'PINCEAU ROND N80', NULL, NULL, 10, 0, '20.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2632, 1, NULL, 'CHAUFFE EAU ELECTRIQUE 50L CHAFFOTEAUX', NULL, NULL, 10, 0, '0.00', 6, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2633, 1, NULL, 'CHAUFFE EAU ELECTRIQUE 30L CHAFFOTEAUX', NULL, NULL, 10, 0, '0.00', 6, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2634, 1, NULL, 'TENDEUR ORIGINA', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2635, 1, NULL, 'CLE A MOLETTE 8', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2636, 1, NULL, 'CLE A MOLETTE 10', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2637, 1, NULL, 'CLE A MOLETTE 12', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2638, 1, NULL, 'FLEXIBLE TAHARA 1/2', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2639, 1, NULL, 'PAILLETTE', NULL, NULL, 10, 0, '85.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2640, 1, NULL, 'SILICON DEM1000', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2641, 1, NULL, 'ROULETTE 20M', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2642, 1, NULL, 'ROULETTE 10M', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2643, 1, NULL, 'PINCE RIVET KAKU', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2644, 1, NULL, 'SCOTCH DOUBLE FACE 5M BLEU', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2645, 1, NULL, 'BARRETTE RIDEAUX 19 CHROME', NULL, NULL, 10, 0, '16.00', 9, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2646, 1, NULL, 'TENDEUR DIRECT ASTRO', NULL, NULL, 10, 0, '55.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2647, 1, NULL, 'TUBE PVC 160 ABP', NULL, NULL, 10, 0, '88.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2648, 1, NULL, 'FILTRE A EAU PM', NULL, NULL, 10, 0, '250.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2649, 1, NULL, 'STUCCO ASTRAL 25KG', NULL, NULL, 10, 0, '850.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2650, 1, NULL, 'MAT ESSENCE 30KG MIDI SUPER', NULL, NULL, 10, 0, '650.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2651, 1, NULL, 'LAMPE A LED SPOT 8W GU10', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2652, 1, NULL, 'LAMPE A LED ALUMINIUM 12V', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2653, 1, NULL, 'LAMPE A LED ALUMINIUM 220V', NULL, NULL, 10, 0, '40.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2654, 1, NULL, 'HUBLOT A LED  CARRE', NULL, NULL, 10, 0, '80.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2655, 1, NULL, 'KIT CLE A CLIK', NULL, NULL, 10, 0, '200.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2656, 1, NULL, 'CYLINDRE DE SERRURE  FNK/AKMA', NULL, NULL, 10, 0, '200.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2657, 1, NULL, 'TOURNOUVIS KRT MM', NULL, NULL, 10, 0, '13.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2658, 1, NULL, 'NIVEAU D EAU PM WSP', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2659, 1, NULL, 'LAMPE FLAMO GM 8W', NULL, NULL, 10, 0, '30.00', 4, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2660, 1, NULL, 'LAMPE FLAMO E14 6W', NULL, NULL, 10, 0, '18.00', 4, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2661, 1, NULL, 'LAMPE A LED 15W SUPER NOVA', NULL, NULL, 10, 0, '18.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2662, 1, NULL, 'HUBLOT ROND EN PLASTIQ LAP 2006MM', NULL, NULL, 10, 0, '38.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2663, 1, NULL, 'HUBLOT ROND EN VERRE LAP MM', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2664, 1, NULL, 'LAMPE 60CM LED 18W', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2665, 1, NULL, 'COLLE BOIS 4KG', NULL, NULL, 10, 0, '80.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2666, 1, NULL, 'COLLE BOIS 500G JIP', NULL, NULL, 10, 0, '18.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2667, 1, NULL, 'COLLE BOIS 250G JIP', NULL, NULL, 10, 0, '12.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2668, 1, NULL, 'COLLE SPECIALE NOIR', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2669, 1, NULL, 'POMADE CAFARD GEL', NULL, NULL, 10, 0, '45.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2670, 1, NULL, 'CHEVILLLE 12 LAP', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2671, 1, NULL, 'AB FER GRIS 1KG RAMACOLOR', NULL, NULL, 10, 0, '25.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2672, 1, NULL, 'APPRET GRIS/NOIR 1KG ATLAS', NULL, NULL, 10, 0, '45.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2673, 1, NULL, 'APPRET BLANC 1KG ATLAS', NULL, NULL, 10, 0, '45.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2674, 1, NULL, 'LAMPE A LED SPOT G9 5W', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2675, 1, NULL, 'LAMPE E14 60W', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2676, 1, NULL, 'RALLONGE 3P T OSACA', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2677, 1, NULL, 'RALLONGE 4P T OSACA', NULL, NULL, 10, 0, '30.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2678, 1, NULL, 'CABLE BAF 2X1', NULL, NULL, 10, 0, '4.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2679, 1, NULL, 'LAMPE LED  BAF BLEU TOOTH', NULL, NULL, 10, 0, '60.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2680, 1, NULL, 'EAU DE BATTERIE 5L', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2681, 1, NULL, 'ENDUIT CARRELAGE C300 O\'DASSIA', NULL, NULL, 10, 0, '110.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2682, 1, NULL, 'PAPILLON  PLACARD', NULL, NULL, 10, 0, '5.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2683, 1, NULL, 'LAMPE DISQUE 65W', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2684, 1, NULL, 'LAMPE DISQUE 45W', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2685, 1, NULL, 'LAMPE A LED G LI 50W', NULL, NULL, 10, 0, '35.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2686, 1, NULL, 'GONFLEUR MM', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2687, 1, NULL, 'TUBE LUMIERE GAZ', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2688, 1, NULL, 'PETIT FOUR GAZ CARTOUCHE', NULL, NULL, 10, 0, '150.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2689, 1, NULL, 'TUBE PVC 50 BATIPLAST', NULL, NULL, 10, 0, '16.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2690, 1, NULL, 'COUDE PVC 100 BATIPLAST', NULL, NULL, 10, 0, '13.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2691, 1, NULL, 'ECHELLE ESCABEAUX 3', NULL, NULL, 10, 0, '560.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2692, 1, NULL, 'ECHELLE ESCABEAUX 4', NULL, NULL, 10, 0, '660.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2693, 1, NULL, 'lampe rechargeable 200w', NULL, NULL, 10, 0, '110.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2694, 1, NULL, 'LAMPE E14 FLAMME ING', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2695, 1, NULL, 'COLLE PVC PM TANJIT', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2696, 1, NULL, 'COLLE PVC GM TANJIT', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2697, 1, NULL, 'FLEXIBLE WC 1.2M 1/2 3/8 INOX', NULL, NULL, 10, 0, '65.00', 7, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2698, 1, NULL, 'GACHE ELECTRIQUE CLEDOOR', NULL, NULL, 10, 0, '140.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2699, 1, NULL, 'SUPPORT PLASTIQUE DISQUE  PONCEUSE 80-60..', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2700, 1, NULL, 'PERCEUSE MRQ PROFESSION/GRP', NULL, NULL, 10, 0, '300.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2701, 1, NULL, 'COLLE BOIS SAHARA  5KG', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2702, 1, NULL, 'MOULE INCCO 750W', NULL, NULL, 10, 0, '400.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2703, 1, NULL, 'JOINT FENETRE JAUNE', NULL, NULL, 10, 0, '18.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2704, 1, NULL, 'MANCHON WC DIRECTE PS', NULL, NULL, 10, 0, '25.00', 1, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2705, 1, NULL, 'TETE ROBINET MM', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2706, 1, NULL, 'DILUANT SODISCO 5L', NULL, NULL, 10, 0, '115.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2707, 1, NULL, 'dragon', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2708, 1, NULL, 'ESSENCE 5L', NULL, NULL, 10, 0, '110.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2709, 1, NULL, 'TOURNEVIS 35P', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2710, 1, NULL, 'COFFRET DE COMPTEUR MONOPHASE CARRE ONE AVEC CC', NULL, NULL, 10, 0, '150.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2711, 1, NULL, 'BOITE DISTRIBUTION MIMOSA SAFILUM', NULL, NULL, 10, 0, '170.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2712, 1, NULL, 'ECHELLE 2 1 EN ACIER', NULL, NULL, 10, 0, '240.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2713, 1, NULL, 'VIS TIRE-FOND 8MMX6', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2714, 1, NULL, 'COLLE SOMAFIX', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2715, 1, NULL, 'OUTIL FIX 3\'\' DE SERRAGE', NULL, NULL, 10, 0, '220.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2716, 1, NULL, 'ABATTANT AMORTIS', NULL, NULL, 10, 0, '130.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2717, 1, NULL, 'TUBE 1/2 CUIVRE LAFARGA', NULL, NULL, 10, 0, '75.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2718, 1, NULL, 'TUBE 1/4 CUIVRE LAFARGA', NULL, NULL, 10, 0, '42.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2719, 1, NULL, 'ARMAFLEX 9/6', NULL, NULL, 10, 0, '5.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2720, 1, NULL, 'ARMAFLEX 9/12', NULL, NULL, 10, 0, '6.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2721, 1, NULL, 'BOITE KTC', NULL, NULL, 10, 0, '55.00', 1, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2722, 1, NULL, 'CHAUFFE EAU  GINIA', NULL, NULL, 10, 0, '1000.00', 6, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2723, 1, NULL, 'LED ORANGE', NULL, NULL, 10, 0, '25.00', 4, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2724, 1, NULL, 'FICHE LED', NULL, NULL, 10, 0, '20.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2725, 1, NULL, 'JOINT SIPHON 40 ET 32', NULL, NULL, 10, 0, '4.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2726, 1, NULL, 'VANNE A BILLE 1/2 RIVER NW228', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2727, 1, NULL, 'EVIER  50X40 MARBRE', NULL, NULL, 10, 0, '300.00', 2, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2728, 1, NULL, 'TUYAU D EAU I.B', NULL, NULL, 10, 0, '14.00', 9, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2729, 1, NULL, 'COUDE 1/4 40 PS 010003', NULL, NULL, 10, 0, '13.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2730, 1, NULL, 'COUDE 1/4 32 PS 010001', NULL, NULL, 10, 0, '13.00', 1, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2731, 1, NULL, 'APPRET COLORADO', NULL, NULL, 10, 0, '40.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2732, 1, NULL, 'LAMPE G6 50W', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2733, 1, NULL, 'GUIRLANDE RJB 5M', NULL, NULL, 10, 0, '110.00', 4, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2734, 1, NULL, 'amwaj jafep 20kg', NULL, NULL, 10, 0, '1050.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2735, 1, NULL, 'VINYLE FACOP 600 10KG', NULL, NULL, 10, 0, '210.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2736, 1, NULL, 'sable', NULL, NULL, 10, 0, '8.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2737, 1, NULL, 'peinture poudre', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2738, 1, NULL, 'acide 66°', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2739, 1, NULL, 'PIED MACHINE', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2740, 1, NULL, 'KITTE CUIVRE 1/4-1/2', NULL, NULL, 10, 0, '85.00', 9, 2, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2741, 1, NULL, 'SCOTCH ARME PM', NULL, NULL, 10, 0, '30.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2742, 1, NULL, '2 PIL CHAUFFE EAU VARTA', NULL, NULL, 10, 0, '50.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2743, 1, NULL, 'NIVEAU A LASER 3X1', NULL, NULL, 10, 0, '260.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2744, 1, NULL, 'COLLE SOMA FIX 20G', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2745, 1, NULL, 'PIEGE RAT PLASTIQUE', NULL, NULL, 10, 0, '12.00', 9, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2746, 1, NULL, 'SECATEUR JARDINE ORANGE', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2747, 1, NULL, 'JEU DE CLES SIX PONT/ CRENAGE', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2748, 1, NULL, 'sarab decoratif midi 2kg', NULL, NULL, 10, 0, '70.00', 5, 5, '2026-09-15 12:47:24', '2026-09-15 12:47:24'),
(2749, 1, NULL, 'COUDE 1/8 40 PS 010004', NULL, NULL, 10, 0, '4.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2750, 1, NULL, 'TALOUCHE FAYROUZE', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2751, 1, NULL, 'TRUELLE CARRELAGE PM', NULL, NULL, 10, 0, '12.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2752, 1, NULL, 'RACCORD MELANGEUR COUDE', NULL, NULL, 10, 0, '35.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2753, 1, NULL, 'LEADER MAT 20KG', NULL, NULL, 10, 0, '520.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2754, 1, NULL, 'DEUX PRISE LAP', NULL, NULL, 10, 0, '40.00', 4, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2755, 1, NULL, 'ESSENCE 1L SODISCO', NULL, NULL, 10, 0, '23.00', 5, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2756, 1, NULL, 'ARCOPLAST 5KG', NULL, NULL, 10, 0, '95.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2757, 1, NULL, 'MECANISME GOHEN/WEKTS', NULL, NULL, 10, 0, '150.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2758, 1, NULL, 'COLLE PVC 1L SILTIN', NULL, NULL, 10, 0, '85.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2759, 1, NULL, 'PANEL 36W REGLAGE ATTA/APPRENT', NULL, NULL, 10, 0, '70.00', 4, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2760, 1, NULL, 'PANEL 24W REGLAGE ATTA', NULL, NULL, 10, 0, '70.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2761, 1, NULL, 'REGLETTE LAVABO LED  TOSUN', NULL, NULL, 10, 0, '150.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2762, 1, NULL, 'L\'ETAIN', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2763, 1, NULL, 'VINYLE COLORADO 1KG BLANC', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2764, 1, NULL, 'SAC PLATRE PETIT', NULL, NULL, 10, 0, '19.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2765, 1, NULL, 'SERRURE VIDE SIMPLE', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2766, 1, NULL, 'CHEVILLE PLATRE', NULL, NULL, 10, 0, '1.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2767, 1, NULL, 'KAWIA DANI', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2768, 1, NULL, 'KAWIA PIGEON', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2769, 1, NULL, 'POUDRE VERNIS ACAJOU', NULL, NULL, 10, 0, '120.00', 5, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2770, 1, NULL, 'moustiquaire 2m', NULL, NULL, 10, 0, '17.00', 3, 2, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2771, 1, NULL, 'GRATTOIR PEINTURE EN BOIS', NULL, NULL, 10, 0, '17.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2772, 1, NULL, 'DEBOUCHE 300G', NULL, NULL, 10, 0, '13.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2773, 1, NULL, 'ZENTEK POMMADE', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2774, 1, NULL, 'MIDI MAMOUNIA 30KG', NULL, NULL, 10, 0, '200.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2775, 1, NULL, 'COLLE COLORADO VINICO 5L', NULL, NULL, 10, 0, '90.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2776, 1, NULL, 'ITOFACADE COLORADO 5KG', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2777, 1, NULL, 'PRISE APPARENT 2P T OPTIMO 20719 LAP', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2778, 1, NULL, 'INTERRUPTEUR JADE AVEC CADRE', NULL, NULL, 10, 0, '17.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2779, 1, NULL, 'PORTE SAVON G9049', NULL, NULL, 10, 0, '100.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2780, 1, NULL, 'PORTE PAPIER G9015', NULL, NULL, 10, 0, '100.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2781, 1, NULL, 'pinceau rond gm', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2782, 1, NULL, 'ROBINET FLOTEUR ULLMA', NULL, NULL, 10, 0, '80.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2783, 1, NULL, 'MECANISME CABLE ULLMA/ DOUBLE VILETAGE', NULL, NULL, 10, 0, '160.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2784, 1, NULL, 'MAMELON MAL /MAL 3/4 3/4', NULL, NULL, 10, 0, '24.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2785, 1, NULL, 'CHMENDRE RAT', NULL, NULL, 10, 0, '10.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2786, 1, NULL, 'VANNE PAPILLON 3/4 MF G8086', NULL, NULL, 10, 0, '55.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2787, 1, NULL, 'RACCORD MELANGEUR COURT G377', NULL, NULL, 10, 0, '30.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2788, 1, NULL, 'SAUTEUSE INGCO', NULL, NULL, 10, 0, '380.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2789, 1, NULL, 'CROCHET 5/80', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2790, 1, NULL, 'CROCHET 5/60', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2791, 1, NULL, 'VIS 4*16', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2792, 1, NULL, 'TEE FEM 20X1/2 NIRON', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2793, 1, NULL, 'COUDE FEM 20X1/2 PPR NIRON', NULL, NULL, 10, 0, '29.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2794, 1, NULL, 'TEE SIMPLE  20 PPR NIRON', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2795, 1, NULL, 'COUDE 20 X 1/4 PPR NIRON', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2796, 1, NULL, 'MANCHON SIMPLE 20 PPR NIRON', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2797, 1, NULL, 'REDUCTION 25X20 PPR NIRON', NULL, NULL, 10, 0, '5.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2798, 1, NULL, 'COUDE DOS DANE 20 PPR NIRON', NULL, NULL, 10, 0, '20.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2799, 1, NULL, 'RACCORD M 20X1/2 PPR NIRON', NULL, NULL, 10, 0, '38.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2800, 1, NULL, 'RACCORD F 20X1/2 PPR NIRON', NULL, NULL, 10, 0, '36.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2801, 1, NULL, 'ROBINET  DARRET T-C 20 PPR NIRON', NULL, NULL, 10, 0, '150.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2802, 1, NULL, 'TUBE 20 PPR NIRON', NULL, NULL, 10, 0, '8.20', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2803, 1, NULL, 'ESSENCE 1L COLORADO', NULL, NULL, 10, 0, '30.00', 5, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2804, 1, NULL, 'SERRURE A TIRETTE  EUROGIGA DOORLOCK', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2805, 1, NULL, 'CYLINDRE DE SERRURE BOITE ZETE', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2806, 1, NULL, 'COLLIER GAZ 10/16', NULL, NULL, 10, 0, '4.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2807, 1, NULL, 'MARTEAU TRANSPARENT ERGO', NULL, NULL, 10, 0, '28.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2808, 1, NULL, 'TRUELLE LISSEUSE  ERGO', NULL, NULL, 10, 0, '40.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2809, 1, NULL, 'COTEAU VERRE  WSP 1ER', NULL, NULL, 10, 0, '75.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2810, 1, NULL, 'CACHE BOUTEILLE A GAZ', NULL, NULL, 10, 0, '200.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2811, 1, NULL, 'HILTI KEN 800W', NULL, NULL, 10, 0, '750.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2812, 1, NULL, 'MOULE KEN 800W', NULL, NULL, 10, 0, '350.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2813, 1, NULL, 'TABLEAU CHIFFRES', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2814, 1, NULL, 'PERCEUSE PG', NULL, NULL, 10, 0, '390.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2815, 1, NULL, 'TETE MELANGEUR SIMPLE', NULL, NULL, 10, 0, '28.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2816, 1, NULL, 'SUPPORT ETAGERE PAPILLON', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2817, 1, NULL, 'BEC MELANGEUR  2', NULL, NULL, 10, 0, '40.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2818, 1, NULL, 'JEU DE CLES SIX PONT/ CRENAGE PM', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2819, 1, NULL, 'CADENAS 67 CHROME', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2820, 1, NULL, 'JEU CLE SIX PANS SIMPLE', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2821, 1, NULL, 'CADRE 1 LAP', NULL, NULL, 10, 0, '2.50', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2822, 1, NULL, 'TUBE ORANGE Q09 ING', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2823, 1, NULL, 'SUPPORT TABLEAU MM', NULL, NULL, 10, 0, '1.50', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2824, 1, NULL, 'SUPPORT TABLEAU GM', NULL, NULL, 10, 0, '2.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2825, 1, NULL, 'CARRE DE POIGNEE', NULL, NULL, 10, 0, '4.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2826, 1, NULL, 'RALLONGE 2P T 3POSTE 3M', NULL, NULL, 10, 0, '60.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2827, 1, NULL, 'RALLONGE 2P T 4POSTE 3M', NULL, NULL, 10, 0, '65.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2828, 1, NULL, 'PANEL LED ROND ENC  12W', NULL, NULL, 10, 0, '50.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2829, 1, NULL, 'PANEL LED ROND ENC  18W', NULL, NULL, 10, 0, '45.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2830, 1, NULL, 'PANEL LED ROND REGLAGE ENC  18W', NULL, NULL, 10, 0, '65.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2831, 1, NULL, 'PANEL LED ROND REGLAGE ENC  24W', NULL, NULL, 10, 0, '100.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2832, 1, NULL, 'PANEL LED ROND REGLAGE ENC  36W', NULL, NULL, 10, 0, '130.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2833, 1, NULL, 'SERRURE DE CYLINDRE CLEDOR', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2834, 1, NULL, 'SERRURE DE CYLINDRE KUPA', NULL, NULL, 10, 0, '45.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2835, 1, NULL, 'COUDE EGALE 20 POLY', NULL, NULL, 10, 0, '12.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2836, 1, NULL, 'COUDE F 20 POLY', NULL, NULL, 10, 0, '12.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2837, 1, NULL, 'COUDE M 20 POLY', NULL, NULL, 10, 0, '12.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2838, 1, NULL, 'RACCORD  M 20 POLY', NULL, NULL, 10, 0, '12.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2839, 1, NULL, 'TEE EGALE  20 POLY', NULL, NULL, 10, 0, '16.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2840, 1, NULL, 'MAMELON LONG 1/2 ITALY', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2841, 1, NULL, 'MITIGEUR CUISINE  SANIVY', NULL, NULL, 10, 0, '450.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2842, 1, NULL, 'MANCHE PELLE', NULL, NULL, 10, 0, '15.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2843, 1, NULL, 'LAMPE A LED 9W JAUNE TOSUN', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2844, 1, NULL, 'PORTE DISJONCTEUR 4F /4P', NULL, NULL, 10, 0, '160.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2845, 1, NULL, 'PANEL PM PAULMAN REGLAGE', NULL, NULL, 10, 0, '25.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2846, 1, NULL, 'TEINTE EAU COLORADO', NULL, NULL, 10, 0, '12.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2847, 1, NULL, 'COUTEAU', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2848, 1, NULL, 'DISQUE CARRELAGE DINGO 180', NULL, NULL, 10, 0, '120.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2849, 1, NULL, 'DISQUE CARRELAGE DINGO 230', NULL, NULL, 10, 0, '175.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2850, 1, NULL, 'DISQUE CARRELAGE DINGO 115', NULL, NULL, 10, 0, '65.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2851, 1, NULL, 'CONSOLE NOIR FER FORGE 40', NULL, NULL, 10, 0, '16.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2852, 1, NULL, 'VISION  PORTE 1ER', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2853, 1, NULL, 'PELLE 1ER', NULL, NULL, 10, 0, '60.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2854, 1, NULL, 'SERRURE INOX EV', NULL, NULL, 10, 0, '170.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2855, 1, NULL, 'MIROIR/OVALE AVEC ACC', NULL, NULL, 10, 0, '80.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2856, 1, NULL, 'MEC SORTE FIL JADE M4553', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2857, 1, NULL, 'CADRE 1P JADE 6130', NULL, NULL, 10, 0, '5.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2858, 1, NULL, 'LAQUE DEAU ODASSIA 15KG', NULL, NULL, 10, 0, '550.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2859, 1, NULL, 'POISON DRAKR CAFARD', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2860, 1, NULL, 'POISON TERAK CAFARD', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2861, 1, NULL, 'CREMONE PORTUGAL', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2862, 1, NULL, 'POIGNEE PORTE PALIERE 1ER CHOIX 75', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2863, 1, NULL, 'METRE 7.5M BETTA', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2864, 1, NULL, 'MECHE HAUT TABLEAU', NULL, NULL, 10, 0, '100.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2865, 1, NULL, 'BOITE A OUTILLE METALIQUE GM', NULL, NULL, 10, 0, '250.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2866, 1, NULL, 'SUPPORT VETEMENT 4 INOX', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2867, 1, NULL, 'MACHINE DE SOUDAGE 1500W', NULL, NULL, 10, 0, '700.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2868, 1, NULL, 'BOITE A MONNAIE 10', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2869, 1, NULL, 'JEU 10 FORET A METAUX 5', NULL, NULL, 10, 0, '120.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2870, 1, NULL, 'JEU 10 FORET A METAUX 4', NULL, NULL, 10, 0, '70.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2871, 1, NULL, 'JEU 10 FORET A METAUX 3.5', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2872, 1, NULL, 'PINCE UNIVERSELLE', NULL, NULL, 10, 0, '48.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2873, 1, NULL, 'ROBINET DARRET 3/4 GHON', NULL, NULL, 10, 0, '70.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2874, 1, NULL, 'COUDE F 16X1/2 MTR', NULL, NULL, 10, 0, '70.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2875, 1, NULL, 'COUDE M 16X1/2 MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2876, 1, NULL, 'COUDE EGAL 16X1/2 MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2877, 1, NULL, 'RACCORD F 20X3/4 MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2878, 1, NULL, 'RACCORD M 20X3/4 MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2879, 1, NULL, 'RACCORD EGAL 16  MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2880, 1, NULL, 'RACCORD M 20X1/2  MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2881, 1, NULL, 'TEE EGAL 16  MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2882, 1, NULL, 'PIECE DEMONTABLE 3P', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2883, 1, NULL, 'DISQUE COUPE METAL INOX 115 INGCO', NULL, NULL, 10, 0, '8.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2884, 1, NULL, 'ITRY PLAST 1KG', NULL, NULL, 10, 0, '28.00', 5, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2885, 1, NULL, 'ODOLAC 15KG ODASSIA', NULL, NULL, 10, 0, '900.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2886, 1, NULL, 'RACCORD M 20 3/4', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2887, 1, NULL, 'RACCORD F 20 3/4', NULL, NULL, 10, 0, '50.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2888, 1, NULL, 'PARABOLE GRILLAGE', NULL, NULL, 10, 0, '90.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2889, 1, NULL, 'RACCORD FIXE DIRECTE GAZ CHAUFFE EAU LAITON', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2890, 1, NULL, 'LAMPE A POCHE', NULL, NULL, 10, 0, '25.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2891, 1, NULL, 'GRAISSE 1KG', NULL, NULL, 10, 0, '40.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2892, 1, NULL, 'DOUILLE 1/2 MELANGEUR CHROME', NULL, NULL, 10, 0, '15.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2893, 1, NULL, 'CABLE SV1V 2*0.75 ING', NULL, NULL, 10, 0, '4.20', 4, 2, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2894, 1, NULL, 'CABLE SV1V 2*1 ING', NULL, NULL, 10, 0, '4.80', 4, 2, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2895, 1, NULL, 'ARVINYL 1KG ARCOL', NULL, NULL, 10, 0, '220.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2896, 1, NULL, 'ARVINYL 10KG ARCOL', NULL, NULL, 10, 0, '220.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2897, 1, NULL, 'MANCHON EGAL 16 MTR', NULL, NULL, 10, 0, '35.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2898, 1, NULL, 'DISJONCTEUR 4FIL 40A-63A', NULL, NULL, 10, 0, '220.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2899, 1, NULL, 'LAMPE RECHARGABLE (bghrira)', NULL, NULL, 10, 0, '100.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2900, 1, NULL, 'CARTOUCHE FILTRE DEAU VES', NULL, NULL, 10, 0, '120.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2901, 1, NULL, 'PINCE PPR', NULL, NULL, 10, 0, '55.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2902, 1, NULL, 'MIROIR OVALE PS', NULL, NULL, 10, 0, '55.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2903, 1, NULL, 'VENTOUSE MANCHE  INOX', NULL, NULL, 10, 0, '40.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2904, 1, NULL, 'TENDEUR GAZ 1ER', NULL, NULL, 10, 0, '25.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2905, 1, NULL, 'TENDEUR GAZ 2EME', NULL, NULL, 10, 0, '15.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2906, 1, NULL, 'VIS COCOTTE', NULL, NULL, 10, 0, '1.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2907, 1, NULL, 'SUPPORT EQUERRE DEMONTABLE', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2908, 1, NULL, 'ROULETTE PORTE PLACARD COULISSANT', NULL, NULL, 10, 0, '35.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2909, 1, NULL, 'POIGNEE PLACARD INTEGREE', NULL, NULL, 10, 0, '35.00', 3, 2, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2910, 1, NULL, 'VOIX PLACARD COULISSANT', NULL, NULL, 10, 0, '80.00', 3, 2, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2911, 1, NULL, 'JOINT TORI 363PC', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2912, 1, NULL, 'ETAIN M', NULL, NULL, 10, 0, '60.00', 9, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2913, 1, NULL, 'SERINGUE MORTEX PM', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2914, 1, NULL, 'RACCORD EGAL 20 1/2', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25');
INSERT INTO `products` (`id`, `entreprise_id`, `user_id`, `name`, `description`, `marque`, `quantity`, `min_qte`, `unit_price`, `category_id`, `unite_id`, `created_at`, `updated_at`) VALUES
(2915, 1, NULL, 'RACCORD M 16 TEMME', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2916, 1, NULL, 'RACCORD F 16 TEMME', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2917, 1, NULL, 'TENNAILE BELLOTA', NULL, NULL, 10, 0, '80.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2918, 1, NULL, 'CUVETTE  RESERVOIR BLC PORCER', NULL, NULL, 10, 0, '600.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2919, 1, NULL, 'BERCEAUX 70/06 LAP', NULL, NULL, 10, 0, '10.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2920, 1, NULL, 'LAMPE LED 13W PHILIPS', NULL, NULL, 10, 0, '15.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2921, 1, NULL, 'FILM TIRABLE EMBALLAGE 1.5KG', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2922, 1, NULL, 'GRAISSE 250KG AKRON', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2923, 1, NULL, 'DISQUE GRANITE  115 MATREX', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2924, 1, NULL, 'DISQUE GRANITE  180 MATREX', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2925, 1, NULL, 'DISQUE GRANITE  230 MATREX', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2926, 1, NULL, 'PINCEAU ROND N 8', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2927, 1, NULL, 'PINCEAU ROND N 10', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2928, 1, NULL, 'PINCEAU ROND N 12', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2929, 1, NULL, 'LAMPE VEILLEUSE POUR TETE', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2930, 1, NULL, 'PINCEAU PLAT ACRO', NULL, NULL, 10, 0, '25.00', 5, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2931, 1, NULL, 'VERRE MASQUE SOUDEUR', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2932, 1, NULL, 'RALLONGE 5CM CHROME 2EME', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2933, 1, NULL, 'RALLONGE 10CM CHROME', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2934, 1, NULL, 'BOUCHON 20 PPR NIRON', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2935, 1, NULL, 'PANEL LED ENC 18W', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2936, 1, NULL, 'DOUILLE CHAUFFE EAU', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2937, 1, NULL, 'MINUTERIE 6F', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2938, 1, NULL, 'SWITCH MACHINE A LAVER', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2939, 1, NULL, 'FICHE CABLE', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2940, 1, NULL, 'COSSE CABLE', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2941, 1, NULL, 'PIECE ESSORAGE MACHINE A LAVE', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2942, 1, NULL, 'COUDE FLEXIBLE WC COUDE FIX', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2943, 1, NULL, 'COUDE FLEXIBLE WC SANILI', NULL, NULL, 10, 0, '40.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2944, 1, NULL, 'JOINT MECANISME NOIR', NULL, NULL, 10, 0, '10.00', 1, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2945, 1, NULL, 'SIPHON RECEVEUR DOUCHE  ROND', NULL, NULL, 10, 0, '30.00', 2, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2946, 1, NULL, 'MITIGEUR CUISINE ST  GALAXY GF8806', NULL, NULL, 10, 0, '260.00', 7, 1, '2026-09-15 12:47:25', '2026-09-15 12:47:25'),
(2947, 1, NULL, 'TETE ROBINET DARRET PPR 20', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2948, 1, NULL, 'VINYLE COLORADO COLOMAX 5KG', NULL, NULL, 10, 0, '60.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2949, 1, NULL, 'DILUANT ASTRAL 5L', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2950, 1, NULL, 'CLE EMBOUT VISSEUSE', NULL, NULL, 10, 0, '8.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2951, 1, NULL, 'RACCORD GAZ 3/8 FOUR', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2952, 1, NULL, 'CLE A MOLETTE 12 TABLEAU', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2953, 1, NULL, 'CLE A MOLETTE 10 TABLEAU', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2954, 1, NULL, 'POIGNEE FES AB', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2955, 1, NULL, 'POIGNEE FES CND AB', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2956, 1, NULL, 'CABLE RIGIDE 1*1.5 TUMAG', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2957, 1, NULL, 'CABLE RIGIDE 1*6 TUMAG', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2958, 1, NULL, 'SIEGE WC PLASTIQUE PS', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2959, 1, NULL, 'BOITE A MONNAIE 8', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2960, 1, NULL, 'BOITE A MONNAIE 6', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2961, 1, NULL, 'BOITE A MONNAIE 12', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2962, 1, NULL, 'HUBLOT LED ROND ET OVAL AVEC DETECTEUR', NULL, NULL, 10, 0, '60.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2963, 1, NULL, 'HUBLOT LED ROND ET OVAL AVEC DETECTEUR 20W', NULL, NULL, 10, 0, '80.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2964, 1, NULL, 'FERME PORTE  ROSSO', NULL, NULL, 10, 0, '130.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2965, 1, NULL, 'KIT BAR DOUCHE COMPLET 5006', NULL, NULL, 10, 0, '130.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2966, 1, NULL, 'VENTEUSE PORTE VERRE', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2967, 1, NULL, 'CLE PIPE 19', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2968, 1, NULL, 'CLE PIPE 9', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2969, 1, NULL, 'MECHE MARBRE 35', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2970, 1, NULL, 'CHARNIER 5INOX', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2971, 1, NULL, 'CLE PIPE 11', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2972, 1, NULL, 'NIVEAU FIL 500G', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2973, 1, NULL, 'JARDIN (KHBACHA)', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2974, 1, NULL, 'MECHE 10 VERRE', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2975, 1, NULL, 'CHARNIER 11', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2976, 1, NULL, 'PIQUET DE TERRE 1M SIMPLE', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2977, 1, NULL, 'PROJECTEUR DETECTEUR ENERGIE SOLAIRE', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2978, 1, NULL, 'RESITANCE 1200-1500 ITALY', NULL, NULL, 10, 0, '150.00', 6, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2979, 1, NULL, 'RESITANCE 3000 ITALY', NULL, NULL, 10, 0, '170.00', 6, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2980, 1, NULL, 'COLLIERS ATLAS 16 PLASTIQUE', NULL, NULL, 10, 0, '6.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2981, 1, NULL, 'MITIGEUR LAVABO NOIR', NULL, NULL, 10, 0, '6.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2982, 1, NULL, 'COLLE SOMAFIX MM', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2983, 1, NULL, 'VISSEUSE 12V PIJEON', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2984, 1, NULL, 'CISEAU A FER', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2985, 1, NULL, 'BOMBE AMORTISSEUR PLACARD 60', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2986, 1, NULL, 'BOMBE AMORTISSEUR PLACARD 80', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2987, 1, NULL, 'MITIGEUR DOUCHE GROH', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2988, 1, NULL, 'STUCCO ASTRAL 5KG', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2989, 1, NULL, 'BOUCHON PVC 125', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2990, 1, NULL, 'CLOU TAPISERIE 28MM', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2991, 1, NULL, 'CLOU TAPISSERIE 25MM', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2992, 1, NULL, 'SIEGE A LA TURQUE 56X55 ORCA BLANC', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2993, 1, NULL, 'COLLE PVC 500ML BOITE PLASTIQUE QUILOSA', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2994, 1, NULL, 'HUBLOT ROND BLANC LED 20W 6500K FERRI', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2995, 1, NULL, 'HUBLOT OVALE BLANC LED 20W 6500K FERRI', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2996, 1, NULL, 'HUBLOT ROND BLANC LED 15W 6500K FERRI', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2997, 1, NULL, 'COLOMAT 5KG', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2998, 1, NULL, 'COLOMAX 30KG VINYLE COLORADO', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(2999, 1, NULL, 'LAMPE A LED 9W TOPAGE', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3000, 1, NULL, 'LAMPE BATTERIE', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3001, 1, NULL, 'ECROU MELANGEUR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3002, 1, NULL, 'VIS POIGNEE', NULL, NULL, 10, 0, '3.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3003, 1, NULL, 'COLORADO ROSE MAMOUNIA 5KG', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3004, 1, NULL, 'MAGILAC FACOP 5KG', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3005, 1, NULL, 'rouleau peinture atlas', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3006, 1, NULL, 'DILUANT  4L', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3007, 1, NULL, 'COUDE APPLIQUE 16 MTR', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3008, 1, NULL, 'SIPHON TROPLIN GM', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3009, 1, NULL, 'SIPHON TROPLIN PM', NULL, NULL, 10, 0, '0.00', 2, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3010, 1, NULL, 'ROBINET CUISINE 222 223OUCHAN', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3011, 1, NULL, 'MITIGEUR UKS OUCHAN', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3012, 1, NULL, 'MITIGEUR BAIGNOIRE WEKTS', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3013, 1, NULL, 'MITIGEUR DOUCHE WEKTS', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3014, 1, NULL, 'CADRE SPOT BLANC PM', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3015, 1, NULL, 'MACHINE RIDEAU BACH', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3016, 1, NULL, 'PINCEAU ROND PM', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3017, 1, NULL, 'COUVERCLE WC', NULL, NULL, 10, 0, '0.00', 9, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3018, 1, NULL, 'GACHE ELECTRIQUE 12V DORCAS', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3019, 1, NULL, 'COLLIER COLSON 7.6/500 100P', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3020, 1, NULL, 'COLLE PVC SELTEN 50ML PM', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3021, 1, NULL, 'COLOMAT 20KG', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3022, 1, NULL, 'STOP COLORADO', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3023, 1, NULL, 'COF.09MOD ENC OPAL', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3024, 1, NULL, 'SIPHON CANIVEAU 20 OUCHEN', NULL, NULL, 10, 0, '0.00', 2, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3025, 1, NULL, 'SIPHON CANIVEAU 30 OUCHEN', NULL, NULL, 10, 0, '0.00', 2, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3026, 1, NULL, 'COLLIER GALVANISE 3\'\'1/2', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3027, 1, NULL, 'COLLIER GALVANISE 4\'\'', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3028, 1, NULL, 'CADRE 1 JADE', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3029, 1, NULL, 'MITIGEUR CUISINE MURAL RELAX G8046', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3030, 1, NULL, 'MITIGEUR LAVABO MURAL  G8044', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3031, 1, NULL, 'MITIGEUR DOUCHE RELAX G8047', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3032, 1, NULL, 'TABLEAUX MECHE BOIS 6P', NULL, NULL, 10, 0, '50.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3033, 1, NULL, 'DISJ 1*16A N 3721/16', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3034, 1, NULL, 'ROULEAU PEINTURE PM', NULL, NULL, 10, 0, '10.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3035, 1, NULL, 'MECHE HILTI LONG ERGO 14X500', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3036, 1, NULL, 'MECHE HILTI LONG ERGO 12X500', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3037, 1, NULL, 'MECHE HILTI LONG ERGO 10X500', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3038, 1, NULL, 'MECHE HILTI LONG ERGO 08X300', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3039, 1, NULL, 'BAGUETTE SOUDEUR 1M 2KG', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3040, 1, NULL, 'TIRETTE CIGARE NOIR 160', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3041, 1, NULL, 'TIRETTE CIGARE NOIR 96', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3042, 1, NULL, 'HILTI MKT 620W', NULL, NULL, 10, 0, '10.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3043, 1, NULL, 'BALANCE 25KG', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3044, 1, NULL, 'BALANCE 50KG', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3045, 1, NULL, 'BOITE AUTILLAGE HZN GM', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3046, 1, NULL, 'BOITE AUTILLAGE HZN MM', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3047, 1, NULL, 'BOITE AUTILLAGE HZN PM', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3048, 1, NULL, 'SCOTCH PLATRE 45M', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3049, 1, NULL, 'CLE A MOLETTE N8 LAMBOSS', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3050, 1, NULL, 'MASSETTE COUFRAGE STARCLE', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3051, 1, NULL, 'VISSEUSE PM LAMBOSS', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3052, 1, NULL, 'REGLETTE ALUM 2.5M', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3053, 1, NULL, 'CADENAS 30 CHROME', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3054, 1, NULL, 'SCOTCH DOUBLE FACE ERGO 5M', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3055, 1, NULL, 'CLE PLAT CRENAGE SERRIE', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3056, 1, NULL, 'CLE PLAT CRENAGE 8PCS ERGO', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3057, 1, NULL, 'GONFLEUR ERGO', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3058, 1, NULL, 'CLE A MOLETTE TABLE 3PCS', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3059, 1, NULL, 'ROBINET EQUERRE 1/2 3/8 CLEMO 602', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3060, 1, NULL, 'ROBINET EQUERRE 1/2 3/4 CLEMO 603', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3061, 1, NULL, 'SIPHON 40 GRAND BANDE ATLAMED', NULL, NULL, 10, 0, '0.00', 2, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3062, 1, NULL, 'ROBINET EQUERRE 1/2 1/2 CLIMO 601', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3063, 1, NULL, 'SIPHON WC PM NOIR PS', NULL, NULL, 10, 0, '0.00', 2, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3064, 1, NULL, 'COFFRET RETUBE PM 40 PS', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3065, 1, NULL, 'RACCORD M 16 1/2 MTR', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3066, 1, NULL, 'BI-MAX TUBE ORANGE 11', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3067, 1, NULL, 'LAMPE LED 6W', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3068, 1, NULL, 'CLE PIPE 14', NULL, NULL, 10, 0, '0.00', 3, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3069, 1, NULL, 'CABLE PRISE PC', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3070, 1, NULL, 'MITIGEUR BAIGNOIRE GALAXY GF8803', NULL, NULL, 10, 0, '450.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3071, 1, NULL, 'COLOMAT 1KG', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3072, 1, NULL, 'MITIGEUR BAIGNOIRE WEKTS jaune', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3073, 1, NULL, 'RACCORD M 16 FG', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3074, 1, NULL, 'RAFLEXIBLE DOUCHE WEKTS', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3075, 1, NULL, 'COF.DE COMPTEUR 4F ONE OZONE C14 TYPE 11 C14.011.130', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3076, 1, NULL, 'COSSE ELECTRICITE GM', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3077, 1, NULL, 'MAMELON MF 3/4 SOBIM', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3078, 1, NULL, 'COLLECTEUR 3-S RELAX', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3079, 1, NULL, 'COLLECTEUR 2-S RELAX', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3080, 1, NULL, 'MITIGEUR LAVABO ROCOALY', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3081, 1, NULL, 'LAMPE SECOURE', NULL, NULL, 10, 0, '0.00', 4, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3082, 1, NULL, 'PRODUIT LIQUIDE BLANCHE 50CL CAFARD FOURMI...', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3083, 1, NULL, 'ROBINET FLOTEUR SANILI 6013', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3084, 1, NULL, 'TETE DOUCHETTE TAHARA', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3085, 1, NULL, 'ROBINET DARRET 1/2 TAB REMIX', NULL, NULL, 10, 0, '0.00', 1, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3086, 1, NULL, 'FLEXIBLE TAHARA 1/2 IDROPOL', NULL, NULL, 10, 0, '0.00', 7, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3087, 1, NULL, 'TEE 1/2 LAITON SOBIM', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3088, 1, NULL, 'PIL TELECOMANDE DURACELL', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3089, 1, NULL, 'COLOVINYL 600 1KG', NULL, NULL, 10, 0, '0.00', 5, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3090, 1, NULL, 'DISQUE COUPE METAL 125X1.2 DANI', NULL, NULL, 10, 0, '0.00', 3, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3091, 1, NULL, 'ROBINET TAB ADKO', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3092, 1, NULL, 'ROBINET MUR ADKO', NULL, NULL, 10, 0, '0.00', 7, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3093, 1, NULL, 'POUDRE FOURMIS', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3094, 1, NULL, 'RALLONGE ROND 4P T 5M TOPAGE', NULL, NULL, 10, 0, '0.00', 4, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3095, 1, NULL, 'MECANISME PARMA', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3096, 1, NULL, 'RACCORD EGAL 16 F.G', NULL, NULL, 10, 0, '0.00', 1, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3097, 1, NULL, 'COLLE GRIFFE RAMA 5KG', NULL, NULL, 10, 0, '0.00', 5, 1, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3098, 1, NULL, 'CABLE CAMERA KX7 ALIMENTATION BLANC', NULL, NULL, 10, 0, '0.00', 4, 2, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3099, 1, NULL, 'sable', NULL, NULL, 10, 0, '0.00', 9, 5, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3100, 1, NULL, 'MANCHON PVC PRESSION 63 PN', NULL, NULL, 10, 0, '16.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3101, 1, NULL, 'REDUCTION PVC PRESSION 50/40 PN', NULL, NULL, 10, 0, '12.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3102, 1, NULL, 'REDUCTION PVC PRESSION 63/50 PN', NULL, NULL, 10, 0, '15.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3103, 1, NULL, 'BOUCHON PVC PRESSION 63  PN', NULL, NULL, 10, 0, '12.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3104, 1, NULL, 'presse étoupe', NULL, NULL, 10, 0, '6.50', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3105, 1, NULL, 'COLLE DEVNILLE 1KG', NULL, NULL, 10, 0, '110.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3106, 1, NULL, 'SILICON MONTAGE FIX  ', NULL, NULL, 10, 0, '55.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3107, 1, NULL, 'ML TUBE PVC PRESSION', NULL, NULL, 10, 0, '48.00', 9, 9, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3108, 1, NULL, 'CHEVILLE EMBASE', NULL, NULL, 10, 0, '0.50', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3109, 1, NULL, 'CHEVILLE METALIQUE', NULL, NULL, 10, 0, '7.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3110, 1, NULL, 'PRESSOSTAT HP 21-27 BAR', NULL, NULL, 10, 0, '680.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3111, 1, NULL, 'ECHELLE DOUBLE EN ALUMINUM 6-7 MARCHES', NULL, NULL, 10, 0, '980.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3112, 1, NULL, 'CLE A MOLETTE 30MM INGCO-EPICA', NULL, NULL, 10, 0, '130.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3113, 1, NULL, 'PINCE A CLOUS INGCO-EPICA', NULL, NULL, 10, 0, '85.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3114, 1, NULL, 'Bulon D-933 Galvanisé 8x20 cal 8.', NULL, NULL, 10, 0, '1.90', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3115, 1, NULL, 'Bulon D-933 Galvanisé 8x30 cal 8.', NULL, NULL, 10, 0, '2.00', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3116, 1, NULL, 'Bulon D-933 Galvanisé 8x50 cal 8.', NULL, NULL, 10, 0, '2.20', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3117, 1, NULL, 'Bulon D-933 Galvanisé 8x40 cal 8.', NULL, NULL, 10, 0, '2.10', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3118, 1, NULL, 'Bulon D-933 Galvanisé 6x25 cal 8.', NULL, NULL, 10, 0, '1.60', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3119, 1, NULL, 'Ecrou D-982 Galvanisé M-', NULL, NULL, 10, 0, '0.80', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3120, 1, NULL, 'Rondelle D-125 Galvanisé M-', NULL, NULL, 10, 0, '0.70', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3121, 1, NULL, 'Bulon D-933 Galvanisé 8X120 cal 8.', NULL, NULL, 10, 0, '3.40', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3122, 1, NULL, 'VIS D-7983 Galvanisé 5x', NULL, NULL, 10, 0, '0.55', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3123, 1, NULL, 'VIS D-7983 Galvanisé 6x', NULL, NULL, 10, 0, '0.60', 9, 4, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3124, 1, NULL, 'Pack de canon contenant : - Canon de 8cm - Clés propres du canon - Clé passe-partout qui ouvre les 140 conons', NULL, NULL, 10, 0, '187.00', 9, 10, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3125, 1, NULL, 'Pack de canon contenant : - Cadena N32 - Clé passe-partout qui ouvre les 50 cadenas', NULL, NULL, 10, 0, '135.00', 9, 10, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3126, 1, NULL, 'carreaux de pierre TAZA 60cm * 60cm poli', NULL, NULL, 10, 0, '90.00', 9, 10, '2026-09-15 12:47:26', '2026-09-15 12:47:26'),
(3127, 1, NULL, 'COLLE A GRIFFE ATLAS', NULL, NULL, 10, 0, '35.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3128, 1, NULL, 'Peinture ASTRAL cellaqua blanc 30kg', NULL, NULL, 10, 0, '395.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3129, 1, NULL, 'Sac plâtre moulage', NULL, NULL, 10, 0, '48.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3130, 1, NULL, 'scotch de peinture de 2 CM AKRO', NULL, NULL, 10, 0, '13.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3131, 1, NULL, 'scotch de peinture de 4,5 CM AKRO', NULL, NULL, 10, 0, '28.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3132, 1, NULL, 'Diluants', NULL, NULL, 10, 0, '25.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3133, 1, NULL, 'Peinture ZENIT ASTRAL 30KG', NULL, NULL, 10, 0, '32.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3134, 1, NULL, 'Vernis RENNER REF NO-10M001', NULL, NULL, 10, 0, '124.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3135, 1, NULL, 'Carte abrasif noir 400', NULL, NULL, 10, 0, '4.80', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3136, 1, NULL, 'sintofer ATLAS', NULL, NULL, 10, 0, '35.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3137, 1, NULL, 'Pinceau rond AKRO 10', NULL, NULL, 10, 0, '44.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3138, 1, NULL, 'Sac 50kg ciment noir 35', NULL, NULL, 10, 0, '98.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3139, 1, NULL, 'Teinte ? l’eau ARCOOL', NULL, NULL, 10, 0, '12.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3140, 1, NULL, 'COLLE A GRIFFE FACOP', NULL, NULL, 10, 0, '35.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3141, 1, NULL, 'Peinture cellolusique blanc brillant 5L', NULL, NULL, 10, 0, '290.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3142, 1, NULL, 'Peinture cellolusique noir brillant 5L', NULL, NULL, 10, 0, '290.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3143, 1, NULL, 'Peinture noir Synthétique mat 5L', NULL, NULL, 10, 0, '185.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3144, 1, NULL, 'Peinture noir Synthétique brillant 5L', NULL, NULL, 10, 0, '215.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3145, 1, NULL, 'Peinture vinylique préparée ASTRAL pour façade', NULL, NULL, 10, 0, '37.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3146, 1, NULL, 'Enduit en pâte écologique Adesiva', NULL, NULL, 10, 0, '88.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3147, 1, NULL, 'Sac 40kg ciment blanc', NULL, NULL, 10, 0, '175.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3148, 1, NULL, 'Recharge de rouleau radiateur latex', NULL, NULL, 10, 0, '8.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3149, 1, NULL, 'Sac de griffé', NULL, NULL, 10, 0, '17.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3150, 1, NULL, 'perche télescopique de peinture de 5m', NULL, NULL, 10, 0, '550.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3151, 1, NULL, 'peinture laque cellulosique chamois ARCOL', NULL, NULL, 10, 0, '42.75', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3152, 1, NULL, 'Stop astral', NULL, NULL, 10, 0, '20.90', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3153, 1, NULL, 'Pinceau plat 3cm AKRO', NULL, NULL, 10, 0, '26.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3154, 1, NULL, 'scotch de peinture de 2 CM', NULL, NULL, 10, 0, '13.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3155, 1, NULL, 'Peinture vinylique préparée ASTRAL pour Chambres', NULL, NULL, 10, 0, '36.00', 9, 5, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3156, 1, NULL, 'Rouleau PEINTURE INGCO', NULL, NULL, 10, 0, '48.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3157, 1, NULL, 'Pinceau Plat 6cm', NULL, NULL, 10, 0, '45.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3158, 1, NULL, 'Pinceau Plat AKRO 10', NULL, NULL, 10, 0, '44.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3159, 1, NULL, 'Cle a chaine marque BAHCO chaine de longuer 30 cm', NULL, NULL, 10, 0, '680.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3160, 1, NULL, 'Cle a chaine marque BAHCO pour diametre 60-105 mm', NULL, NULL, 10, 0, '530.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3161, 1, NULL, 'Colle noir Mixer', NULL, NULL, 10, 0, '75.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3162, 1, NULL, 'Colle beige Mixer', NULL, NULL, 10, 0, '85.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3163, 1, NULL, 'Pasta marbre', NULL, NULL, 10, 0, '160.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3164, 1, NULL, 'venteuse a trois appuis', NULL, NULL, 10, 0, '390.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3165, 1, NULL, 'rouleau de 15m de Cuivre 5/8', NULL, NULL, 10, 0, '930.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3166, 1, NULL, 'rouleau de 15m de Cuivre 1/4', NULL, NULL, 10, 0, '450.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3167, 1, NULL, 'rouleau de 15m de Cuivre 3/8', NULL, NULL, 10, 0, '660.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3168, 1, NULL, 'rouleau de 15m de Cuivre 1/2', NULL, NULL, 10, 0, '860.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3169, 1, NULL, 'Sac sable lavé', NULL, NULL, 10, 0, '17.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3170, 1, NULL, 'TE DIAM 63 PVC pression', NULL, NULL, 10, 0, '19.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3171, 1, NULL, 'Manchon anti-vibratoire a brides DIAM 90', NULL, NULL, 10, 0, '645.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3172, 1, NULL, 'brides PVC pression DIAM 90', NULL, NULL, 10, 0, '68.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3173, 1, NULL, 'Porte manteau chrome marque VITRA', NULL, NULL, 10, 0, '195.00', 9, 10, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3174, 1, NULL, 'PRISE 2P+T ENCASTRE LEGRAND', NULL, NULL, 10, 0, '215.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3175, 1, NULL, 'disque poncage 150mm bosch N60', NULL, NULL, 10, 0, '8.50', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3176, 1, NULL, 'disqueponçage150mmbosch', NULL, NULL, 10, 0, '60.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3177, 1, NULL, 'disque poncage 150mm bosch N80', NULL, NULL, 10, 0, '8.50', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3178, 1, NULL, 'Gant de protection produit chimique', NULL, NULL, 10, 0, '28.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3179, 1, NULL, 'bombe de peinture noir mate', NULL, NULL, 10, 0, '30.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3180, 1, NULL, 'Contacteur ABB avec bobine alimente 24v', NULL, NULL, 10, 0, '425.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3181, 1, NULL, 'TUBE PPR D63 NIRON', NULL, NULL, 10, 0, '62.50', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3182, 1, NULL, 'EMBOUT MALE PPR NIRON D63', NULL, NULL, 10, 0, '220.00', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3183, 1, NULL, 'EMBOUT FEMELLE PPR NIRON D63', NULL, NULL, 10, 0, '200.00', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3184, 1, NULL, 'RACCORD UNION GALVANISE D63', NULL, NULL, 10, 0, '200.00', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3185, 1, NULL, 'COLLIER A JOINT D63', NULL, NULL, 10, 0, '15.00', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3186, 1, NULL, 'COUDE 45° PPR 63', NULL, NULL, 10, 0, '45.00', 1, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3187, 1, NULL, 'COUDE 90° PPR 63', NULL, NULL, 10, 0, '50.00', 2, 1, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3188, 1, NULL, 'Bulon D-933 Galvanisé 8x20 cal 8.8', NULL, NULL, 10, 0, '1.90', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3189, 1, NULL, 'Bulon D-933 Galvanisé 8x30 cal 8.8', NULL, NULL, 10, 0, '2.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3190, 1, NULL, 'Bulon D-933 Galvanisé 8x50 cal 8.8', NULL, NULL, 10, 0, '2.20', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3191, 1, NULL, 'Bulon D-933 Galvanisé 8x40 cal 8.8', NULL, NULL, 10, 0, '2.10', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3192, 1, NULL, 'Bulon D-933 Galvanisé 6x25 cal 8.8', NULL, NULL, 10, 0, '1.60', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3193, 1, NULL, 'Ecrou D-982 Galvanisé M-6', NULL, NULL, 10, 0, '0.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3194, 1, NULL, 'Ecrou D-982 Galvanisé M-8', NULL, NULL, 10, 0, '1.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3195, 1, NULL, 'Ecrou D-982 Galvanisé M-10', NULL, NULL, 10, 0, '1.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3196, 1, NULL, 'Ecrou D-982 Galvanisé M-12', NULL, NULL, 10, 0, '1.10', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3197, 1, NULL, 'Rondelle D-125 Galvanisé M-10', NULL, NULL, 10, 0, '0.70', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3198, 1, NULL, 'Bulon D-933 Galvanisé 8X120 cal 8.8', NULL, NULL, 10, 0, '3.40', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3199, 1, NULL, 'VIS D-7983 Galvanisé 5x25', NULL, NULL, 10, 0, '0.55', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3200, 1, NULL, 'VIS D-7983 Galvanisé 6x25', NULL, NULL, 10, 0, '0.60', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3201, 1, NULL, 'VIS D-7983 Galvanisé 5x20', NULL, NULL, 10, 0, '0.50', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3202, 1, NULL, 'COLLIER PLASTIQUE 76370', NULL, NULL, 10, 0, '0.40', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3203, 1, NULL, 'COLLIER PLASTIQUE 3.6X360', NULL, NULL, 10, 0, '0.40', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3204, 1, NULL, 'Bulon D-933 Galvanisé 1040 cal 8.8', NULL, NULL, 10, 0, '3.50', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3205, 1, NULL, 'Bulon D-933 Galvanisé 1260 cal 8.8', NULL, NULL, 10, 0, '4.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3206, 1, NULL, 'Bulon D-933 Galvanisé 6x15', NULL, NULL, 10, 0, '1.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3207, 1, NULL, 'Bulon D-933 Galvanisé 8x60 cal 8.8', NULL, NULL, 10, 0, '2.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3208, 1, NULL, 'Bulon D-933 Galvanisé 1030 cal 8.8', NULL, NULL, 10, 0, '1.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3209, 1, NULL, 'Bulon D-933 Galvanisé 8x80 cal 8.8', NULL, NULL, 10, 0, '2.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3210, 1, NULL, 'Bulon D-933 Galvanisé 10x20 cal 8.8', NULL, NULL, 10, 0, '3.15', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3211, 1, NULL, 'Bulon D-933 Galvanisé 1230 cal 8.8', NULL, NULL, 10, 0, '3.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3212, 1, NULL, 'Bulon D-933 Galvanisé 1025 cal 8.8', NULL, NULL, 10, 0, '3.20', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3213, 1, NULL, 'Bulon D-933 Galvanisé 6x40 cal 8.8', NULL, NULL, 10, 0, '1.60', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3214, 1, NULL, 'Bulon D-933 Galvanisé 6x30 cal 8.8', NULL, NULL, 10, 0, '1.50', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3215, 1, NULL, 'Bulon D-933 Galvanisé 6x60 cal 8.8', NULL, NULL, 10, 0, '2.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3216, 1, NULL, 'Bulon D-933 Galvanisé 6x20 cal 8.8', NULL, NULL, 10, 0, '1.85', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3217, 1, NULL, 'Bulon D-933 Galvanisé 1050 cal 8.8', NULL, NULL, 10, 0, '3.60', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3218, 1, NULL, 'Bulon D-933 Galvanisé 8x15 cal 8.8', NULL, NULL, 10, 0, '1.40', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3219, 1, NULL, 'Rondelle D-125 Galvanisé M-12', NULL, NULL, 10, 0, '0.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3220, 1, NULL, 'Collier serrage 12-20', NULL, NULL, 10, 0, '2.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3221, 1, NULL, 'Lame cuteur', NULL, NULL, 10, 0, '1.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3222, 1, NULL, 'pompe a graisse manuelle 02kg', NULL, NULL, 10, 0, '745.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3223, 1, NULL, 'SPRAI DEGRIPPANT QV-40', NULL, NULL, 10, 0, '58.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3224, 1, NULL, 'Rondelle D-125 Galvanisé M-6', NULL, NULL, 10, 0, '0.50', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3225, 1, NULL, 'Rondelle D-125 Galvanisé M-8', NULL, NULL, 10, 0, '0.60', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3226, 1, NULL, 'COLLIER', NULL, NULL, 10, 0, '5.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3227, 1, NULL, 'LAME CUTEURE', NULL, NULL, 10, 0, '6.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3228, 1, NULL, 'Lunette de protection', NULL, NULL, 10, 0, '19.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3229, 1, NULL, 'Bulon D-931 Galvanisé 10X16 cal 8.8', NULL, NULL, 10, 0, '3.20', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3230, 1, NULL, 'Foret Inox 5', NULL, NULL, 10, 0, '6.80', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3231, 1, NULL, 'Boite de rangement en plastique transparente avec', NULL, NULL, 10, 0, '325.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3232, 1, NULL, 'couvercleLitresDimensiens79X57cm', NULL, NULL, 10, 0, '79.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3233, 1, NULL, 'LitresDimensiens79X57cm', NULL, NULL, 10, 0, '79.00', 9, 11, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3234, 1, NULL, 'ABATTANT DOUBLE SLIM marque ROCA ref:\nA801E52002', NULL, NULL, 10, 0, '400.00', 9, 12, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3235, 1, NULL, 'Brosse toilette chrome mural marque M.arti\nréférence 101310', NULL, NULL, 10, 0, '350.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3236, 1, NULL, 'fourniture Capteur De pression 0-10 bar marque\nSupmon', NULL, NULL, 10, 0, '1200.00', 9, 13, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3237, 1, NULL, 'sac de 50 kg Ciment noir 45', NULL, NULL, 10, 0, '98.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3238, 1, NULL, 'sac de 40Kg chaux blanc', NULL, NULL, 10, 0, '70.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3239, 1, NULL, '4 CLAPET ANTI RETOUR Ø 2’’ 1/2 EUROPA', NULL, NULL, 10, 0, '790.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3240, 1, NULL, '6 CLAPET ANTI RETOUR Ø 1’’ 1/2 EUROPA', NULL, NULL, 10, 0, '238.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3241, 1, NULL, '3 CLAPET ANTI RETOUR Ø1’’ 1/4 EUROPA', NULL, NULL, 10, 0, '185.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3242, 1, NULL, '1 ROULEAU JOINT CARTONNÉE Ø 0.15MM', NULL, NULL, 10, 0, '456.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3243, 1, NULL, 'Compresseur Embraco FF8.5HBK R134A 1PH', NULL, NULL, 10, 0, '1260.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3244, 1, NULL, 'Compresseur EMBRACO equivalent Danfoss\nFR6G R134a', NULL, NULL, 10, 0, '1340.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3245, 1, NULL, 'COMPRESSEUR SECOP FR8 5G LBP LST/HST\nR134A (equivalent en EMBRACO)', NULL, NULL, 10, 0, '2970.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3246, 1, NULL, 'Goulotte 100*45 Ingelec', NULL, NULL, 10, 0, '75.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3247, 1, NULL, 'Loctite 577 50Ml', NULL, NULL, 10, 0, '380.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3248, 1, NULL, 'Teflon liquide Force', NULL, NULL, 10, 0, '160.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3249, 1, NULL, 'Roulement 6205 RZ', NULL, NULL, 10, 0, '90.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3250, 1, NULL, 'Roulement 6206 RZ', NULL, NULL, 10, 0, '110.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3251, 1, NULL, 'Arrêt d’huile D35 65.55', NULL, NULL, 10, 0, '45.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3252, 1, NULL, 'Roue pneumatique solide D180mm', NULL, NULL, 10, 0, '560.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3253, 1, NULL, 'Fil Etain 1mm 90 à 99%', NULL, NULL, 10, 0, '180.00', 9, 14, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3254, 1, NULL, 'Porte savon Sonia', NULL, NULL, 10, 0, '390.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3255, 1, NULL, 'Porte savon Coin', NULL, NULL, 10, 0, '450.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3256, 1, NULL, 'Sac verre pour filtre fin astralpool 0.4mm', NULL, NULL, 10, 0, '188.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3257, 1, NULL, 'Sac verre pour filtre fin astralpool 0.8mm', NULL, NULL, 10, 0, '188.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3258, 1, NULL, 'Mamelon cuivre 2’', NULL, NULL, 10, 0, '98.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3259, 1, NULL, 'Coude PVC PRS 90/45', NULL, NULL, 10, 0, '46.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3260, 1, NULL, 'Coude PVC PRS 90/90', NULL, NULL, 10, 0, '46.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3261, 1, NULL, 'Reduction PVC PRS 110/90', NULL, NULL, 10, 0, '48.00', 9, 14, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3262, 1, NULL, 'Clapet double raccord PVC PRS 90', NULL, NULL, 10, 0, '650.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3263, 1, NULL, 'Tube PVC PRS D90', NULL, NULL, 10, 0, '82.00', 9, 9, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3264, 1, NULL, 'Manchon PVC PRS 90', NULL, NULL, 10, 0, '35.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3265, 1, NULL, 'Résistance céramique ARE 230V 650W\n23.5*5.5Cm', NULL, NULL, 10, 0, '1300.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3266, 1, NULL, 'Pomme de douche Jacob Delafon Louise', NULL, NULL, 10, 0, '540.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3267, 1, NULL, 'Filtre Cartouche Cintropur NW800', NULL, NULL, 10, 0, '125.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3268, 1, NULL, 'Electrovanne 12V 3/8G', NULL, NULL, 10, 0, '780.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3269, 1, NULL, 'Test Kit de la dureté totale de l’eau Hanna', NULL, NULL, 10, 0, '650.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3270, 1, NULL, 'Echelle double en aluminium 2*2 utilisation\ncoulissante', NULL, NULL, 10, 0, '760.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3271, 1, NULL, 'Charnière encastré De porte frigo', NULL, NULL, 10, 0, '165.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3272, 1, NULL, 'Spot sol IGUZZINI  220/240V 50/60Hz\n1Led*3,6W IP67 reference E111: Encastrement\nau sol Earth D=144mm - Blanc Chaud - optique\nSpot\nFiche technique ci-joint\nDelai de livraison : 08 semaines', NULL, NULL, 10, 0, '6470.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27'),
(3273, 1, NULL, 'Boîtier d\'encastrement reference pour\ninstallation au solIGUZZINI E111 + obturateur\nFiche technique ci-joint\nDelai de livraison : 08 semaines', NULL, NULL, 10, 0, '650.00', 9, 4, '2026-09-15 12:47:27', '2026-09-15 12:47:27');

-- --------------------------------------------------------

--
-- Structure de la table `reglements_fournisseurs`
--

CREATE TABLE `reglements_fournisseurs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fournisseur_id` bigint(20) UNSIGNED NOT NULL,
  `montant` decimal(15,2) NOT NULL,
  `date_reglement` date NOT NULL,
  `mode_paiement` varchar(255) NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reglement_bon_reception`
--

CREATE TABLE `reglement_bon_reception` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reglement_id` bigint(20) UNSIGNED NOT NULL,
  `bon_reception_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reglement_clients`
--

CREATE TABLE `reglement_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `numero` varchar(255) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `date_reglement` date NOT NULL,
  `montant` decimal(15,2) NOT NULL,
  `mode_paiement` enum('Espèces','Chèque','Virement','Carte') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('valide','annule') NOT NULL DEFAULT 'valide',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reglement_facture`
--

CREATE TABLE `reglement_facture` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reglement_id` bigint(20) UNSIGNED NOT NULL,
  `facture_id` bigint(20) UNSIGNED NOT NULL,
  `mont_paye` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `retours`
--

CREATE TABLE `retours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('AogBziHWvvsPzEhOh7X3MALQcWJusJ2fzvBWbmux', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibmh5WmNsTkFPTnVvQWVKMEdzQU9obE82cnZOWDgzcTJIZm9JUnBDcyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789722312),
('av6ilnpjI0xzFerOBFJfUiHG4sUqkj9ssRSdkpzi', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUG5zb1FnT05vdjlPVjhvR3BZejY4QWd6NEZHR09aYm5EaDVTU3lFQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZWdpc3RlciI7czo1OiJyb3V0ZSI7czo4OiJyZWdpc3RlciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1789744802),
('EPdjW0SGkIzjB6urfkOxaRl5u7WSIcVBoa2n2sJA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMWRrUmdtUVk2ZXY3NGhzY1RYbjVpZEc1a0M4V0FDZWVqTnpaQURuaSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZGFzaGJvYXJkIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1789501329),
('Jz0wUD0tohDIzkevr4vTWH0G8ApfCwHPQq28C9zq', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYmEzWWdkZzUxTEtDQlNKUVF4YTRUSHlZWFE2ajVXd0wxREpoU24zNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7czo1OiJyb3V0ZSI7czoxNDoicHJvZHVjdHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1789669367),
('jz9b41AO83CRWSH8sJDf8gKVxofLI4xyxm8f565c', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRXhpNVQ3V0RtMUNtNDBjNDBrOVd6VWJHWmw2dTI4V0FLWXQwanNEMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9ib24tY29tLWFjaGF0cyI7czo1OiJyb3V0ZSI7czoyMDoiYm9uLWNvbS1hY2hhdHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1789641954),
('TTI81OvIFZDGywiWC3do06J3q58Rb3jLXKqwmisb', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWjRlRmJmU01oZk9VeUNxem56c1pScWhMMW52ZlYwMTRZdU5BeEVVdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mzt9', 1789746716),
('uyDAwr9XHuJ5vBkclpw6bJHYllN73SiYlMWIdDAb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.138.0 Chrome/148.0.7778.280 Electron/42.10.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0xFVnBsUHE5Q0NqWEU0ZEpDT01aRVhmblIwUWZMZDhkRnR1b1dPeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1789668780),
('YkKVJGcDlF6qNWBgiePInyRtTxE6nvb71ieMxvoo', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVdTSmNNYXZ6dHhzbHYweDQ4MFNiVmRPbms5MElFQW5lUk9NMFZObCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9fQ==', 1789726475),
('zCH2ekPhBTZfzKpfm6RdtEivaxSbuwVE9gAA3M4B', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibjlJcjJaS2ZLQjMwZFVWNms1ZUlORWhKT3NnMG5aZDQwbm9acVBRZyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3Byb2R1Y3RzIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7czo1OiJyb3V0ZSI7czoxNDoicHJvZHVjdHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1789722309);

-- --------------------------------------------------------

--
-- Structure de la table `unites`
--

CREATE TABLE `unites` (
  `id` int(10) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `unites`
--

INSERT INTO `unites` (`id`, `entreprise_id`, `user_id`, `name`) VALUES
(1, 1, NULL, 'UNITE'),
(2, 1, NULL, 'METRE'),
(3, 1, NULL, 'Boite'),
(4, 1, NULL, 'U'),
(5, 1, NULL, 'KG'),
(6, 1, NULL, 'M'),
(7, 1, NULL, 'k'),
(8, 1, NULL, 'MÃ¨tre'),
(9, 1, NULL, 'ML'),
(10, 1, NULL, 'EA'),
(11, 1, NULL, 'UNIT'),
(12, 1, NULL, '10'),
(13, 1, NULL, '2'),
(14, 1, NULL, 'Bte');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entreprise_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `entreprise_id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'elaoud nezha', 'nezhabd.elaoud@gmail.com', NULL, '$2y$12$u4ei3hx3JvNAJ4rUduTFDuRoeiUm7mCIMVx5eWw3E/DTgsSyCEbpC', NULL, '2026-09-11 09:43:09', '2026-09-11 09:43:09'),
(2, 2, 'nezha nez', 'dev.nezha.25@gmail.com', NULL, '$2y$12$rbiCgYM8S59TcfVtvoatNukX65yGgZ2jEQzuYkKZscTZ62P0WkVvK', NULL, '2026-09-15 15:19:20', '2026-09-15 15:19:20'),
(3, 3, 'MALAK BOUDINI', 'admin@gmail.com', NULL, '$2y$12$AKYGJDKrqYnIgO3gLO3bYOo/Gt3iXpkcbcJMtNc6eoM0yaEd0coqy', NULL, '2026-09-18 14:51:53', '2026-09-18 14:51:53');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `achats`
--
ALTER TABLE `achats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `achats_entreprise_id_annee_num_unique` (`entreprise_id`,`annee`,`num`),
  ADD KEY `achats_fournisseur_id_foreign` (`fournisseur_id`),
  ADD KEY `achats_entreprise_id_fournisseur_id_date_commande_index` (`entreprise_id`,`fournisseur_id`,`date_commande`),
  ADD KEY `achats_entreprise_id_status_date_commande_index` (`entreprise_id`,`status`,`date_commande`),
  ADD KEY `achats_user_id_index` (`user_id`);

--
-- Index pour la table `achat_products`
--
ALTER TABLE `achat_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `achat_products_achat_id_foreign` (`achat_id`),
  ADD KEY `achat_products_product_id_foreign` (`product_id`),
  ADD KEY `achat_products_entreprise_id_achat_id_index` (`entreprise_id`,`achat_id`),
  ADD KEY `achat_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `achat_products_user_id_index` (`user_id`);

--
-- Index pour la table `avoirs`
--
ALTER TABLE `avoirs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `avoirs_entreprise_id_numero_avoir_unique` (`entreprise_id`,`numero_avoir`),
  ADD KEY `avoirs_client_id_foreign` (`client_id`),
  ADD KEY `avoirs_bon_livraison_id_foreign` (`bon_livraison_id`),
  ADD KEY `avoirs_facture_id_foreign` (`facture_id`),
  ADD KEY `avoirs_entreprise_id_client_id_date_avoir_index` (`entreprise_id`,`client_id`,`date_avoir`),
  ADD KEY `avoirs_user_id_index` (`user_id`);

--
-- Index pour la table `avoir_products`
--
ALTER TABLE `avoir_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avoir_products_avoir_id_foreign` (`avoir_id`),
  ADD KEY `avoir_products_product_id_foreign` (`product_id`),
  ADD KEY `avoir_products_entreprise_id_avoir_id_index` (`entreprise_id`,`avoir_id`),
  ADD KEY `avoir_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `avoir_products_user_id_index` (`user_id`);

--
-- Index pour la table `bon_commandes`
--
ALTER TABLE `bon_commandes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bon_commandes_entreprise_id_annee_num_unique` (`entreprise_id`,`annee`,`num`),
  ADD KEY `bon_commandes_client_id_foreign` (`client_id`),
  ADD KEY `bon_commandes_devis_id_foreign` (`devis_id`),
  ADD KEY `bon_commandes_entreprise_id_client_id_date_commande_index` (`entreprise_id`,`client_id`,`date_commande`),
  ADD KEY `bon_commandes_entreprise_id_status_date_commande_index` (`entreprise_id`,`status`,`date_commande`),
  ADD KEY `bon_commandes_user_id_index` (`user_id`);

--
-- Index pour la table `bon_commande_products`
--
ALTER TABLE `bon_commande_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bon_commande_products_bon_commande_id_foreign` (`bon_commande_id`),
  ADD KEY `bon_commande_products_product_id_foreign` (`product_id`),
  ADD KEY `bon_commande_products_entreprise_id_bon_commande_id_index` (`entreprise_id`,`bon_commande_id`),
  ADD KEY `bon_commande_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `bon_commande_products_user_id_index` (`user_id`);

--
-- Index pour la table `bon_com_achats`
--
ALTER TABLE `bon_com_achats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bon_com_achats_entreprise_id_annee_num_unique` (`entreprise_id`,`annee`,`num`),
  ADD KEY `bon_com_achats_fournisseur_id_foreign` (`fournisseur_id`),
  ADD KEY `bon_com_achats_entreprise_id_fournisseur_id_date_bc_achat_index` (`entreprise_id`,`fournisseur_id`,`date_bc_achat`),
  ADD KEY `bon_com_achats_user_id_index` (`user_id`);

--
-- Index pour la table `bon_com_product_achats`
--
ALTER TABLE `bon_com_product_achats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bon_com_product_achats_bon_com_achat_id_foreign` (`bon_com_achat_id`),
  ADD KEY `bon_com_product_achats_product_id_foreign` (`product_id`),
  ADD KEY `bon_com_product_achats_entreprise_id_bon_com_achat_id_index` (`entreprise_id`,`bon_com_achat_id`),
  ADD KEY `bon_com_product_achats_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `bon_com_product_achats_user_id_index` (`user_id`);

--
-- Index pour la table `bon_livraisons`
--
ALTER TABLE `bon_livraisons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bon_livraisons_entreprise_id_numero_bon_livraison_unique` (`entreprise_id`,`numero_bon_livraison`),
  ADD KEY `bon_livraisons_client_id_foreign` (`client_id`),
  ADD KEY `bon_livraisons_bon_commande_id_foreign` (`bon_commande_id`),
  ADD KEY `bon_livraisons_entreprise_id_client_id_date_livraison_index` (`entreprise_id`,`client_id`,`date_livraison`),
  ADD KEY `bon_livraisons_entreprise_id_status_date_livraison_index` (`entreprise_id`,`status`,`date_livraison`),
  ADD KEY `bon_livraisons_user_id_index` (`user_id`);

--
-- Index pour la table `bon_livraison_products`
--
ALTER TABLE `bon_livraison_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bon_livraison_products_bon_livraison_id_foreign` (`bon_livraison_id`),
  ADD KEY `bon_livraison_products_product_id_foreign` (`product_id`),
  ADD KEY `bon_livraison_products_entreprise_id_bon_livraison_id_index` (`entreprise_id`,`bon_livraison_id`),
  ADD KEY `bon_livraison_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `bon_livraison_products_user_id_index` (`user_id`);

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_entreprise_id_name_unique` (`entreprise_id`,`name`),
  ADD KEY `categories_user_id_index` (`user_id`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_entreprise_id_name_index` (`entreprise_id`,`name`),
  ADD KEY `clients_user_id_index` (`user_id`);

--
-- Index pour la table `devis`
--
ALTER TABLE `devis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `devis_entreprise_id_annee_num_unique` (`entreprise_id`,`annee`,`num`),
  ADD KEY `devis_client_id_foreign` (`client_id`),
  ADD KEY `devis_entreprise_id_client_id_date_devis_index` (`entreprise_id`,`client_id`,`date_devis`),
  ADD KEY `devis_entreprise_id_status_date_devis_index` (`entreprise_id`,`status`,`date_devis`),
  ADD KEY `devis_user_id_index` (`user_id`);

--
-- Index pour la table `devis_products`
--
ALTER TABLE `devis_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `devis_products_devis_id_foreign` (`devis_id`),
  ADD KEY `devis_products_product_id_foreign` (`product_id`),
  ADD KEY `devis_products_entreprise_id_devis_id_index` (`entreprise_id`,`devis_id`),
  ADD KEY `devis_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `devis_products_user_id_index` (`user_id`);

--
-- Index pour la table `entreprises`
--
ALTER TABLE `entreprises`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `factures`
--
ALTER TABLE `factures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `factures_entreprise_id_numero_facture_unique` (`entreprise_id`,`numero_facture`),
  ADD KEY `factures_client_id_foreign` (`client_id`),
  ADD KEY `factures_bon_livraison_id_foreign` (`bon_livraison_id`),
  ADD KEY `factures_entreprise_id_client_id_date_facture_index` (`entreprise_id`,`client_id`,`date_facture`),
  ADD KEY `factures_entreprise_id_status_date_facture_index` (`entreprise_id`,`status`,`date_facture`),
  ADD KEY `factures_user_id_index` (`user_id`);

--
-- Index pour la table `facture_products`
--
ALTER TABLE `facture_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `facture_products_facture_id_foreign` (`facture_id`),
  ADD KEY `facture_products_product_id_foreign` (`product_id`),
  ADD KEY `facture_products_entreprise_id_facture_id_index` (`entreprise_id`,`facture_id`),
  ADD KEY `facture_products_entreprise_id_product_id_index` (`entreprise_id`,`product_id`),
  ADD KEY `facture_products_user_id_index` (`user_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fournisseurs_entreprise_id_name_index` (`entreprise_id`,`name`),
  ADD KEY `fournisseurs_user_id_index` (`user_id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_entreprise_id_name_index` (`entreprise_id`,`name`),
  ADD KEY `products_entreprise_id_category_id_index` (`entreprise_id`,`category_id`),
  ADD KEY `products_entreprise_id_marque_index` (`entreprise_id`,`marque`),
  ADD KEY `products_user_id_index` (`user_id`),
  ADD KEY `products_unite_id_index` (`unite_id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Index pour la table `reglements_fournisseurs`
--
ALTER TABLE `reglements_fournisseurs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reglements_fournisseurs_fournisseur_id_foreign` (`fournisseur_id`),
  ADD KEY `regl_fourn_ent_date_idx` (`entreprise_id`,`fournisseur_id`,`date_reglement`),
  ADD KEY `reglements_fournisseurs_user_id_index` (`user_id`);

--
-- Index pour la table `reglement_bon_reception`
--
ALTER TABLE `reglement_bon_reception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reglement_bon_reception_entreprise_id_reglement_id_index` (`entreprise_id`,`reglement_id`),
  ADD KEY `reglement_bon_reception_bon_reception_id_index` (`bon_reception_id`),
  ADD KEY `reglement_bon_reception_user_id_index` (`user_id`),
  ADD KEY `reglement_bon_reception_reglement_id_foreign` (`reglement_id`);

--
-- Index pour la table `reglement_clients`
--
ALTER TABLE `reglement_clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reglement_clients_numero_unique` (`numero`),
  ADD KEY `reglement_clients_client_id_foreign` (`client_id`),
  ADD KEY `reglement_clients_entreprise_id_client_id_date_reglement_index` (`entreprise_id`,`client_id`,`date_reglement`),
  ADD KEY `reglement_clients_user_id_index` (`user_id`);

--
-- Index pour la table `reglement_facture`
--
ALTER TABLE `reglement_facture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reglement_facture_reglement_id_foreign` (`reglement_id`),
  ADD KEY `reglement_facture_facture_id_foreign` (`facture_id`),
  ADD KEY `reglement_facture_entreprise_id_reglement_id_index` (`entreprise_id`,`reglement_id`),
  ADD KEY `reglement_facture_entreprise_id_facture_id_index` (`entreprise_id`,`facture_id`),
  ADD KEY `reglement_facture_user_id_index` (`user_id`);

--
-- Index pour la table `retours`
--
ALTER TABLE `retours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `retours_entreprise_id_index` (`entreprise_id`),
  ADD KEY `retours_user_id_index` (`user_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `unites`
--
ALTER TABLE `unites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unites_entreprise_id_name_unique` (`entreprise_id`,`name`),
  ADD KEY `unites_user_id_index` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_entreprise_id_index` (`entreprise_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `achats`
--
ALTER TABLE `achats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `achat_products`
--
ALTER TABLE `achat_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `avoirs`
--
ALTER TABLE `avoirs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `avoir_products`
--
ALTER TABLE `avoir_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `bon_commandes`
--
ALTER TABLE `bon_commandes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `bon_commande_products`
--
ALTER TABLE `bon_commande_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `bon_com_achats`
--
ALTER TABLE `bon_com_achats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `bon_com_product_achats`
--
ALTER TABLE `bon_com_product_achats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `bon_livraisons`
--
ALTER TABLE `bon_livraisons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `bon_livraison_products`
--
ALTER TABLE `bon_livraison_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT pour la table `devis`
--
ALTER TABLE `devis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `devis_products`
--
ALTER TABLE `devis_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `entreprises`
--
ALTER TABLE `entreprises`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `factures`
--
ALTER TABLE `factures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `facture_products`
--
ALTER TABLE `facture_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3274;

--
-- AUTO_INCREMENT pour la table `reglements_fournisseurs`
--
ALTER TABLE `reglements_fournisseurs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reglement_bon_reception`
--
ALTER TABLE `reglement_bon_reception`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reglement_clients`
--
ALTER TABLE `reglement_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reglement_facture`
--
ALTER TABLE `reglement_facture`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `retours`
--
ALTER TABLE `retours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `unites`
--
ALTER TABLE `unites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `achats`
--
ALTER TABLE `achats`
  ADD CONSTRAINT `achats_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `achats_fournisseur_id_foreign` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseurs` (`id`),
  ADD CONSTRAINT `achats_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `achat_products`
--
ALTER TABLE `achat_products`
  ADD CONSTRAINT `achat_products_achat_id_foreign` FOREIGN KEY (`achat_id`) REFERENCES `achats` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `achat_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `achat_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `achat_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `avoirs`
--
ALTER TABLE `avoirs`
  ADD CONSTRAINT `avoirs_bon_livraison_id_foreign` FOREIGN KEY (`bon_livraison_id`) REFERENCES `bon_livraisons` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `avoirs_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `avoirs_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `avoirs_facture_id_foreign` FOREIGN KEY (`facture_id`) REFERENCES `factures` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `avoirs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `avoir_products`
--
ALTER TABLE `avoir_products`
  ADD CONSTRAINT `avoir_products_avoir_id_foreign` FOREIGN KEY (`avoir_id`) REFERENCES `avoirs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `avoir_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `avoir_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `avoir_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_commandes`
--
ALTER TABLE `bon_commandes`
  ADD CONSTRAINT `bon_commandes_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `bon_commandes_devis_id_foreign` FOREIGN KEY (`devis_id`) REFERENCES `devis` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bon_commandes_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_commandes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_commande_products`
--
ALTER TABLE `bon_commande_products`
  ADD CONSTRAINT `bon_commande_products_bon_commande_id_foreign` FOREIGN KEY (`bon_commande_id`) REFERENCES `bon_commandes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_commande_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_commande_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `bon_commande_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_com_achats`
--
ALTER TABLE `bon_com_achats`
  ADD CONSTRAINT `bon_com_achats_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_com_achats_fournisseur_id_foreign` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseurs` (`id`),
  ADD CONSTRAINT `bon_com_achats_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_com_product_achats`
--
ALTER TABLE `bon_com_product_achats`
  ADD CONSTRAINT `bon_com_product_achats_bon_com_achat_id_foreign` FOREIGN KEY (`bon_com_achat_id`) REFERENCES `bon_com_achats` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_com_product_achats_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_com_product_achats_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `bon_com_product_achats_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_livraisons`
--
ALTER TABLE `bon_livraisons`
  ADD CONSTRAINT `bon_livraisons_bon_commande_id_foreign` FOREIGN KEY (`bon_commande_id`) REFERENCES `bon_commandes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bon_livraisons_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `bon_livraisons_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_livraisons_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `bon_livraison_products`
--
ALTER TABLE `bon_livraison_products`
  ADD CONSTRAINT `bon_livraison_products_bon_livraison_id_foreign` FOREIGN KEY (`bon_livraison_id`) REFERENCES `bon_livraisons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_livraison_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bon_livraison_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `bon_livraison_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `clients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `devis`
--
ALTER TABLE `devis`
  ADD CONSTRAINT `devis_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `devis_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `devis_products`
--
ALTER TABLE `devis_products`
  ADD CONSTRAINT `devis_products_devis_id_foreign` FOREIGN KEY (`devis_id`) REFERENCES `devis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devis_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devis_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `devis_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `factures_bon_livraison_id_foreign` FOREIGN KEY (`bon_livraison_id`) REFERENCES `bon_livraisons` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `factures_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `factures_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `factures_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `facture_products`
--
ALTER TABLE `facture_products`
  ADD CONSTRAINT `facture_products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `facture_products_facture_id_foreign` FOREIGN KEY (`facture_id`) REFERENCES `factures` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `facture_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `facture_products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD CONSTRAINT `fournisseurs_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fournisseurs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_unite_id_foreign` FOREIGN KEY (`unite_id`) REFERENCES `unites` (`id`),
  ADD CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `reglements_fournisseurs`
--
ALTER TABLE `reglements_fournisseurs`
  ADD CONSTRAINT `reglements_fournisseurs_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglements_fournisseurs_fournisseur_id_foreign` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseurs` (`id`),
  ADD CONSTRAINT `reglements_fournisseurs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `reglement_bon_reception`
--
ALTER TABLE `reglement_bon_reception`
  ADD CONSTRAINT `reglement_bon_reception_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_bon_reception_reglement_id_foreign` FOREIGN KEY (`reglement_id`) REFERENCES `reglements_fournisseurs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_bon_reception_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `reglement_clients`
--
ALTER TABLE `reglement_clients`
  ADD CONSTRAINT `reglement_clients_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `reglement_clients_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_clients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `reglement_facture`
--
ALTER TABLE `reglement_facture`
  ADD CONSTRAINT `reglement_facture_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_facture_facture_id_foreign` FOREIGN KEY (`facture_id`) REFERENCES `factures` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_facture_reglement_id_foreign` FOREIGN KEY (`reglement_id`) REFERENCES `reglement_clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reglement_facture_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `retours`
--
ALTER TABLE `retours`
  ADD CONSTRAINT `retours_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `retours_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `unites`
--
ALTER TABLE `unites`
  ADD CONSTRAINT `unites_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
