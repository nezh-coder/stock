<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('factures', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_facture');
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->foreignId('bon_livraison_id')->nullable()->constrained('bon_livraisons')->nullOnDelete();
            $table->date('date_facture');
            $table->date('date_echeance')->nullable();
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['non_payee','payee','annulee'])->default('non_payee');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'numero_facture']);
            $table->index(['entreprise_id', 'client_id', 'date_facture']);
            $table->index(['entreprise_id', 'status', 'date_facture']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('factures');
    }
};
