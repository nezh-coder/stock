<?php

namespace App\Models;

use App\Models\Concerns\BelongsToEntreprise;
use Illuminate\Database\Eloquent\Model;

class BonCommande extends Model
{
    use BelongsToEntreprise;

    protected $fillable = [
        'numero_bon_commande',
        'num',
        'annee',
        'client_id',
        'devis_id',
        'date_commande',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
    ];
     public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'bon_commande_products')->withPivot('quantity', 'unit_price', 'total');
    }
}
