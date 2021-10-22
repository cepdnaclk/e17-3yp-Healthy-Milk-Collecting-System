<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->string('location')->nullable();
            $table->bigInteger('latitude')->nullable();
            $table->bigInteger('longitude')->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
            $table->string('firstname');
            $table->string('lastname');
            $table->string('address');
            $table->string('contact');
            $table->string('type');
            $table->string('businesstype');


           // $table->unsignedBigInteger('farmer_id')->nullable();
           // $table->foreign('farmer_id')->references('farmer_id')->on('farmers');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
