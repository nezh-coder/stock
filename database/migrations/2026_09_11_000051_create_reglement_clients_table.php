<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('reglement_clients', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('numero')->unique();
            $table->foreignId('client_id')->constrained('clients')->restrictOnDelete();
            $table->date('date_reglement');
            $table->decimal('montant', 15, 2);
            $table->enum('mode_paiement', ['Espèces','Chèque','Virement','Carte']);
            $table->string('reference')->nullable();
            $table->text('notes')->nullable();
            $table->enum('status', ['valide','annule'])->default('valide');
            $table->timestamps();

            $table->index(['entreprise_id', 'client_id', 'date_reglement']);
            $table->index('user_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reglement_clients');
    }
};
