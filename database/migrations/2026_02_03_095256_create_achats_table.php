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
        Schema::create('achats', function (Blueprint $table) {
            $table->id()->unique();
            $table->string('numero_achat')->unique();
			 $table->integer('num');
			  $table->year('annee');
           // Relations
            $table->unsignedBigInteger('fournisseur_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->date('date_commande');
			 $table->date('date_echeance')->nullable();
            $table->decimal('total_ht', 10, 2);
            $table->decimal('tva', 5, 2)->default(20.00);
            $table->decimal('total_ttc', 10, 2);
			$table->decimal('montant_paye', 10, 2)->default(0);
            $table->decimal('reste_a_payer', 10, 2)->default(0);
            $table->enum('status', ['en_cours', 'partiellement_paye','paye',
                'annule'])->default('en_cours');
            $table->text('notes')->nullable();
            $table->timestamps();
			 // Foreign keys
            $table->foreign('fournisseur_id')
                  ->references('id')->on('fournisseurs')
                  ->onDelete('cascade');

            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('achats');
    }
};
