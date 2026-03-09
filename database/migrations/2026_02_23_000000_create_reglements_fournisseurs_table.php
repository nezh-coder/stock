<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReglementsFournisseursTable extends Migration
{
    public function up()
    {
        Schema::create('reglements_fournisseurs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('fournisseur_id');
            $table->decimal('montant', 15, 2);
            $table->date('date_reglement');
            $table->string('mode_paiement');
            $table->string('reference')->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('reglements_fournisseurs');
    }
}
