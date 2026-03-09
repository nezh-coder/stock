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
        Schema::create('bon_livraisons', function (Blueprint $table) {
            $table->id();
            $table->string('numero_bon_livraison')->unique();
            $table->foreignId('client_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('bon_commande_id')->nullable()->constrained('bon_commandes')->onDelete('set null');
            $table->date('date_livraison');
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20.00);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['en_attente', 'livre', 'annule'])->default('en_attente');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bon_livraisons');
    }
};
