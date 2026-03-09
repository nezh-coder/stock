<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
   /// use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'quantity',
        'unit_price',
        'min_qte',
        'category_id',
         'unite_id'
    ];

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
