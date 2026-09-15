<?php

namespace App\Models\Concerns;

use App\Models\Scopes\CurrentEntrepriseScope;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

trait BelongsToEntreprise
{
    protected static function bootBelongsToEntreprise(): void
    {
        static::addGlobalScope(new CurrentEntrepriseScope);

        static::creating(function ($model) {
            $tenantId = static::currentEntrepriseId();

            if ($tenantId !== null && ! $model->getAttribute('entreprise_id')) {
                $model->setAttribute('entreprise_id', $tenantId);
            }

            if ($tenantId !== null && $model->getAttribute('entreprise_id') !== null && $model->getAttribute('entreprise_id') != $tenantId) {
                $model->setAttribute('entreprise_id', $tenantId);
            }
        });

        static::updating(function ($model) {
            if ($model->isDirty('entreprise_id')) {
                $model->attributes['entreprise_id'] = $model->getOriginal('entreprise_id');
            }
        });
    }

    public static function currentEntrepriseId(): ?int
    {
        $user = Auth::user();

        if (! $user || ! isset($user->entreprise_id) || $user->entreprise_id === null) {
            return null;
        }

        return (int) $user->entreprise_id;
    }

    public function scopeForCurrentEntreprise(Builder $query): Builder
    {
        $tenantId = static::currentEntrepriseId();

        if ($tenantId === null) {
            return $query->whereRaw('0 = 1');
        }

        return $query->where($this->qualifyColumn('entreprise_id'), $tenantId);
    }

    public function entreprise()
    {
        return $this->belongsTo(\App\Models\Entreprise::class);
    }
}
