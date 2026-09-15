<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('reglement_facture', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->foreignId('reglement_id')->constrained('reglement_clients')->cascadeOnDelete();
            $table->foreignId('facture_id')->constrained('factures')->cascadeOnDelete();
            $table->decimal('mont_paye', 15, 2);
            $table->timestamps();

            $table->index(['entreprise_id', 'reglement_id']);
            $table->index(['entreprise_id', 'facture_id']);
            $table->index('user_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reglement_facture');
    }
};
