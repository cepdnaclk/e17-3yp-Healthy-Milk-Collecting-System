<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCollectorFarmerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('collector_farmer', function (Blueprint $table) {
            $table->bigIncrements('id');
            //bigIncrements('id')
            $table->timestamps();
                    
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
        Schema::dropIfExists('collector_farmer');
    }
}
