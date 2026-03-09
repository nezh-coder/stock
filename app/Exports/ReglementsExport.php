<?php

namespace App\Exports;

use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;

class ReglementsExport implements FromView
{
    protected $reglements;

    public function __construct($reglements)
    {
        $this->reglements = $reglements;
    }

    public function view(): View
    {
        return view('reglements.export_pdf', [
            'reglements' => $this->reglements
        ]);
    }
}
