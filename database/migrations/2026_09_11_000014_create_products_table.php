<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('name');
            $table->string('description')->nullable();
            $table->string('marque')->nullable();
            $table->double('quantity');
            $table->double('min_qte');
            $table->decimal('unit_price', 10, 2);
            $table->unsignedInteger('category_id')->nullable();
            $table->unsignedInteger('unite_id');
            $table->timestamps();

            $table->index(['entreprise_id', 'name']);
            $table->index(['entreprise_id', 'category_id']);
            $table->index(['entreprise_id', 'marque']);
            $table->index('user_id');
            $table->index('unite_id');

            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
            $table->foreign('category_id')->references('id')->on('categories')->nullOnDelete();
            $table->foreign('unite_id')->references('id')->on('unites')->restrictOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
