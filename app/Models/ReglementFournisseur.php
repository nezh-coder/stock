<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class ReglementFournisseur extends Model{
    
    protected $table = 'reglements_fournisseurs';
    protected $fillable = [
        'fournisseur_id',
        'montant',
        'date_reglement',
        'mode_paiement',
        'reference',
        'user_id',
        'notes',
    ];
 public function fournisseur()
{
    return $this->belongsTo(Fournisseur::class);
}
public function user()
{
    return $this->belongsTo(User::class);
}

public function achats()
{
    return $this->belongsToMany(
        Achat::class,
        'reglement_bon_reception',
        'reglement_id',
        'bon_reception_id'
    )->withPivot('mont_paye')->withTimestamps();
}
}
