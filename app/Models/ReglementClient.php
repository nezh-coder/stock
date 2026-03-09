<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReglementClient extends Model
{
    use HasFactory;

    protected $fillable = [
        'numero', 'client_id', 'date_reglement', 'montant',
        'mode_paiement', 'reference', 'notes', 'status', 'user_id'
    ];

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function factures()
    {
        return $this->belongsToMany(
        Facture::class,
        'reglement_facture',
        'reglement_id',
        'facture_id'
    )->withPivot('mont_paye')->withTimestamps();
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}