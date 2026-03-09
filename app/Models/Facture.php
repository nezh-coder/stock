<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Facture extends Model
{
    protected $fillable = [
        'num',
        'annee',
        'numero_facture',
        'client_id',
        'bon_livraison_id',
        'date_facture',
        'date_echeance',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
    ];

    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id');
    }

    public function bonLivraison()
    {
        return $this->belongsTo(BonLivraison::class, 'bon_livraison_id');
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'facture_products')->withPivot('quantity', 'unit_price', 'total');
    }
}