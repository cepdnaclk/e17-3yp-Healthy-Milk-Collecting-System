<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DailyRecord;

class CollectorFarmer extends Model
{
    use HasFactory;

    // public function dailyRecord()
    // {
    //     return $this->hasMany(DailyRecord::class);
    // }//1-m
}
