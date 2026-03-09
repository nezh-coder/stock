<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
     protected $fillable = [
        'name',
        'tel',
        'email',
        'ice',
        'adresse',
        'credit',
    ];

    public function devis()
    {
        return $this->hasMany(Devis::class);
    }

    public function factures()
    {
        return $this->hasMany(Facture::class);
    }

    public function bonLivraisons()
    {
        return $this->hasMany(BonLivraison::class);
    }

    public function getTotalDevisAttribute()
    {
        return $this->devis()->count();
    }

    public function getTotalFacturesAttribute()
    {
        return $this->factures()->count();
    }

    public function getTotalBonLivraisonsAttribute()
    {
        return $this->bonLivraisons()->count();
    }

    public function getTotalRevenueAttribute()
    {
        return $this->factures()->where('status', 'payee')->sum('total_ttc');
    }

    public function getPendingPaymentsAttribute()
    {
        return $this->factures()->where('status', 'non_payee')->sum('total_ttc');
    }
}
