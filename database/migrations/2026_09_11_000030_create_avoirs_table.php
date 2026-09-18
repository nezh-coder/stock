<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('avoirs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_avoir');
             $table->unsignedInteger('num');
            $table->year('annee');
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->foreignId('bon_livraison_id')->nullable()->constrained('bon_livraisons')->nullOnDelete();
            $table->foreignId('facture_id')->nullable()->constrained('factures')->nullOnDelete();
            $table->date('date_avoir');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['en_cours','valide','annule'])->default('en_cours');
            $table->text('motif')->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'numero_avoir']);
            $table->index(['entreprise_id', 'client_id', 'date_avoir']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('avoirs');
    }
};
