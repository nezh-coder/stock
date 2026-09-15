<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('achats', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_achat');
            $table->unsignedInteger('num');
            $table->year('annee');
            $table->foreignId('fournisseur_id')->constrained('fournisseurs')->restrictOnDelete();
            $table->date('date_commande');
            $table->date('date_echeance')->nullable();
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->decimal('montant_paye', 10, 2)->default(0);
            $table->decimal('reste_a_payer', 10, 2)->default(0);
            $table->enum('status', ['en_cours','partiellement_paye','paye','annule'])->default('en_cours');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'annee', 'num']);
            $table->index(['entreprise_id', 'fournisseur_id', 'date_commande']);
            $table->index(['entreprise_id', 'status', 'date_commande']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('achats');
    }
};
