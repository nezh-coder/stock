# FAQ - Système d'Avoirs

## Questions Générales

### Q1: Comment créer un avoir?

**R**: Allez à **Avoirs > Créer un Avoir**. Sélectionnez un client, une date, et choisissez une source (Bon de Livraison ou Facture). Ajoutez les articles à retourner et cliquez sur "Créer l'Avoir".

---

### Q2: Puis-je créer un avoir sans document source?

**R**: Oui! Vous pouvez créer un avoir sans Bon de Livraison ni Facture. Ajoutez simplement les articles manuellement en utilisant le bouton "Ajouter un article".

---

### Q3: Comment sélectionner plusieurs articles depuis une facture?

**R**: Sélectionnez la facture dans le formulaire. Les articles s'affichent automatiquement. Pour chaque article, saisissez la quantité à retourner et cliquez sur "Ajouter". Répétez pour chaque article.

---

### Q4: Puis-je modifier un avoir après création?

**R**: Oui! Cliquez sur l'icône "Modifier" (crayon) dans la liste des avoirs. Vous pouvez modifier les informations et les articles.

---

## Questions Techniques

### Q5: Comment générer le PDF?

**R**: Deux méthodes:
1. **Depuis la liste**: Cliquez sur l'icône PDF (rouge) dans la colonne Actions
2. **Depuis les détails**: Cliquez sur "Télécharger PDF" en haut ou en bas de page

---

### Q6: Pourquoi le PDF n'apparaît-il pas?

**R**: Vérifiez:
- Que DomPDF est installé: `composer require barryvdh/laravel-dompdf`
- Que l'image `public/images/devis_bg.jpg` existe
- Que les logs n'affichent pas d'erreurs: `storage/logs/laravel.log`

---

### Q7: Comment personnaliser le template PDF?

**R**: Modifiez `resources/views/avoirs/pdf/pdf.blade.php`:
- Couleurs: Cherchez `#d9534f` (rouge)
- Texte: Cherchez les `<h1>`, `<p>` etc.
- Layout: Modifiez le CSS `@page`, les tables, les divs

---

### Q8: Les calculs sont incorrects. Comment?

**R**: Vérifiez:
- La quantité saisie (doit être > 0)
- Le prix unitaire (doit être valide)
- Le taux TVA (par défaut 20%)
- Les calculs JavaScript en ouvrant la console (F12)

---

### Q9: L'AJAX ne fonctionne pas. Pourquoi?

**R**: Vérifiez:
- Que jQuery est chargé
- Que le token CSRF est présent: `@csrf`
- Les erreurs JavaScript en console (F12)
- Que la route POST `/get-document-articles` existe

---

### Q10: Comment augmenter le nombre d'articles affichés?

**R**: En PHP (contrôleur):
```php
public function index(Request $request)
{
    $avoirs = Avoir::paginate(25); // Augmenter de 15 à 25
}
```

---

## Questions Stock

### Q11: Le stock est-il augmenté quand je retourne un article?

**R**: Oui! Automatiquement lors de la création de l'avoir:
```php
Product::find($product_id)->increment('quantity', $quantity);
```

---

### Q12: Puis-je retourner plus que la quantité originale?

**R**: Non. L'interface l'empêche (max = quantité originale). Mais vous pouvez le faire manuellement si vous le souhaitez.

---

### Q13: Qu'advient-il du stock si je supprime un avoir?

**R**: Le stock n'est **pas** diminué. Vous devez le faire manuellement si nécessaire.

---

## Questions Statut

### Q14: Qu'est-ce que les différents statuts?

**R**:
- **en_cours**: Nouvel avoir, en attente de traitement
- **valide**: Avoir validé et traité
- **annule**: Avoir annulé (non pris en compte)

---

### Q15: Comment valider un avoir?

**R**: Cliquez sur Modifier, changez le statut de "en_cours" à "valide", et enregistrez.

---

### Q16: Puis-je annuler un avoir?

**R**: Oui! Cliquez sur Modifier, changez le statut à "annule".

---

## Questions Numérotation

### Q17: Comment fonctionne la numérotation des avoirs?

**R**: Format: `AV{XXX}/{YY}`
- **AV** = Préfixe
- **XXX** = Numéro séquentiel (001, 002, 003...)
- **YY** = Année sur 2 chiffres (25 pour 2025)

Exemple: `AV001/25`, `AV002/25`, etc.

---

### Q18: Puis-je personnaliser le numéro?

**R**: Oui. Modifiez la méthode `store()` dans `AvoirController`:
```php
$numero_avoir = 'AV-' . date('Y') . '-' . rand(1000, 9999);
```

---

## Questions Impressions

### Q19: Puis-je imprimer directement depuis le navigateur?

**R**: Oui! Depuis le PDF:
1. Téléchargez le PDF
2. Ouvrez-le
3. Utilisez Ctrl+P ou le bouton Imprimer

Ou générez le PDF en mode "print" en modifiant le contrôleur.

---

### Q20: Le PDF a une mauvaise mise en page. Comment réparer?

**R**:
1. Vérifiez que l'image de fond existe
2. Testez avec une autre page
3. Modifiez le CSS dans `pdf.blade.php`
4. Contrôlez la marge: `@page { margin: 120px 40px 100px 40px; }`

---

## Questions Données

### Q21: Comment exporter les avoirs en Excel?

**R**: Installez Maatwebsite Excel:
```bash
composer require maatwebsite/excel
```

Puis créez une route et une classe Export (voir EXEMPLES_CODE_AVOIRS.md).

---

### Q22: Puis-je voir les avoirs d'un client spécifique?

**R**: Oui! Accédez à la liste des avoirs et utilisez le champ de recherche ou les filtres.

---

### Q23: Comment générer un rapport d'avoirs?

**R**: Utilisez les filtres:
- Par statut
- Par source (BL ou Facture)
- Par période (date début/fin)

Puis exportez en PDF/Excel.

---

## Questions Permissions

### Q24: Comment contrôler qui peut créer des avoirs?

**R**: Utilisez les policies Laravel:
```php
Gate::define('create-avoir', function (User $user) {
    return $user->role === 'admin';
});
```

---

### Q25: Puis-je donner à un employé la permission de voir mais pas modifier?

**R**: Oui, avec les permissions Laravel:
```php
Route::get('avoirs', [AvoirController::class, 'index'])
    ->middleware('can:view-avoir');
Route::put('avoirs/{avoir}', [AvoirController::class, 'update'])
    ->middleware('can:edit-avoir');
```

---

## Questions Performance

### Q26: Comment optimiser les performances pour beaucoup d'avoirs?

**R**:
1. Utilisez la pagination (défaut: 15 par page)
2. Chargez les relations: `with('client', 'products')`
3. Ajoutez un index sur `client_id` et `status`
4. Utilisez le cache pour les rapports

---

### Q27: L'AJAX est lente. Comment améliorer?

**R**:
1. Vérifiez la connexion réseau
2. Utilisez le cache: `Cache::remember(...)`
3. Réduisez la taille de la réponse JSON
4. Utilisez la compression gzip

---

## Questions Sécurité

### Q28: Comment protéger les avoirs sensibles?

**R**: Utilisez les policies:
```php
Gate::define('view-avoir', function (User $user, Avoir $avoir) {
    return $user->id === $avoir->client->user_id || $user->isAdmin();
});
```

---

### Q29: Est-ce que les PDFs sont sécurisés?

**R**: Les PDFs sont générés à la volée et ne sont pas stockés. Pour plus de sécurité:
- Utilisez HTTPS
- Authentifiez les utilisateurs
- Loggez les téléchargements

---

## Questions Maintenance

### Q30: Comment nettoyer les vieux avoirs?

**R**: Utilisez une commande Artisan:
```php
php artisan command:clean-avoirs --older-than-months=12
```

Ou supprimez-les manuellement:
```php
Avoir::where('status', 'annule')
    ->where('created_at', '<', now()->subMonths(12))
    ->delete();
```

---

### Q31: Où sont stockées les données des avoirs?

**R**: Dans la base de données:
- Table `avoirs`: Données principales
- Table `avoir_products`: Produits retournés

Les PDFs ne sont pas stockés (générés à la volée).

---

### Q32: Comment sauvegarder les avoirs?

**R**: Sauvegardez votre base de données:
```bash
php artisan backup:run
```

Ou manuellement:
```bash
mysqldump -u username -p database_name > backup.sql
```

---

## Dépannage

### Problème: "Client not found"

**Solution**:
1. Vérifiez que le client existe
2. Vérifiez l'ID du client
3. Rechargez la page

---

### Problème: "Articles not loading"

**Solution**:
1. Ouvrez la console (F12)
2. Vérifiez les erreurs JavaScript
3. Vérifiez la requête AJAX en Network
4. Vérifiez le token CSRF

---

### Problème: "PDF blank"

**Solution**:
1. Vérifiez l'image de fond
2. Testez avec un navigateur différent
3. Vérifiez les logs Laravel
4. Vérifiez que Pdf est correctement importé

---

### Problème: "Stock incorrect"

**Solution**:
1. Vérifiez les quantités originales
2. Vérifiez que le produit existe
3. Vérifiez les logs des modifications
4. Recalculez le stock manuellement si nécessaire

---

## Bonnes Pratiques

### ✅ À Faire

1. **Validez toujours les données** côté serveur
2. **Loggez les opérations** importantes
3. **Utilisez les transactions** pour les opérations critiques
4. **Testez les PDFs** sur plusieurs navigateurs
5. **Sauvegardez régulièrement** vos données
6. **Documentez** les changements personnalisés

### ❌ À Éviter

1. **Ne modifiez pas** directement la base de données
2. **Ne supprimez pas** les avoirs validés sans confirmation
3. **Ne changez pas** le format de numérotation sans préavis
4. **Ne désactivez pas** la validation CSRF
5. **Ne laissez pas** les logs grandir indéfiniment

---

## Contacter le Support

Pour plus de questions:
- Consultez **GUIDE_AVOIRS.md**
- Consultez **INSTALLATION_AVOIRS.md**
- Consultez **EXEMPLES_CODE_AVOIRS.md**
- Vérifiez les logs: `storage/logs/laravel.log`
- Contactez votre administrateur système

---

## Glossaire

| Terme | Définition |
|-------|-----------|
| **Avoir** | Facture d'avoir, document de crédit |
| **BL** | Bon de Livraison |
| **HT** | Hors Taxe (prix sans TVA) |
| **TTC** | Toutes Taxes Comprises |
| **TVA** | Taxe sur la Valeur Ajoutée |
| **Pivot** | Table intermédiaire many-to-many |
| **AJAX** | Requête asynchrone sans rechargement page |
| **CSRF** | Cross-Site Request Forgery token |
| **PDF** | Portable Document Format |

---

Dernière mise à jour: Janvier 2025
Version: 2.0
Auteur: Système d'Avoirs Régénéré
