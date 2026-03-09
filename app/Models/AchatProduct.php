<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AchatProduct extends Model
{
    protected $table = 'achat_products';

    protected $fillable = [
        'product_id',
        'quantity',
        'unit_price'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    public function achat()
    {
        return $this->belongsTo(Achat::class);
    }
}