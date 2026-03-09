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
        Schema::create('avoirs', function (Blueprint $table) {
            $table->id();
            $table->string('numero_avoir')->unique();
            $table->foreignId('client_id')->constrained('clients')->onDelete('cascade');
            $table->foreignId('bon_livraison_id')->nullable()->constrained('bon_livraisons')->onDelete('cascade');
            $table->foreignId('facture_id')->nullable()->constrained('factures')->onDelete('cascade');
            $table->date('date_avoir');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20.00);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['en_cours', 'valide', 'annule'])->default('en_cours');
            $table->text('motif')->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('avoirs');
    }
};
