<?php
namespace App\Helpers;
class ChiffreEnLettre
{
    private $chiffre = array(
        0 => "zéro", 1 => "un", 2 => "deux", 3 => "trois", 4 => "quatre", 5 => "cinq",
        6 => "six", 7 => "sept", 8 => "huit", 9 => "neuf", 10 => "dix",
        11 => "onze", 12 => "douze", 13 => "treize", 14 => "quatorze", 15 => "quinze", 16 => "seize",
        17 => "dix-sept", 18 => "dix-huit", 19 => "dix-neuf", 20 => "vingt",
        30 => "trente", 40 => "quarante", 50 => "cinquante", 60 => "soixante",
        70 => "soixante-dix", 80 => "quatre-vingts", 90 => "quatre-vingt-dix"
    );

   public function Conversion($saisie)
{
    // Supprimer les séparateurs de milliers ( , ou espace )
    $saisie = str_replace([' ', ','], ['', ''], trim($saisie));

    // Assurer le point pour les décimales
    $saisie = str_replace(',', '.', $saisie);

    $parts = explode('.', $saisie);

    $integerPart = (int) $parts[0];
    $decimalPart = isset($parts[1])
        ? (int) str_pad(substr($parts[1], 0, 2), 2, "0", STR_PAD_RIGHT)
        : 0;

    $result = $this->convertGrandNombre($integerPart) . " dirham" . ($integerPart > 1 ? "s" : "");

    if ($decimalPart > 0) {
        $result .= " et " . $this->convertNombre($decimalPart) . " centime" . ($decimalPart > 1 ? "s" : "");
    }

    return ucfirst(trim($result));
}


    private function convertGrandNombre($nombre)
    {
        if ($nombre == 0) {
            return $this->chiffre[0];
        }

        $result = "";

        if ($nombre >= 1000000) {
            $millions = floor($nombre / 1000000);
            $result .= $this->convertNombre($millions) . " million" . ($millions > 1 ? "s" : "");
            $nombre %= 1000000;
            if ($nombre > 0) $result .= " ";
        }

        if ($nombre >= 1000) {
            $milliers = floor($nombre / 1000);
            if ($milliers == 1) {
                $result .= "mille";
            } else {
                $result .= $this->convertNombre($milliers) . " mille";
            }
            $nombre %= 1000;
            if ($nombre > 0) $result .= " ";
        }

        if ($nombre > 0) {
            $result .= $this->convertNombre($nombre);
        }

        return $result;
    }

    private function convertNombre($nombre)
{
    $result = "";

    if ($nombre < 20) {
        $result = $this->chiffre[$nombre];
    } elseif ($nombre < 100) {
        if ($nombre < 70 || ($nombre >= 80 && $nombre < 90)) {
            $dizaine = floor($nombre / 10) * 10;
            $unite = $nombre % 10;

            if ($unite == 1 && ($dizaine != 80)) {
                $result = $this->chiffre[$dizaine] . " et un";
            } else {
                $result = $this->chiffre[$dizaine];
                if ($unite > 0) {
                    $result .= "-" . $this->chiffre[$unite];
                }
            }

            // Remove 's' from 'quatre-vingts' if not exact
            if ($dizaine == 80 && $unite > 0) {
                $result = str_replace("quatre-vingts", "quatre-vingt", $result);
            }

        } else {
            // Cas de 70 à 79
            if ($nombre < 80) {
                $base = 60;
                $remainder = $nombre - 60;
                $result = $this->chiffre[$base] . "-" . $this->convertNombre($remainder);
            }
            // Cas de 90 à 99
            else {
                $base = 80;
                $remainder = $nombre - 80;
                $result = str_replace("quatre-vingts", "quatre-vingt", $this->chiffre[$base]) . "-" . $this->convertNombre($remainder);
            }
        }
    } elseif ($nombre < 1000) {
        $centaine = floor($nombre / 100);
        $reste = $nombre % 100;

        if ($centaine == 1) {
            $result = "cent";
        } else {
            $result = $this->chiffre[$centaine] . " cent";
        }

        if ($reste == 0 && $centaine > 1) {
            $result .= "s"; // "deux cents"
        }

        if ($reste > 0) {
            $result .= " " . $this->convertNombre($reste);
        }
    }

    return trim($result);
}

}
?>
