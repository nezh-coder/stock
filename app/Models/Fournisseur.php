<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Fournisseur extends Model
{
    protected $fillable = [
        'name',
        'tel',
        'email',
        'ice',
        'adresse',
        'credit',
    ];

    public function achats()
    {
        return $this->hasMany(Achat::class);
    }

    public function getTotalBonCommandesAttribute()
    {
        return $this->achats()->count();
    }

    public function getTotalOrderedAttribute()
    {
        return $this->achats()->sum('total_ttc');
    }

    public function getPendingOrdersAttribute()
    {
        return $this->achats()->where('status', 'en_cours')->count();
    }

    public function getReceivedOrdersAttribute()
    {
        return $this->achats()->where('status', 'recu')->count();
    }
}

