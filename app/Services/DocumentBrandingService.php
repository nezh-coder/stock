<?php

namespace App\Services;

use App\Models\Entreprise;
use Illuminate\Support\Facades\Storage;

class DocumentBrandingService
{
    public function for(?Entreprise $entreprise): array
    {
        $primary = $entreprise?->document_primary_color ?: '#315EFB';
        $secondary = $entreprise?->document_secondary_color ?: '#64748B';

        return [
            'primary' => $primary,
            'secondary' => $secondary,
            'logo_position' => $entreprise?->document_logo_position ?: 'left',
            'logo' => $this->asDataUri($entreprise?->logo),
            'background' => $this->asDataUri($entreprise?->document_background),
        ];
    }

    private function asDataUri(?string $path): ?string
    {
        if (! $path || ! Storage::disk('public')->exists($path)) {
            return null;
        }

        $absolutePath = Storage::disk('public')->path($path);
        $mime = mime_content_type($absolutePath) ?: 'image/png';

        return 'data:'.$mime.';base64,'.base64_encode(Storage::disk('public')->get($path));
    }
}
