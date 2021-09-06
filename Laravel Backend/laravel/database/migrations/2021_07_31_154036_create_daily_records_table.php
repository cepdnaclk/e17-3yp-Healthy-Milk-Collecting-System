<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDailyRecordsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('daily_records', function (Blueprint $table) {
            $table->id('id');
            $table->timestamps();
            $table->float('ph_value');
            $table->float('density');
            $table->float('volume');
            $table->integer('fat_rate');
            $table->float('temperature');
            $table->dateTime('added_date');
            $table->string('grade');
            $table->float('price_rate');

            $table->unsignedBigInteger('collector_id');
            $table->unsignedBigInteger('farmer_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('daily_records');
    }
}
