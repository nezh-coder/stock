<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BonComAchat extends Model
{
    protected $fillable = [
        'numero_bc_achat',
        'num',
        'annee',
        'fournisseur_id',
        'date_bc_achat',
        'date_livraison',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
    ];
     public function fournisseur()
    {
        return $this->belongsTo(Fournisseur::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'bon_com_product_achats')->withPivot('quantity', 'unit_price', 'total');
    }
}
