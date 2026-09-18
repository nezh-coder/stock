<?php

return [
    'trial_days' => 7,

    'plans' => [
        'trial' => [
            'name' => 'Essai gratuit',
            'limits' => [
                'users' => 2,
                'products' => 20,
                'clients' => 10,
                'fournisseurs' => 5,
                'devis' => 10,
                'bon_commandes' => 10,
                'bon_livraisons' => 10,
                'factures' => 10,
                'avoirs' => 5,
            ],
        ],
        'premium' => [
            'name' => 'Abonnement',
            'limits' => [
                'users' => null,
                'products' => null,
                'clients' => null,
                'fournisseurs' => null,
                'devis' => null,
                'bon_commandes' => null,
                'bon_livraisons' => null,
                'factures' => null,
                'avoirs' => null,
            ],
        ],
    ],
];
