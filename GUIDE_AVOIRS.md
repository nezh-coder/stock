# Guide du Système d'Avoirs - Facture d'Avoir

## Vue d'ensemble

Le système d'avoirs (facture d'avoir) a été complètement régénéré avec les fonctionnalités suivantes:

### Fonctionnalités principales

1. **Retour d'articles depuis Bon de Livraison ou Facture**
   - Sélectionnez un Bon de Livraison ou une Facture comme source
   - Visualisez tous les articles disponibles pour retour
   - Sélectionnez les articles et quantités à retourner
   - Système de requête AJAX pour charger dynamiquement les articles

2. **Gestion flexible des articles**
   - Ajout manuel d'articles (même sans document source)
   - Sélection depuis un document existant
   - Modification des quantités retournées
   - Ajout de motifs de retour individuels par article

3. **Génération de facture d'avoir en PDF**
   - Template PDF professionnel
   - Présentation identique au modèle de facture
   - Référence du document source (BL ou Facture)
   - Calculs automatiques (HT, TVA, TTC)
   - Montant en lettres

## Flux d'utilisation

### Créer un nouvel Avoir

1. Accédez à **Avoirs > Créer un Avoir**

2. **Informations générales**:
   - Sélectionnez le client
   - Choisissez la date de l'avoir
   - Définissez le taux de TVA

3. **Sélectionner une source** (optionnel):
   - **Bon de Livraison**: Pour retourner des articles livrés
   - **Facture**: Pour retourner des articles facturés
   - La liste des articles du document s'affiche automatiquement

4. **Articles disponibles pour retour**:
   - Visualisez les articles du document source
   - Saisissez la quantité à retourner
   - Ajoutez un motif de retour
   - Cliquez sur **+ Ajouter un article** pour l'ajouter à la liste de retour

5. **Articles à retourner**:
   - Liste complète des articles retournés
   - Quantité et prix unitaire
   - Total automatique par article
   - Motif de retour personnalisé

6. **Informations supplémentaires**:
   - Motif général du retour
   - Notes supplémentaires

7. Cliquez sur **Créer l'Avoir** pour valider

### Consulter un Avoir

1. Accédez à **Avoirs** pour voir la liste
2. Cliquez sur le numéro ou l'œil pour voir les détails
3. La page montre:
   - Informations générales (numéro, client, dates)
   - Documents référencés (BL ou Facture)
   - Total HT, TVA et TTC
   - Liste complète des articles retournés

### Générer un PDF d'Avoir

#### Depuis la liste d'Avoirs:
- Cliquez sur l'icône **PDF** (en rouge) dans la colonne Actions

#### Depuis la page de détails:
- Cliquez sur **Télécharger PDF** (bouton rouge en haut)
- Ou cliquez sur l'icône **PDF** en bas de page

Le PDF contient:
- Numéro et date de l'avoir
- Informations du fournisseur et client
- Références au document source (BL ou Facture)
- Tableau des articles retournés avec quantités et prix
- Montant total HT, TVA et TTC
- Montant en lettres

## Structure des données

### Modèle Avoir

```
- numero_avoir (string): Numéro unique de l'avoir
- client_id (FK): Client concerné
- bon_livraison_id (FK, nullable): Bon de Livraison source
- facture_id (FK, nullable): Facture source
- date_avoir (date): Date de l'avoir
- total_ht (decimal): Total hors taxe
- tva (decimal): Taux TVA (%)
- total_ttc (decimal): Total TTC
- status (enum): en_cours, valide, annule
- motif (text): Motif général du retour
- notes (text): Notes supplémentaires
- products (pivot): Relation many-to-many avec pivot:
  - quantity: Quantité retournée
  - unit_price: Prix unitaire
  - total: Total du ligne
  - motif_retour: Motif spécifique du retour
```

## Routes principales

- `GET /avoirs` - Liste des avoirs
- `GET /avoirs/create` - Formulaire de création
- `POST /avoirs` - Enregistrer un nouvel avoir
- `GET /avoirs/{avoir}` - Détails de l'avoir
- `GET /avoirs/{avoir}/edit` - Formulaire d'édition
- `PUT /avoirs/{avoir}` - Mettre à jour l'avoir
- `DELETE /avoirs/{avoir}` - Supprimer l'avoir
- `GET /avoirs/{avoir}/pdf` - Télécharger le PDF
- `POST /get-document-articles` - AJAX pour charger les articles d'un document

## Fonctionnalités AJAX

### Chargement dynamique des articles

Lorsque vous sélectionnez un Bon de Livraison ou une Facture, une requête AJAX:
1. Récupère les articles du document
2. Affiche un tableau avec les articles disponibles
3. Permet de saisir la quantité à retourner
4. Permet d'ajouter un motif de retour
5. Ajoute automatiquement à la liste des retours

## Calculs automatiques

- **Total par ligne**: Quantité × Prix unitaire
- **Total HT**: Somme de tous les totaux de lignes
- **Total TVA**: Total HT × Taux TVA / 100
- **Total TTC**: Total HT + Total TVA

Les calculs se mettent à jour en temps réel lors de modifications.

## Notes importantes

1. **Numérotation**: Les numéros d'avoir sont générés automatiquement au format: `AV001/25` (pour l'année en cours)

2. **Stock**: Le retour d'articles augmente automatiquement le stock disponible

3. **Documents source**: Vous pouvez créer un avoir sans document source (articles personnalisés)

4. **TVA**: Le taux TVA est défini lors de la création (par défaut 20%)

5. **Statuts**: 
   - `en_cours`: Nouvel avoir, en traitement
   - `valide`: Avoir validé/traité
   - `annule`: Avoir annulé

## Personnalisation

### Couleurs du PDF
Le template PDF utilise la couleur rouge (#d9534f) pour distinguer les avoirs des factures.

### Modèle des lettres
Le montant en lettres utilise la classe `ChiffreEnLettre` existante du système.

### Image de fond
Utilise l'image `devis_bg.jpg` (identique à celle des factures).
