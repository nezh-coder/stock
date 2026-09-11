<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FactureController;
use App\Http\Controllers\DevisController;
use App\Http\Controllers\BonCommandeController;
use App\Http\Controllers\BonLivraisonController;
use App\Http\Controllers\ReglementFournisseurController;
use App\Http\Controllers\AvoirController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\FournisseurController;
use App\Http\Controllers\AchatController;
use App\Http\Controllers\BonComAchatController;
use App\Http\Controllers\UniteController;
use App\Http\Controllers\ReglementClientController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', [App\Http\Controllers\DashboardController::class, 'index'])->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get('categories/import1', [CategoryController::class, 'import1'])
        ->name('categories.import1'); // Blade to show upload form
        Route::get('unites/import1', [UniteController::class, 'import1'])
        ->name('unites.import1'); // Blade to show upload form

  Route::resource('categories', \App\Http\Controllers\CategoryController::class);
  Route::post('/categories/store-live', [\App\Http\Controllers\CategoryController::class, 'store_live'])
     ->name('categories.store_live');
     Route::resource('unites', \App\Http\Controllers\UniteController::class);
     Route::post('/unites/store-live', [\App\Http\Controllers\UniteController::class, 'store_live'])
        ->name('unites.store_live');
     
   Route::get('products/inventaire', [ProductController::class, 'inventaire'])
    ->name('products.inventaire');
    Route::post('products/import', [ProductController::class, 'import'])
        ->name('products.import');
    Route::get('categories', [CategoryController::class, 'index'])
    ->name('categories.index');
 
Route::post('categories/import', [CategoryController::class, 'import'])
    ->name('categories.import'); // Process the file and redirect
    Route::post('unites/import', [UniteController::class, 'import'])
    ->name('unites.import'); // Process the file and redirect
   

/*Route::get('/products/inventaire', [ProductController::class, 'export'])
    ->name('products.inventaire');*/

 Route::resource('products', \App\Http\Controllers\ProductController::class);
  Route::post('clients/import', [ClientController::class, 'import'])
        ->name('clients.import');
     Route::resource('clients', \App\Http\Controllers\ClientController::class);
    Route::get('/api/products/{id}/last-purchase-price', [\App\Http\Controllers\Api\ProductController::class, 'lastPurchasePrice']);
        Route::get('products/{id}/movement', [\App\Http\Controllers\ProductController::class, 'movement'])->name('products.movement');
    Route::get('/api/products/{id}/info', [\App\Http\Controllers\Api\ProductInfoController::class, 'info']);
    Route::resource('fournisseurs', \App\Http\Controllers\FournisseurController::class);
    Route::post('fournisseurs/import', [FournisseurController::class, 'import'])
        ->name('fournisseurs.import');
     Route::post('bon-com-achats/{bon_com_achat}/transfer', [App\Http\Controllers\BonComAchatController::class, 'transfer'])->name('bon-com-achats.transfer'); 
    Route::resource('bon-com-achats', \App\Http\Controllers\BonComAchatController::class);
   
     Route::resource('achats', \App\Http\Controllers\AchatController::class);
   Route::get('devis/{devi}/print', [DevisController::class,'print'])->name('devis.print');
   Route::get('devis/{devi}/pdf', [DevisController::class,'pdf'])->name('devis.pdf');
   Route::get('devis/{devi}/a5', [DevisController::class,'a5'])->name('devis.a5');
    Route::get('bon-livraisons/{BonLivraison}/pdf', [BonLivraisonController::class,'pdf'])->name('bon-livraisons.pdf');
   
    Route::resource('devis', \App\Http\Controllers\DevisController::class);
    Route::post('devis/{devis}/transfer', [App\Http\Controllers\DevisController::class, 'transfer'])->name('devis.transfer');
    Route::resource('bon-commandes', \App\Http\Controllers\BonCommandeController::class);
    Route::post('bon-commandes/{bon_commande}/transfer', [App\Http\Controllers\BonCommandeController::class, 'transfer'])->name('bon-commandes.transfer');
    Route::resource('bon-livraisons', \App\Http\Controllers\BonLivraisonController::class);
    Route::post('bon-livraisons/{bon_livraison}/transfer', [App\Http\Controllers\BonLivraisonController::class, 'transfer'])->name('bon-livraisons.transfer');
    Route::get('bon-livraisons/get-products/{bon_commande_id}', [App\Http\Controllers\BonLivraisonController::class, 'getBonCommandeProducts'])->name('bon-livraisons.get-products');
    // routes/web.php
  Route::get('factures/{facture}/pdf', [FactureController::class, 'pdf'])
    ->name('factures.pdf');

    Route::resource('factures', \App\Http\Controllers\FactureController::class);
    Route::resource('avoirs', \App\Http\Controllers\AvoirController::class);
    Route::get('avoirs/{avoir}/pdf', [App\Http\Controllers\AvoirController::class, 'pdf'])->name('avoirs.pdf');
    Route::post('/get-document-articles', [App\Http\Controllers\AvoirController::class, 'getDocumentArticles'])->name('get-document-articles');
    Route::get('/get-client-documents', [App\Http\Controllers\AvoirController::class, 'getClientDocuments'])->name('get-client-documents');
    Route::resource('reglements', \App\Http\Controllers\ReglementFournisseurController::class);
    Route::get('reglements/export/pdf', [\App\Http\Controllers\ReglementFournisseurController::class, 'exportPdf'])->name('reglements.export.pdf');
       
    Route::get('/fournisseur/{id}/bons-non-payes', [ReglementFournisseurController::class, 'bonsNonPayes']);
    Route::get('/reglements/{id}', [ReglementFournisseurController::class, 'show'])
    ->name('reglements.show');
    
    Route::get(
    '/fournisseur/{fournisseur}/bons-edit/{reglement}',
    [ReglementFournisseurController::class,'bonsForEdit']
);
  Route::resource('paiements', \App\Http\Controllers\ReglementClientController::class);
   Route::get(
    '/client/{client}/factures-edit/{reglement}',
    [ReglementClientController::class,'facturesForEdit']
);
 Route::get('paiements/export/pdf', [\App\Http\Controllers\ReglementClientController::class, 'exportPdf'])->name('paiements.export.pdf');
   
  Route::get('/client/{id}/factures-non-payees', [ReglementClientController::class, 'facturesNonPayees']);
   
    });
    require __DIR__.'/auth.php';
