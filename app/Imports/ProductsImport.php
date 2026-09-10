<?php

namespace App\Imports;

use App\Models\Category;
use App\Models\Product;
use App\Models\Unite;
use Illuminate\Support\Str;
use InvalidArgumentException;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\SkipsEmptyRows;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ProductsImport implements ToModel, WithHeadingRow, SkipsEmptyRows
{
    use Importable;

    public function model(array $row)
    {
        $row = collect($row)->mapWithKeys(function ($value, $key) {
            return [Str::slug((string) $key, '_') => is_string($value) ? trim($value) : $value];
        });

        $name = $this->value($row, ['nom', 'name', 'produit']);
        $categoryName = $this->value($row, ['categorie', 'category', 'nom_categorie']);
        $unitName = $this->value($row, ['unite', 'unit', 'nom_unite']);
        $unitPrice = $this->value($row, ['prix_unitaire', 'unit_price', 'prix']);
        $quantity = $this->value($row, ['qte_en_stock', 'quantite', 'quantity', 'stock']);
        $minQuantity = $this->value($row, ['qte_seuil', 'min_qte', 'min_quantity', 'seuil']);
       
        if($unitName === null) {
            $unitName ='U';
        }
        if ($name === null || $categoryName === null || $unitName === null || $unitPrice === null) {
            throw new InvalidArgumentException(
                'Les colonnes Nom, Catégorie, Unité et Prix unitaire sont obligatoires.'
            );
        }

        $category = Category::firstOrCreate(['name' => $categoryName]);
        $unit = Unite::firstOrCreate(['name' => $unitName]);
 ///return  dd( $minQuantity );
        return new Product([
            'name' => $name,
            'description' => $this->value($row, ['description', 'details']),
            'quantity' => $quantity ?? 0,
            'unit_price' => $unitPrice,
            'min_qte' => $minQuantity ?? 0,
            'category_id' => $category->id,
            'unite_id' => $unit->id,
            
        ]);
    }

    private function value($row, array $keys)
    {
        foreach ($keys as $key) {
            $value = $row->get($key);

            if ($value !== null && $value !== '') {
                return $value;
            }
        }

        return null;
    }
}