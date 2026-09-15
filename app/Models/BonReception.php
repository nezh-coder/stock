<?php

namespace App\Models;

use App\Models\Concerns\BelongsToEntreprise;
use Illuminate\Database\Eloquent\Model;

class BonReception extends Model
{
    use BelongsToEntreprise;

    protected $table = 'bons_reception';
    // ...existing code...
    public function reglements()
    {
        return $this->belongsToMany(ReglementFournisseur::class, 'reglement_bon_reception', 'bon_reception_id', 'reglement_id');
    }
}
