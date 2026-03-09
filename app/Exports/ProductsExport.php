<?php

namespace App\Exports;

use App\Models\Product;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class ProductsExport implements FromCollection, WithHeadings
{

    public function collection()
    {
        return Product::with(['Category','Unite'])
             ->withSum('achatProducts as quantity_achetee', 'quantity')
            ->withSum('achatProducts as total_achat', \DB::raw('quantity * unit_price'))
            ->get()
            ->map(function ($product) {

              ////  $totalAchat = $product->quantity_achetee * $product->total_achat;

                return [
                    'Nom' => $product->name,
                    'Catégorie' => $product->Category->name ?? '-',
                    'Unité' => $product->Unite->name ?? '-',
                    'Qté achetée' => $product->quantity_achetee,
                    'Prix total achat' => $product->total_achat ?? 0,
                    'Qté en stock' => $product->quantity,
                    'Qté seuil' => $product->min_qte
                ];
            });
    }

    public function headings(): array
    {
        return [
            'Nom',
            'Catégorie',
            'Unité',
            'Qté achetée',
            'Prix Total Achat (DH)',
            'Qté en Stock',
            'Qté Seuil'
        ];
    }
}