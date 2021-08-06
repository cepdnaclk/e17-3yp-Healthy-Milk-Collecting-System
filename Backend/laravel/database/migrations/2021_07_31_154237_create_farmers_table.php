<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFarmersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('farmers', function (Blueprint $table) {
            $table->id('farmer_id');
            $table->timestamps();
            $table->string('name');
            $table->string('email');
            $table->string('passoword');
            $table->string('address_id');



            $table->unsignedBigInteger('user_id');
            //$table->foreign('user_id')->references('user_id')->on('users');



        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('farmers');
    }
}
