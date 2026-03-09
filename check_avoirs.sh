#!/bin/bash
# Script de vérification du système d'avoirs

echo "================================"
echo "Vérification du Système d'Avoirs"
echo "================================"
echo ""

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Compteurs
CHECKS_PASSED=0
CHECKS_FAILED=0

# Fonction pour vérifier un fichier
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $2"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC} $2 - Fichier manquant: $1"
        ((CHECKS_FAILED++))
    fi
}

# Fonction pour vérifier une ligne de code
check_contains() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $3"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC} $3 - Non trouvé dans $1"
        ((CHECKS_FAILED++))
    fi
}

echo "1. Vérification des fichiers..."
echo ""

check_file "app/Http/Controllers/AvoirController.php" "Contrôleur AvoirController"
check_file "resources/views/avoirs/create.blade.php" "Vue create.blade.php"
check_file "resources/views/avoirs/show.blade.php" "Vue show.blade.php"
check_file "resources/views/avoirs/index.blade.php" "Vue index.blade.php"
check_file "resources/views/avoirs/edit.blade.php" "Vue edit.blade.php"
check_file "resources/views/avoirs/pdf/pdf.blade.php" "Template PDF"

echo ""
echo "2. Vérification des migrations..."
echo ""

check_file "database/migrations/2025_12_26_101427_create_avoirs_table.php" "Migration table avoirs"
check_file "database/migrations/2025_12_26_101435_create_avoir_products_table.php" "Migration table avoir_products"

echo ""
echo "3. Vérification des routes..."
echo ""

check_contains "routes/web.php" "avoirs.pdf" "Route pour PDF"
check_contains "routes/web.php" "get-document-articles" "Route AJAX pour articles"

echo ""
echo "4. Vérification du contrôleur..."
echo ""

check_contains "app/Http/Controllers/AvoirController.php" "public function pdf" "Méthode pdf"
check_contains "app/Http/Controllers/AvoirController.php" "public function getDocumentArticles" "Méthode getDocumentArticles"
check_contains "app/Http/Controllers/AvoirController.php" "Pdf::loadView" "Intégration DomPDF"

echo ""
echo "5. Vérification des vues..."
echo ""

check_contains "resources/views/avoirs/create.blade.php" "loadDocumentProducts" "Fonction AJAX JavaScript"
check_contains "resources/views/avoirs/create.blade.php" "avoirForm" "Formulaire avec validation"
check_contains "resources/views/avoirs/pdf/pdf.blade.php" "numero_avoir" "Template PDF correct"

echo ""
echo "================================"
echo "Résumé:"
echo -e "${GREEN}✓ Vérifications réussies: $CHECKS_PASSED${NC}"
if [ $CHECKS_FAILED -gt 0 ]; then
    echo -e "${RED}✗ Vérifications échouées: $CHECKS_FAILED${NC}"
else
    echo -e "${GREEN}✗ Vérifications échouées: $CHECKS_FAILED${NC}"
fi
echo "================================"
echo ""

if [ $CHECKS_FAILED -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Certains fichiers ou configurations sont manquants.${NC}"
    echo "Assurez-vous que:"
    echo "1. Les migrations ont été exécutées (php artisan migrate)"
    echo "2. Les fichiers de vue sont en place"
    echo "3. Les routes sont correctement définies"
    exit 1
else
    echo -e "${GREEN}✓ Tous les fichiers et configurations sont en place!${NC}"
    echo ""
    echo "Prochaines étapes:"
    echo "1. Vérifiez que les migrations sont exécutées: php artisan migrate"
    echo "2. Testez la page: http://localhost/avoirs"
    echo "3. Créez un nouvel avoir pour tester"
    echo ""
    echo "Documentation:"
    echo "- Voir GUIDE_AVOIRS.md pour l'utilisation"
    echo "- Voir CHANGELOG_AVOIRS.md pour les changements"
    exit 0
fi
