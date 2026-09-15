<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('devis', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero_devis');
            $table->unsignedInteger('num');
            $table->year('annee');
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->date('date_devis');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['brouillon','envoye','accepte','refuse'])->default('brouillon');
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['entreprise_id', 'annee', 'num']);
            $table->index(['entreprise_id', 'client_id', 'date_devis']);
            $table->index(['entreprise_id', 'status', 'date_devis']);
            $table->index('user_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('devis');
    }
};
