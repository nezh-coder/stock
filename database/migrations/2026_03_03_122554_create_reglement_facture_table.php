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
        Schema::create('reglement_facture', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reglement_id')->constrained('reglement_clients')->cascadeOnDelete();
            $table->foreignId('facture_id')->constrained()->cascadeOnDelete();
            $table->decimal('mont_paye',15,2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reglement_facture');
    }
};
