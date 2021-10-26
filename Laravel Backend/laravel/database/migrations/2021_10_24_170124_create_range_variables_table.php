<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRangeVariablesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('range_variables', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->float('pH1_low');
            $table->float('pH2_low');
            $table->float('pH3_low');
            $table->float('pH1_high');
            $table->float('pH2_high');
            $table->float('pH3_high');
            $table->float('fat1_low');
            $table->float('fat2_low');
            $table->float('fat3_low');
            $table->float('fat1_high');
            $table->float('fat2_high');
            $table->float('fat3_high');
            $table->float('fat1_low_b');
            $table->float('fat2_low_b');
            $table->float('fat3_low_b');
            $table->float('fat1_high_b');
            $table->float('fat2_high_b');
            $table->float('fat3_high_b');
            $table->float('den1_low');
            $table->float('den2_low');
            $table->float('den3_low');
            $table->float('den1_high');
            $table->float('den2_high');
            $table->float('den3_high');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('range_variables');
    }
}
