<?php

namespace Tests\Feature\Auth;

use App\Models\Entreprise;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RegistrationTest extends TestCase
{
    use RefreshDatabase;

    public function test_registration_screen_can_be_rendered(): void
    {
        $response = $this->get('/register');

        $response->assertStatus(200);
    }

    public function test_new_users_can_register_with_a_new_company(): void
    {
        $response = $this->post('/register', [
            'name' => 'Alice',
            'email' => 'alice@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
            'entreprise_name' => 'Entreprise A',
            'entreprise_adresse' => 'Rue A',
            'entreprise_tel' => '0600000000',
            'entreprise_email' => 'contact@entreprise-a.com',
            'entreprise_ice' => 'ICEA',
        ]);

        $this->assertAuthenticated();
        $user = User::first();
        $entreprise = Entreprise::first();

        $this->assertNotNull($user);
        $this->assertNotNull($entreprise);
        $this->assertSame($entreprise->id, $user->entreprise_id);
        $this->assertSame('Entreprise A', $entreprise->name);
        $response->assertRedirect(route('dashboard', absolute: false));
    }

    public function test_registration_rejects_duplicate_email_and_does_not_create_an_orphan_company(): void
    {
        $entreprise = Entreprise::create([
            'name' => 'Entreprise existante',
            'adresse' => 'Rue de test',
            'tel' => '0600000000',
            'email' => 'contact@existante.com',
            'ice' => 'ICEEXIST',
        ]);

        User::factory()->create([
            'email' => 'alice@example.com',
            'entreprise_id' => $entreprise->id,
        ]);

        $response = $this->from('/register')->post('/register', [
            'name' => 'Bob',
            'email' => 'alice@example.com',
            'password' => 'password',
            'password_confirmation' => 'password',
            'entreprise_name' => 'Entreprise B',
        ]);

        $response->assertSessionHasErrors(['email']);
        $this->assertSame(1, Entreprise::count());
    }
}
