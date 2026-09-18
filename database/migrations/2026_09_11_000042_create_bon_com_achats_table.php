<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('bon_com_achats', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedInteger('num');
            $table->year('annee');
            $table->string('numero_bc_achat');
            $table->foreignId('fournisseur_id')->constrained('fournisseurs')->restrictOnDelete();
            $table->date('date_bc_achat');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['brouillon','envoye','accepte','refuse'])->default('brouillon');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'annee', 'num']);
            $table->index(['entreprise_id', 'fournisseur_id', 'date_bc_achat']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bon_com_achats');
    }
};
