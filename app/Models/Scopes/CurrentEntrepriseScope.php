<?php

namespace App\Models\Scopes;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;

class CurrentEntrepriseScope implements Scope
{
    public function apply(Builder $builder, Model $model): void
    {
        $tenantId = $model::currentEntrepriseId();

        if ($tenantId === null) {
            $builder->whereRaw('0 = 1');
            return;
        }

        $builder->where($model->qualifyColumn('entreprise_id'), $tenantId);
    }
}
