<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCollectorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('collectors', function (Blueprint $table) {
            
            $table->id('id');
            $table->timestamps();
            $table->string('name');
            $table->string('email');
            $table->string('passoword');
            $table->string('address_id');
            $table->string('businesstype');


            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('farmer_id');

            $table->foreign('farmer_id')->references('id')->on('farmers');
            
 

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('collectors');
    }
}
