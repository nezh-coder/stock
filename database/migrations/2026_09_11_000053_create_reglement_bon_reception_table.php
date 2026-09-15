<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Conservée pour compatibilité avec l'ancien projet.
        // La BDD source ne contient pas de table bon_receptions,
        // donc aucune FK bon_reception_id n'est créée ici.
        Schema::create('reglement_bon_reception', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('reglement_id');
            $table->unsignedBigInteger('bon_reception_id');
            $table->timestamps();

            $table->index(['entreprise_id', 'reglement_id']);
            $table->index('bon_reception_id');
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
            $table->foreign('reglement_id')->references('id')->on('reglements_fournisseurs')->cascadeOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reglement_bon_reception');
    }
};
