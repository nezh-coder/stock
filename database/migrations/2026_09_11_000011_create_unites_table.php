<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('unites', function (Blueprint $table) {
            $table->unsignedInteger('id')->autoIncrement();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('name', 50);

            $table->unique(['entreprise_id', 'name']);
            $table->index('user_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('unites');
    }
};
