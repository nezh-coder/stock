<?php

namespace App\Imports;

use App\Models\Unite;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\Importable;

class UnitesImport implements ToModel
{
    use Importable;

    /**
     * @param array $row
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        return new Unite([
            'name' => $row[0] ?? null,
           
        ]);
    }
}
