<?php

namespace App\Services;

use App\Models\Entreprise;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class SaasLimitService
{
    public function currentEntreprise(): ?Entreprise
    {
        return auth()->user()?->entreprise;
    }

    public function limit(string $resource): ?int
    {
        $entreprise = $this->currentEntreprise();
        $plan = $entreprise?->plan ?: 'trial';

        return config("saas.plans.{$plan}.limits.{$resource}");
    }

    public function count(string $resource): int
    {
        $entrepriseId = $this->currentEntreprise()?->id;
        if (! $entrepriseId) {
            return 0;
        }

        if ($resource === 'users') {
            return User::where('entreprise_id', $entrepriseId)->count();
        }

        $models = [
            'products' => \App\Models\Product::class,
            'clients' => \App\Models\Client::class,
            'fournisseurs' => \App\Models\Fournisseur::class,
            'devis' => \App\Models\Devis::class,
            'bon_commandes' => \App\Models\BonCommande::class,
            'bon_livraisons' => \App\Models\BonLivraison::class,
            'factures' => \App\Models\Facture::class,
            'avoirs' => \App\Models\Avoir::class,
        ];

        $model = $models[$resource] ?? null;
        return $model ? $model::where('entreprise_id', $entrepriseId)->count() : 0;
    }

    public function canCreate(string $resource): bool
    {
        $limit = $this->limit($resource);
        return $limit === null || $this->count($resource) < $limit;
    }

    public function message(string $resource): string
    {
        $labels = [
            'products' => 'produits', 'clients' => 'clients', 'fournisseurs' => 'fournisseurs',
            'devis' => 'devis', 'bon_commandes' => 'bons de commande',
            'bon_livraisons' => 'bons de livraison', 'factures' => 'factures',
            'avoirs' => 'avoirs', 'users' => 'utilisateurs',
        ];
        $limit = $this->limit($resource);
        return "Vous avez atteint la limite de {$limit} {$labels[$resource]} de votre période d'essai. Choisissez une formule pour continuer.";
    }

    public function usage(): array
    {
        return collect(config('saas.plans.'.($this->currentEntreprise()?->plan ?: 'trial').'.limits', []))
            ->map(fn ($limit, $resource) => ['resource' => $resource, 'used' => $this->count($resource), 'limit' => $limit])
            ->all();
    }
    
public function canCreateMany(string $resource, int $quantity): bool
{
    $remaining = $this->remaining($resource);

    return $remaining === null || $quantity <= $remaining;
}

public function remaining(string $resource): ?int
{
    $limit = $this->limit($resource);

    if ($limit === null) {
        return null;
    }

    return max(0, $limit - $this->count($resource));
} 
public function importMessage(string $resource, int $quantity): string
{
    $remaining = $this->remaining($resource);
    $limit = $this->limit($resource);

    if ($remaining === null) {
        return '';
    }

    $labels = [
        'products' => 'produits',
        'clients' => 'clients',
        'fournisseurs' => 'fournisseurs',
        'devis' => 'devis',
        'bon_commandes' => 'bons de commande',
        'bon_livraisons' => 'bons de livraison',
        'factures' => 'factures',
        'avoirs' => 'avoirs',
        'users' => 'utilisateurs',
    ];

    return "Votre formule permet encore {$remaining} {$labels[$resource]}. "
        . "L'import contient {$quantity} nouveaux éléments. "
        . "Veuillez choisir une formule pour continuer.";
}
}
