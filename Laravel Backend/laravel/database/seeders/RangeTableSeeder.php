<?php

namespace Database\Seeders;
use App\Models\RangeVariables;
use Illuminate\Database\Seeder;

class RangeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $range =[
            'pH1_low'=>6.6,
            'pH2_low'=>6.5,
            'pH3_low'=>6.4,
            'pH1_high'=>6.8,
            'pH2_high'=>6.9,
            'pH3_high'=>7,
            'fat1_low'=>60,
            'fat2_low'=>55,
            'fat3_low'=>45,
            'fat1_high'=>70,
            'fat2_high'=>75,
            'fat3_high'=>85,
            'fat1_low_b'=>70,
            'fat2_low_b'=>65,
            'fat3_low_b'=>60,
            'fat1_high_b'=>80,
            'fat2_high_b'=>85,
            'fat3_high_b'=>90,
            'den1_low'=>1.026,
            'den2_low'=>1.020,
            'den3_low'=>1.010,
            'den1_high'=>1.032,
            'den2_high'=>1.034,
            'den3_high'=>1.04,
        ];
        RangeVariables::create($range);
    }
} 
