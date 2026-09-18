<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('bon_commandes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_bon_commande');
            $table->unsignedInteger('num');
            $table->year('annee');
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->date('date_commande');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->foreignId('devis_id')->nullable()->constrained('devis')->nullOnDelete();
            $table->enum('status', ['en_cours','recu','annule'])->default('en_cours');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'annee', 'num']);
            $table->index(['entreprise_id', 'client_id', 'date_commande']);
            $table->index(['entreprise_id', 'status', 'date_commande']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bon_commandes');
    }
};
