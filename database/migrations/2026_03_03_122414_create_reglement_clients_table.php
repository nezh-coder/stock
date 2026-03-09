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
       Schema::create('reglement_clients', function (Blueprint $table) {
    $table->id();
    $table->string('numero')->unique();
    $table->foreignId('client_id')->constrained()->cascadeOnDelete();
    $table->date('date_reglement');
    $table->decimal('montant', 15, 2);
    $table->enum('mode_paiement',['Espèces','Chèque','Virement','Carte']);
    $table->string('reference')->nullable();
    $table->text('notes')->nullable();
    $table->enum('status',['valide','annule'])->default('valide');
    $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reglement_clients');
    }
};
