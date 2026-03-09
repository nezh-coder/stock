<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BonLivraison extends Model
{
    protected $fillable = [
        'numero_bon_livraison',
        'num',
        'annee',
        'client_id',
        'bon_commande_id',
        'date_livraison',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
    ];
    protected $casts = [
        'date_livraison' => 'date',
    ];
    
    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id');
    }

    public function bonCommande()
    {
        return $this->belongsTo(BonCommande::class, 'bon_commande_id');
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'bon_livraison_products')->withPivot('quantity', 'unit_price', 'total');
    }
}