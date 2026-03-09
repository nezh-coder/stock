<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bon_com_achats', function (Blueprint $table) {
            $table->id();
             $table->integer('num'); 
              $table->year('annee'); // Numéro unique du devis
           
             $table->string('numero_bc_achat')->unique(); // Numéro unique du devis
            $table->foreignId('fournisseur_id')->constrained('fournisseurs')->onDelete('cascade'); // Fournisseur
            $table->date('date_bc_achat');
            $table->decimal('total_ht', 10, 2); // Total hors taxe
            $table->decimal('tva', 5, 2)->default(20.00); // TVA en %
            $table->decimal('total_ttc', 10, 2); // Total TTC
            $table->enum('status', ['brouillon', 'envoye', 'accepte', 'refuse'])->default('brouillon');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bon_com_achats');
    }
};
