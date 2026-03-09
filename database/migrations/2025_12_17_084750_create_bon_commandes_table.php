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
        Schema::create('bon_commandes', function (Blueprint $table) {
            $table->id();
            $table->string('numero_bon_commande')->unique();
            $table->string('fournisseur'); // Nom du fournisseur
            $table->date('date_commande');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20.00);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['en_cours', 'recu', 'annule'])->default('en_cours');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bon_commandes');
    }
};
