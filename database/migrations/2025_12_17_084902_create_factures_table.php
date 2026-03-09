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
        Schema::create('factures', function (Blueprint $table) {
            $table->id();
            $table->string('numero_facture')->unique();
            $table->foreignId('client_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('bon_livraison_id')->nullable()->constrained('bon_livraisons')->onDelete('set null');
            $table->date('date_facture');
            $table->date('date_echeance')->nullable();
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20.00);
            $table->decimal('total_ttc', 10, 2);
            $table->enum('status', ['non_payee', 'payee', 'annulee'])->default('non_payee');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('factures');
    }
};
