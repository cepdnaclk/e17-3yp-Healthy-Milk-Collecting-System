<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCollectorFarmersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {   Schema::dropIfExists('collector_farmers');
        Schema::create('collector_farmers', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->timestamps();
            $table->string('status');        
            $table->unsignedBigInteger('collector_id');
            $table->foreign('collector_id')
              ->references('id')
              ->on('collectors')->onDelete('cascade');
            $table->unsignedBigInteger('farmer_id');
            $table->foreign('farmer_id')
              ->references('id')
              ->on('farmers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('collector_farmers');
    }
}
