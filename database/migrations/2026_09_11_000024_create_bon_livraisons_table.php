<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('bon_livraisons', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_bon_livraison');
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->foreignId('bon_commande_id')->nullable()->constrained('bon_commandes')->nullOnDelete();
            $table->date('date_livraison');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['en_attente','livre','annule'])->default('en_attente');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'numero_bon_livraison']);
            $table->index(['entreprise_id', 'client_id', 'date_livraison']);
            $table->index(['entreprise_id', 'status', 'date_livraison']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bon_livraisons');
    }
};
