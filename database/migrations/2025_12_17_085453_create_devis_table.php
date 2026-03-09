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
        Schema::create('devis', function (Blueprint $table) {
            $table->id();
            $table->string('numero_devis')->unique(); // Numéro unique du devis
            $table->foreignId('client_id')->constrained('clients')->onDelete('cascade'); // Client
            $table->date('date_devis');
            $table->decimal('total_ht', 10, 2); // Total hors taxe
            $table->decimal('tva', 5, 2)->default(20.00); // TVA en %
            $table->decimal('total_ttc', 10, 2); // Total TTC
            $table->enum('status', ['brouillon', 'envoye', 'accepte', 'refuse'])->default('brouillon');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('devis');
    }
};
