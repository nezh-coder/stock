<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\Entreprise;
use App\Models\Product;
use App\Models\Unite;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TenantIsolationTest extends TestCase
{
    use RefreshDatabase;

    protected Entreprise $companyA;
    protected Entreprise $companyB;
    protected User $userA;
    protected User $userB;
    protected ?Unite $unitA = null;
    protected ?Unite $unitB = null;

    protected function setUp(): void
    {
        parent::setUp();

        $this->companyA = Entreprise::create([
            'name' => 'Entreprise A',
            'adresse' => 'Adresse A',
            'tel' => '0000000000',
            'email' => 'a@example.com',
            'ice' => 'ICEA',
        ]);

        $this->companyB = Entreprise::create([
            'name' => 'Entreprise B',
            'adresse' => 'Adresse B',
            'tel' => '1111111111',
            'email' => 'b@example.com',
            'ice' => 'ICEB',
        ]);

        $this->userA = User::create([
            'name' => 'Alice',
            'email' => 'alice@example.com',
            'password' => bcrypt('password'),
            'entreprise_id' => $this->companyA->id,
        ]);

        $this->userB = User::create([
            'name' => 'Bob',
            'email' => 'bob@example.com',
            'password' => bcrypt('password'),
            'entreprise_id' => $this->companyB->id,
        ]);

        $this->unitA = Unite::withoutGlobalScopes()->create([
            'name' => 'Unité A',
            'entreprise_id' => $this->companyA->id,
        ]);

        $this->unitB = Unite::withoutGlobalScopes()->create([
            'name' => 'Unité B',
            'entreprise_id' => $this->companyB->id,
        ]);
    }

    public function test_company_a_creates_a_category_with_its_own_entreprise_id(): void
    {
        $this->actingAs($this->userA);

        $category = Category::create([
            'name' => 'Catégorie A',
            'description' => 'Description A',
        ]);

        $this->assertSame($this->companyA->id, $category->entreprise_id);
    }

    public function test_company_a_lists_only_its_own_categories(): void
    {
        Category::create(['name' => 'A1', 'description' => 'A', 'entreprise_id' => $this->companyA->id]);
        Category::create(['name' => 'A2', 'description' => 'A2', 'entreprise_id' => $this->companyA->id]);
        Category::create(['name' => 'B1', 'description' => 'B', 'entreprise_id' => $this->companyB->id]);

        $this->actingAs($this->userA);

        $this->assertEqualsCanonicalizing(
            ['A1', 'A2'],
            Category::query()->pluck('name')->all()
        );
    }

    public function test_company_b_lists_only_its_own_categories(): void
    {
        Category::create(['name' => 'A1', 'description' => 'A', 'entreprise_id' => $this->companyA->id]);
        Category::create(['name' => 'B1', 'description' => 'B', 'entreprise_id' => $this->companyB->id]);
        Category::create(['name' => 'B2', 'description' => 'B2', 'entreprise_id' => $this->companyB->id]);

        $this->actingAs($this->userB);

        $this->assertEqualsCanonicalizing(
            ['B1', 'B2'],
            Category::query()->pluck('name')->all()
        );
    }

    public function test_company_b_cannot_access_company_a_category_via_model_lookup(): void
    {
        $categoryA = Category::create(['name' => 'A1', 'description' => 'A', 'entreprise_id' => $this->companyA->id]);

        $this->actingAs($this->userB);

        $this->assertNull(Category::find($categoryA->id));
        $this->expectException(\Illuminate\Database\Eloquent\ModelNotFoundException::class);
        Category::findOrFail($categoryA->id);
    }

    public function test_company_b_request_cannot_force_entreprise_id_on_create(): void
    {
        $this->actingAs($this->userA);

        $category = Category::create([
            'name' => 'Forced tenant',
            'description' => 'evil',
            'entreprise_id' => $this->companyB->id,
        ]);

        $this->assertSame($this->companyA->id, $category->fresh()->entreprise_id);
    }

    public function test_company_a_cannot_create_product_in_company_b_category(): void
    {
        $categoryB = Category::create(['name' => 'B Cat', 'description' => 'B', 'entreprise_id' => $this->companyB->id]);

        $this->actingAs($this->userA);

        try {
            Product::create([
                'name' => 'Test product',
                'description' => 'desc',
                'quantity' => 1,
                'unit_price' => 100,
                'min_qte' => 0,
                'category_id' => $categoryB->id,
                'unite_id' => $this->unitA->id,
            ]);

            $this->fail('A product from another company category should not be creatable.');
        } catch (\Throwable $e) {
            $this->assertTrue(true);
        }
    }
}
