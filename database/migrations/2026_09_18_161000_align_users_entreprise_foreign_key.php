<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('users') || ! Schema::hasColumn('users', 'entreprise_id')) {
            return;
        }

        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['entreprise_id']);
        });

        Schema::table('users', function (Blueprint $table) {
            $table->unsignedBigInteger('entreprise_id')->nullable()->change();
            $table->foreign('entreprise_id')
                ->references('id')->on('entreprises')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        if (! Schema::hasTable('users') || ! Schema::hasColumn('users', 'entreprise_id')) {
            return;
        }

        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['entreprise_id']);
            $table->unsignedInteger('entreprise_id')->nullable()->change();
            $table->foreign('entreprise_id')
                ->references('id')->on('entreprises')
                ->nullOnDelete();
        });
    }
};