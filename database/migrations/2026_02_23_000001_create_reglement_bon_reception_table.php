<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReglementBonReceptionTable extends Migration
{
    public function up()
    {
        Schema::create('reglement_bon_reception', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('reglement_id');
            $table->unsignedBigInteger('bon_reception_id');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('reglement_bon_reception');
    }
}
