<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('entreprises', function (Blueprint $table) {
            $table->id();

            // Informations de l'entreprise
            $table->string('name');
            $table->string('tel', 100);
            $table->string('email');
            $table->string('ice', 50)->nullable();
            $table->string('adresse');

            // Identité visuelle
            $table->string('logo')->nullable();
            $table->string('document_background')->nullable();

            // Personnalisation des documents
            $table->string('document_logo_position', 100)
                ->default('left');

            $table->string('document_primary_color', 100)
                ->default('#315EFB');

            $table->string('document_secondary_color', 100)
                ->default('#64748B');

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('entreprises');
    }
};