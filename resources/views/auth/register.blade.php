<x-guest-layout>
    <div class="w-full max-w-2xl mx-auto rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-900">
        <div class="mb-6 text-center">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white">Créer votre compte</h2>
            <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">Commencez à gérer votre activité avec Gestion de Stock.</p>
        </div>

        <form method="POST" action="{{ route('register') }}" class="space-y-6">
            @csrf

            <div>
                <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">Vos informations</h3>

                <div>
                    <x-input-label for="name" :value="__('Nom complet')" />
                    <x-text-input id="name" class="mt-1 block w-full" type="text" name="name" :value="old('name')" required autofocus autocomplete="name" />
                    <x-input-error :messages="$errors->get('name')" class="mt-2" />
                </div>

                <div class="mt-4">
                    <x-input-label for="email" :value="__('Email')" />
                    <x-text-input id="email" class="mt-1 block w-full" type="email" name="email" :value="old('email')" required autocomplete="username" />
                    <x-input-error :messages="$errors->get('email')" class="mt-2" />
                </div>

                <div class="mt-4">
                    <x-input-label for="password" :value="__('Mot de passe')" />
                    <x-text-input id="password" class="mt-1 block w-full"
                        type="password"
                        name="password"
                        required autocomplete="new-password" />
                    <x-input-error :messages="$errors->get('password')" class="mt-2" />
                </div>

                <div class="mt-4">
                    <x-input-label for="password_confirmation" :value="__('Confirmation du mot de passe')" />
                    <x-text-input id="password_confirmation" class="mt-1 block w-full"
                        type="password"
                        name="password_confirmation" required autocomplete="new-password" />
                    <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
                </div>
            </div>

            <div class="border-t border-gray-200 pt-6 dark:border-gray-700">
                <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">Votre entreprise</h3>

                <div>
                    <x-input-label for="entreprise_name" :value="__('Nom de l\'entreprise')" />
                    <x-text-input id="entreprise_name" class="mt-1 block w-full" type="text" name="entreprise_name" :value="old('entreprise_name')" required />
                    <x-input-error :messages="$errors->get('entreprise_name')" class="mt-2" />
                </div>

                <div class="mt-4">
                    <x-input-label for="entreprise_adresse" :value="__('Adresse')" />
                    <x-text-input id="entreprise_adresse" class="mt-1 block w-full" type="text" name="entreprise_adresse" :value="old('entreprise_adresse')" />
                    <x-input-error :messages="$errors->get('entreprise_adresse')" class="mt-2" />
                </div>

                <div class="mt-4 grid gap-4 sm:grid-cols-2">
                    <div>
                        <x-input-label for="entreprise_tel" :value="__('Téléphone')" />
                        <x-text-input id="entreprise_tel" class="mt-1 block w-full" type="text" name="entreprise_tel" :value="old('entreprise_tel')" />
                        <x-input-error :messages="$errors->get('entreprise_tel')" class="mt-2" />
                    </div>

                    <div>
                        <x-input-label for="entreprise_email" :value="__('Email de l\'entreprise')" />
                        <x-text-input id="entreprise_email" class="mt-1 block w-full" type="email" name="entreprise_email" :value="old('entreprise_email')" />
                        <x-input-error :messages="$errors->get('entreprise_email')" class="mt-2" />
                    </div>
                </div>

                <div class="mt-4">
                    <x-input-label for="entreprise_ice" :value="__('ICE')" />
                    <x-text-input id="entreprise_ice" class="mt-1 block w-full" type="text" name="entreprise_ice" :value="old('entreprise_ice')" />
                    <x-input-error :messages="$errors->get('entreprise_ice')" class="mt-2" />
                </div>
            </div>

            <div class="flex items-center justify-between pt-2">
                <a class="text-sm font-medium text-gray-600 underline hover:text-gray-900 dark:text-gray-400 dark:hover:text-white" href="{{ route('login') }}">
                    Déjà inscrit ? Se connecter
                </a>

                <x-primary-button>
                    {{ __('Créer mon compte') }}
                </x-primary-button>
            </div>
        </form>
    </div>
</x-guest-layout>
