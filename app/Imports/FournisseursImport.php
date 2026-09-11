<?php

namespace App\Imports;

use App\Models\Fournisseur;
use Illuminate\Support\Str;
use InvalidArgumentException;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\SkipsEmptyRows;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class FournisseursImport implements ToModel, WithHeadingRow, SkipsEmptyRows
{
    use Importable;

    public function model(array $row)
    {
        $row = collect($row)->mapWithKeys(function ($value, $key) {
            return [Str::slug((string) $key, '_') => is_string($value) ? trim($value) : $value];
        });

        $name = $this->value($row, ['nom', 'name', 'Fournisseur']);
        $phone = $this->value($row, ['Tél', 'Téléphone', 'tel', 'phone']);
        $email = $this->value($row, ['Email', 'email']);
        $ice = $this->value($row, ['Ice', 'ice']);
        $adresse = $this->value($row, ['Adresse', 'adresse', 'address']);

         
       
        if ($name === null  ) {
            throw new InvalidArgumentException(
                'La colonnes Nom est obligatoire.'
            );
        }

     
        return new Fournisseur([
            'name' => $name,
            'tel' => $phone,
            'email' => $email,
            'ice' => $ice,
            'adresse' => $adresse,
            
            
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