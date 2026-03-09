# Installation et Configuration - Système d'Avoirs

## ✅ Checklist d'Installation

### 1. Fichiers de Base
- [x] Contrôleur `AvoirController.php` modifié
- [x] Vues Blade créées/modifiées
- [x] Routes ajoutées dans `web.php`
- [x] Template PDF créé

### 2. Base de Données
```bash
# Vérifier que les migrations existent:
php artisan migrate --list

# Si nécessaire, exécuter les migrations:
php artisan migrate
```

Les migrations doivent créer:
- Table `avoirs` avec les colonnes: numero_avoir, client_id, bon_livraison_id, facture_id, date_avoir, total_ht, tva, total_ttc, status, motif, notes
- Table `avoir_products` avec les colonnes: avoir_id, product_id, quantity, unit_price, total, motif_retour

### 3. Dépendances
Assurez-vous que ces packages sont installés:
```bash
composer require barryvdh/laravel-dompdf
```

Les helpers existants doivent être disponibles:
```php
App\Helpers\ChiffreEnLettre  // Pour montant en lettres
App\Models\Entreprise        // Pour informations entreprise
```

### 4. Assets
Vérifiez que l'image de fond existe:
```
public/images/devis_bg.jpg
```

### 5. Permissions
Assurez-vous que l'utilisateur a les permissions pour:
- Créer des avoirs
- Éditer des avoirs
- Supprimer des avoirs
- Télécharger les PDF

## 🧪 Tests Recommandés

### Test 1: Création Simple
1. Allez à `/avoirs/create`
2. Ajoutez manuellement 2-3 articles
3. Cliquez sur "Créer l'Avoir"
4. Vérifiez que l'avoir est créé

### Test 2: Chargement depuis Bon de Livraison
1. Créez un Bon de Livraison avec articles
2. Allez à `/avoirs/create`
3. Sélectionnez le Bon de Livraison
4. Vérifiez que les articles s'affichent
5. Sélectionnez-les et ajoutez-les

### Test 3: Chargement depuis Facture
1. Créez une Facture avec articles
2. Allez à `/avoirs/create`
3. Sélectionnez la Facture
4. Vérifiez que les articles s'affichent

### Test 4: Génération PDF
1. Créez un Avoir avec articles
2. Allez à la page de détail
3. Cliquez sur "Télécharger PDF"
4. Vérifiez le PDF généré

### Test 5: Calculs
1. Créez un Avoir avec:
   - 1 article: 10 € (qty: 2) = 20 €
   - 1 article: 5 € (qty: 3) = 15 €
   - TVA 20%
2. Total HT doit être: 35 €
3. Total TVA doit être: 7 €
4. Total TTC doit être: 42 €

## 🐛 Dépannage

### Erreur: "Method not found"
**Cause**: Les méthodes ne sont pas dans le contrôleur
**Solution**: Vérifiez que `AvoirController.php` contient les méthodes `pdf()` et `getDocumentArticles()`

### Erreur: "Route not found"
**Cause**: Les routes ne sont pas enregistrées
**Solution**: Vérifiez que `routes/web.php` contient les routes pour PDF et AJAX

### Erreur: "Template not found"
**Cause**: Le fichier PDF template n'existe pas
**Solution**: Vérifiez que `resources/views/avoirs/pdf/pdf.blade.php` existe

### AJAX ne fonctionne pas
**Cause**: Le token CSRF manque
**Solution**: Assurez-vous que le formulaire contient `@csrf` ou que la requête AJAX inclut le token

### PDF ne génère pas correctement
**Cause**: Image de fond manquante
**Solution**: Vérifiez que `public/images/devis_bg.jpg` existe

### Montant en lettres manquant
**Cause**: La classe `ChiffreEnLettre` n'est pas trouvée
**Solution**: Vérifiez que `app/Helpers/ChiffreEnLettre.php` existe et est correctement importée

## 📋 Configuration Recommandée

### Taux TVA
Par défaut: 20% (modifiable lors de la création)

### Numérotation
Format: `AV{XXX}/{YY}` où:
- XXX = Numéro séquentiel (000-999)
- YY = Année sur 2 chiffres

### Status
- `en_cours`: Avoir nouvellement créé
- `valide`: Avoir traité
- `annule`: Avoir annulé

## 🔐 Sécurité

### Authentification
Tous les routes d'avoir requièrent une authentification

### CSRF Protection
Toutes les mutations POST/PUT/DELETE requièrent un token CSRF valide

### Autorisation
À implémenter selon vos besoins:
```php
$this->authorize('view', $avoir);
$this->authorize('update', $avoir);
$this->authorize('delete', $avoir);
```

## 📚 Documentation Supplémentaire

- **GUIDE_AVOIRS.md**: Guide complet d'utilisation
- **CHANGELOG_AVOIRS.md**: Historique des changements

## 🚀 Optimisations Futures

1. **Cache**: Ajouter du cache pour les documents source
2. **Queue**: Générer les PDF en arrière-plan
3. **Export Excel**: Exporter les avoirs en Excel
4. **Email**: Envoyer automatiquement les PDFs par email
5. **Historique**: Tracker les modifications d'avoir
6. **Remboursement**: Gérer les remboursements liés aux avoirs

## 📞 Support

En cas de problème:
1. Vérifiez les logs: `storage/logs/laravel.log`
2. Exécutez: `php artisan config:clear && php artisan cache:clear`
3. Consultez le guide d'installation
4. Vérifiez que toutes les dépendances sont installées

## ✨ Fonctionnalités Actuelles

✅ Création d'avoir  
✅ Édition d'avoir  
✅ Suppression d'avoir  
✅ Sélection articles depuis BL  
✅ Sélection articles depuis Facture  
✅ Ajout manuel d'articles  
✅ Calculs automatiques  
✅ Génération PDF  
✅ Téléchargement PDF  
✅ Motifs de retour personnalisés  
✅ Recherche et filtres  
✅ Responsive design  

## 🎯 Points Clés à Retenir

1. **Les migrations doivent être exécutées** pour créer les tables
2. **DomPDF doit être installé** pour générer les PDF
3. **L'image de fond doit exister** pour que le PDF s'affiche correctement
4. **Les routes doivent être enregistrées** pour accéder aux fonctionnalités
5. **CSRF token** est requis pour tous les formulaires

Bonne utilisation du système d'avoirs! 🎉
