<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Entreprise;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rules;
use Illuminate\Validation\Rule;
use Illuminate\View\View;
use Carbon\Carbon;

class RegisteredUserController extends Controller
{
    /**
     * Display the registration view.
     */
    public function create(): View
    {
        return view('auth.register');
    }

    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
            'entreprise_name' => ['required', 'string', 'max:255'],
            'entreprise_adresse' => ['nullable', 'string', 'max:255'],
            'entreprise_tel' => ['nullable', 'string', 'max:100'],
            'entreprise_email' => ['nullable', 'email', 'max:255'],
            'entreprise_ice' => ['nullable', 'string', 'max:50'],
            'logo' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:2048'],
            'document_background' => ['nullable', 'image', 'mimes:jpeg,png,jpg,webp', 'max:4096'],
            'formule' => ['nullable', Rule::in(['essai', 'abonnement'])],
        ]);

        $storedFiles = [];

        try {
            $user = DB::transaction(function () use ($validated, $request, &$storedFiles) {
            $entreprise = Entreprise::create([
                'name' => $validated['entreprise_name'],
                'adresse' => $validated['entreprise_adresse'] ?? null,
                'tel' => $validated['entreprise_tel'] ?? null,
                'email' => $validated['entreprise_email'] ?? null,
                'ice' => $validated['entreprise_ice'] ?? null,
                'plan' => 'trial',
                'subscription_status' => 'trialing',
                'trial_started_at' => Carbon::now(),
                'trial_ends_at' => Carbon::now()->addDays(config('saas.trial_days')),
                'document_logo_position' => 'left',
                'document_primary_color' => '#315EFB',
                'document_secondary_color' => '#64748B',
            ]);

            if ($request->hasFile('logo')) {
                $storedFiles['logo'] = $request->file('logo')->store('entreprises/logos', 'public');
            }

            if ($request->hasFile('document_background')) {
                $storedFiles['document_background'] = $request->file('document_background')->store('entreprises/backgrounds', 'public');
            }

            if ($storedFiles !== []) {
                $entreprise->update($storedFiles);
            }

            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
                'entreprise_id' => $entreprise->id,
            ]);

            return $user;
            });
        } catch (\Throwable $exception) {
            foreach ($storedFiles as $path) {
                Storage::disk('public')->delete($path);
            }

            throw $exception;
        }

        event(new Registered($user));

        Auth::login($user);

        return redirect(route('dashboard', absolute: false));
    }
}
