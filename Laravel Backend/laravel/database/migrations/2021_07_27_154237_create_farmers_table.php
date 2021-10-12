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
            $table->bigIncrements('id');
            $table->timestamps();
            // $table->string('name');
            // $table->string('email');
            // $table->string('passoword');
            // $table->string('address');
            // $table->string('businesstype');
            // $table->string('contact');

            $table->unsignedBigInteger('user_id');
            //$table->unsignedBigInteger('collector_id');
            $table->foreign('user_id')->references('id')->on('users')->onUpdate('cascade')->onDelete('cascade');



        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::create('farmers', function (Blueprint $table) {
            $table->id('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();


            $table->unsignedBigInteger('user_id')->nullable();
           // $table->foreign('farmer_id')->references('farmer_id')->on('farmers');

        });
    }
}
