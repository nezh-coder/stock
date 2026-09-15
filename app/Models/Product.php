<?php

namespace App\Models;

use App\Models\Concerns\BelongsToEntreprise;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use BelongsToEntreprise;

    protected $fillable = [
        'name',
        'description',
        'quantity',
        'unit_price',
        'min_qte',
        'category_id',
        'unite_id',
    ];

    protected static function booted(): void
    {
        parent::booted();

        static::saving(function ($model) {
            if (! $model->category_id) {
                return;
            }

            $category = Category::withoutGlobalScopes()->find($model->category_id);

            if ($category && $category->entreprise_id !== static::currentEntrepriseId()) {
                throw new \RuntimeException('La catégorie sélectionnée n\'appartient pas à votre entreprise.');
            }
        });
    }

    public function devis()
    {
        return $this->belongsToMany(Devis::class, 'devis_products')->withPivot('quantity', 'unit_price', 'total');
    }
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
    public function unite()
    {
        return $this->belongsTo(Unite::class);
    }
    public function achatProducts()
    {
        return $this->hasMany(AchatProduct::class, 'product_id');
    }
}
