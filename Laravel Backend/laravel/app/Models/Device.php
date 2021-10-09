<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DailyRecord;
use App\Models\Collector;

class Device extends Model
{
    use HasFactory;

    public function dailyRecords(){
        return $this->hasMany(DailyRecord::class);
    }//1-m
    
    public function collector(){
        return $this->hasMany(Collector::class);
    }//1-m
}
