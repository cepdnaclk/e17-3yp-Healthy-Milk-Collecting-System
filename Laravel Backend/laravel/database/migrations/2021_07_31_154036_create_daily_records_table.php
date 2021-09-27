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
            $table->float('total_volume');
            $table->integer('fat_rate');
            $table->float('temperature');
            $table->dateTime('added_date');
            $table->float('total_price');
            $table->unsignedBigInteger('device_id');

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
