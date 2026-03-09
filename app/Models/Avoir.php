<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Avoir extends Model
{
    protected $fillable = [
        'numero_avoir',
        'client_id',
        'bon_livraison_id',
        'facture_id',
        'date_avoir',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'motif',
        'notes',
    ];

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function bonLivraison()
    {
        return $this->belongsTo(BonLivraison::class);
    }

    public function facture()
    {
        return $this->belongsTo(Facture::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'avoir_products')->withPivot('quantity', 'unit_price', 'total', 'motif_retour');
    }
}
