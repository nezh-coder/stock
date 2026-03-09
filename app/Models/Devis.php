<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Devis extends Model
{
    protected $fillable = [
        'numero_devis',
        'num',
        'annee',
        'client_id',
        'date_devis',
        'total_ht',
        'tva',
        'total_ttc',
        'status',
        'notes',
    ];
     protected $casts = [
        'date_devis' => 'date',
    ];
    
    public function getTotalTtcDhAttribute()
    {
        return number_format($this->total_ttc, 2);
    }
    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'devis_products')->withPivot('quantity', 'unit_price', 'total');
    }

   
}
