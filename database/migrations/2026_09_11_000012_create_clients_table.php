<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('entreprise_id');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('name');
            $table->string('tel')->nullable();
            $table->string('email')->nullable();
            $table->string('ice')->nullable();
            $table->text('adresse')->nullable();
            $table->decimal('credit', 10, 2)->default(0);
            $table->timestamps();

            $table->index(['entreprise_id', 'name']);
            $table->index('user_id');
            $table->foreign('entreprise_id')->references('id')->on('entreprises')->cascadeOnDelete();
            $table->foreign('user_id')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('clients');
    }
};
