# Exemples de Code - Système d'Avoirs

## 1. Utilisation de l'API Avoir en PHP

### Créer un Avoir Programmatiquement

```php
use App\Models\Avoir;
use App\Models\Product;

// Créer un avoir avec articles
$avoir = Avoir::create([
    'numero_avoir' => 'AV001/25',
    'client_id' => 1,
    'bon_livraison_id' => null,
    'facture_id' => 5,
    'date_avoir' => now(),
    'total_ht' => 100,
    'tva' => 20,
    'total_ttc' => 120,
    'status' => 'en_cours',
    'motif' => 'Produit défectueux',
    'notes' => 'À traiter rapidement'
]);

// Ajouter des articles
$avoir->products()->attach([
    1 => [
        'quantity' => 2,
        'unit_price' => 50,
        'total' => 100,
        'motif_retour' => 'Défaut de fabrication'
    ]
]);
```

### Récupérer les Avoirs d'un Client

```php
use App\Models\Client;

$client = Client::find(1);
$avoirs = $client->avoirs()
    ->where('status', 'en_cours')
    ->orderBy('created_at', 'desc')
    ->get();

foreach ($avoirs as $avoir) {
    echo $avoir->numero_avoir . ': ' . $avoir->total_ttc . '€';
}
```

### Obtenir les Avoirs d'un Bon de Livraison

```php
use App\Models\BonLivraison;

$bl = BonLivraison::with('avoirs')->find(1);

foreach ($bl->avoirs as $avoir) {
    echo 'Avoir ' . $avoir->numero_avoir . ': ';
    echo $avoir->products->count() . ' produits';
}
```

### Mettre à Jour le Statut d'un Avoir

```php
use App\Models\Avoir;

$avoir = Avoir::find(1);
$avoir->status = 'valide';
$avoir->save();
```

### Supprimer un Avoir

```php
use App\Models\Avoir;

$avoir = Avoir::find(1);
$avoir->delete(); // Supprime aussi les articles pivot
```

---

## 2. Requêtes AJAX Côté Client

### Charger les Articles d'un Document

```javascript
// Depuis la vue Blade (create.blade.php)
function loadDocumentProducts(documentId, documentType) {
    if (!documentId) {
        $('#sourceArticles').slideUp();
        return;
    }

    $.ajax({
        url: '/get-document-articles',
        type: 'POST',
        data: {
            document_id: documentId,
            document_type: documentType,
            _token: '{{ csrf_token() }}'
        },
        success: function(response) {
            if (response.products && response.products.length > 0) {
                // Afficher les articles
                let html = '<table class="table">';
                response.products.forEach(function(product) {
                    html += '<tr><td>' + product.name + '</td></tr>';
                });
                html += '</table>';
                $('#sourceProductsList').html(html);
                $('#sourceArticles').slideDown();
            }
        },
        error: function() {
            alert('Erreur lors du chargement des articles.');
        }
    });
}
```

### Ajouter un Produit à la Liste de Retour

```javascript
// Depuis le formulaire
$('.add-to-return').on('click', function() {
    const qty = $('#' + rowId).find('.qty-input').val();
    
    if (qty > 0) {
        // Ajouter à la liste
        addProductRow(productId, productName, unitPrice, qty);
    } else {
        alert('Quantité invalide');
    }
});
```

### Mettre à Jour les Totaux en Temps Réel

```javascript
function updateTotals() {
    let totalHT = 0;
    
    $('.product-row').each(function() {
        const qty = parseFloat($(this).find('.quantity-input').val()) || 0;
        const price = parseFloat($(this).find('.unit-price-input').val()) || 0;
        totalHT += qty * price;
    });
    
    const tvaRate = parseFloat($('#tva').val()) || 0;
    const totalTVA = totalHT * (tvaRate / 100);
    const totalTTC = totalHT + totalTVA;
    
    $('#totalHT').text(totalHT.toFixed(2));
    $('#totalTVA').text(totalTVA.toFixed(2));
    $('#totalTTC').text(totalTTC.toFixed(2));
}
```

---

## 3. Contrôleur - Méthodes Personnalisées

### Filtrer les Avoirs par Date

```php
public function filterByDate($startDate, $endDate)
{
    return Avoir::whereBetween('date_avoir', [$startDate, $endDate])
        ->with('client', 'products')
        ->get();
}
```

### Obtenir le Total des Avoirs par Client

```php
public function totalByClient($clientId)
{
    return Avoir::where('client_id', $clientId)
        ->where('status', 'valide')
        ->sum('total_ttc');
}
```

### Générer un Rapport d'Avoirs

```php
public function rapport($startDate, $endDate)
{
    $avoirs = Avoir::whereBetween('date_avoir', [$startDate, $endDate])
        ->with('client')
        ->get();
    
    return [
        'total_avoirs' => $avoirs->count(),
        'total_amount' => $avoirs->sum('total_ttc'),
        'by_status' => $avoirs->groupBy('status')->map->count(),
        'by_client' => $avoirs->groupBy('client_id')->map->sum('total_ttc')
    ];
}
```

---

## 4. Routes Personnalisées

### Routes CRUD Complètes

```php
Route::middleware('auth')->group(function () {
    // Standard CRUD
    Route::resource('avoirs', AvoirController::class);
    
    // Routes supplémentaires
    Route::get('avoirs/{avoir}/pdf', [AvoirController::class, 'pdf'])
        ->name('avoirs.pdf');
    
    Route::post('/get-document-articles', [AvoirController::class, 'getDocumentArticles'])
        ->name('get-document-articles');
    
    // Routes personnalisées
    Route::get('avoirs/{client}/by-client', [AvoirController::class, 'byClient'])
        ->name('avoirs.by-client');
    
    Route::get('avoirs-rapport/{startDate}/{endDate}', [AvoirController::class, 'rapport'])
        ->name('avoirs.rapport');
});
```

---

## 5. Modèle - Relations et Accesseurs

### Relations Complètes

```php
class Avoir extends Model
{
    // Définir les relations
    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function bonLivraison()
    {
        return $this->belongsTo(BonLivraison::class);
    }

    public function facture()
    {
        return $this->belongsTo(Facture::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'avoir_products')
            ->withPivot('quantity', 'unit_price', 'total', 'motif_retour');
    }

    // Accesseurs
    public function getFormattedTotalAttribute()
    {
        return number_format($this->total_ttc, 2, ',', ' ') . ' €';
    }

    public function getTvaAmountAttribute()
    {
        return ($this->total_ht * $this->tva) / 100;
    }
}
```

---

## 6. Validation Personnalisée

### Rules Personnalisées pour Avoirs

```php
public function storeRules()
{
    return [
        'client_id' => 'required|exists:clients,id',
        'date_avoir' => 'required|date|before_or_equal:today',
        'tva' => 'required|numeric|between:0,100',
        'products' => 'required|array|min:1',
        'products.*.product_id' => 'required|integer|exists:products,id',
        'products.*.quantity' => 'required|integer|min:1|max:1000',
        'products.*.unit_price' => 'required|numeric|min:0',
    ];
}
```

---

## 7. Événements et Listeners

### Event lors de Création d'Avoir

```php
use App\Events\AvoirCreated;

class AvoirController extends Controller
{
    public function store(Request $request)
    {
        $avoir = Avoir::create($request->validated());
        
        // Déclencher l'événement
        event(new AvoirCreated($avoir));
        
        return redirect()->route('avoirs.index');
    }
}
```

### Listener pour envoyer Email

```php
class SendAvoirEmailListener
{
    public function handle(AvoirCreated $event)
    {
        Mail::send(new AvoirCreatedMail($event->avoir));
    }
}
```

---

## 8. Tests Unitaires

### Test Création d'Avoir

```php
namespace Tests\Feature;

use Tests\TestCase;
use App\Models\Avoir;
use App\Models\Client;

class AvoirTest extends TestCase
{
    public function test_create_avoir()
    {
        $client = Client::factory()->create();
        
        $response = $this->post('/avoirs', [
            'client_id' => $client->id,
            'date_avoir' => now(),
            'tva' => 20,
            'products' => [
                [
                    'product_id' => 1,
                    'quantity' => 2,
                    'unit_price' => 50,
                ]
            ]
        ]);
        
        $this->assertDatabaseHas('avoirs', [
            'client_id' => $client->id,
            'total_ttc' => 120
        ]);
    }

    public function test_generate_pdf()
    {
        $avoir = Avoir::factory()->create();
        
        $response = $this->get("/avoirs/{$avoir->id}/pdf");
        
        $this->assertEquals(200, $response->status());
    }
}
```

---

## 9. Export de Données

### Export Avoirs en Excel

```php
use Maatwebsite\Excel\Facades\Excel;

class AvoirController extends Controller
{
    public function export($startDate, $endDate)
    {
        $avoirs = Avoir::whereBetween('date_avoir', [$startDate, $endDate])
            ->with('client', 'products')
            ->get();
        
        return Excel::download(
            new AvoirsExport($avoirs),
            'avoirs.xlsx'
        );
    }
}
```

### Classe Export

```php
class AvoirsExport implements FromCollection
{
    private $avoirs;
    
    public function __construct($avoirs)
    {
        $this->avoirs = $avoirs;
    }
    
    public function collection()
    {
        return $this->avoirs->map(function ($avoir) {
            return [
                'Numéro' => $avoir->numero_avoir,
                'Client' => $avoir->client->name,
                'Date' => $avoir->date_avoir,
                'Total HT' => $avoir->total_ht,
                'TVA' => $avoir->tva,
                'Total TTC' => $avoir->total_ttc,
                'Statut' => $avoir->status,
            ];
        });
    }
}
```

---

## 10. Utilities et Helpers

### Helper pour Générer Numéro Avoir

```php
namespace App\Helpers;

use App\Models\Avoir;

class AvoirHelper
{
    public static function generateNumero()
    {
        $annee = date('Y');
        $nextNum = Avoir::count() + 1;
        return 'AV' . str_pad($nextNum, 3, '0', STR_PAD_LEFT) . '/' . substr($annee, -2);
    }
    
    public static function getTotalByStatus($status)
    {
        return Avoir::where('status', $status)->sum('total_ttc');
    }
}
```

### Utilisation

```php
use App\Helpers\AvoirHelper;

$numero = AvoirHelper::generateNumero();
$total = AvoirHelper::getTotalByStatus('valide');
```

---

## Bonnes Pratiques

### ✅ À Faire

```php
// Charger les relations nécessaires
$avoir = Avoir::with('client', 'products')->find($id);

// Utiliser des scopes pour les requêtes répétées
$avoirs = Avoir::valid()->recent()->get();

// Paginer les gros resultsets
$avoirs = Avoir::paginate(15);

// Utiliser des transactions pour les opérations critiques
DB::transaction(function () {
    $avoir->save();
    $avoir->products()->sync($products);
});
```

### ❌ À Éviter

```php
// Ne pas charger toutes les relations
$avoir = Avoir::find($id); // Sans with()

// Ne pas faire de boucles de requêtes (N+1)
foreach ($avoirs as $avoir) {
    echo $avoir->client->name; // Requête par itération!
}

// Ne pas oublier les validations
$avoir->update($request->all()); // Sans validation!
```

---

## Ressources Supplémentaires

- Laravel Eloquent: https://laravel.com/docs/eloquent
- DomPDF: https://github.com/barryvdh/laravel-dompdf
- AJAX avec jQuery: https://api.jquery.com/jquery.ajax/
- Tests Laravel: https://laravel.com/docs/testing

Bonne programmation! 🚀
