<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Illuminate\View\View;

class EnterpriseSettingsController extends Controller
{
    public function edit(): View
    {
        return view('enterprise.settings', ['entreprise' => auth()->user()->entreprise]);
    }

    public function update(Request $request)
    {
        $entreprise = auth()->user()->entreprise;
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'adresse' => ['nullable', 'string', 'max:255'],
            'tel' => ['nullable', 'string', 'max:100'],
            'email' => ['nullable', 'email', 'max:255'],
            'ice' => ['nullable', 'string', 'max:50'],
            'logo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:2048'],
            'document_background' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:4096'],
            'document_logo_position' => ['required', Rule::in(['left', 'center', 'right'])],
            'document_primary_color' => ['required', 'regex:/^#[0-9A-Fa-f]{6}$/'],
            'document_secondary_color' => ['required', 'regex:/^#[0-9A-Fa-f]{6}$/'],
        ]);

        foreach (['logo' => 'entreprises/logos', 'document_background' => 'entreprises/backgrounds'] as $field => $directory) {
            if ($request->hasFile($field)) {
                if ($entreprise->{$field}) {
                    Storage::disk('public')->delete($entreprise->{$field});
                }
                $validated[$field] = $request->file($field)->store($directory, 'public');
            }
        }

        $entreprise->update($validated);

        return back()->with('success', 'Les paramètres de votre entreprise ont été enregistrés.');
    }
}
