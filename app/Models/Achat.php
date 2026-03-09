<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Achat extends Model
{
    protected $fillable = [
        'numero_achat',
        'fournisseur_id',
        'date_livraison',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
         'montant_paye'
    ];
     public function fournisseur()
    {
        return $this->belongsTo(Fournisseur::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'achat_products')->withPivot('quantity', 'unit_price', 'total');
    }
}
