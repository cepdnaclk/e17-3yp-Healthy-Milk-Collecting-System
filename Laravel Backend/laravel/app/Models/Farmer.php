<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Collector;

class Farmer extends Model
{
    use HasFactory;

    public function collectors(){ 
        //return $this->belongsToMany(Collector::class);
        return $this->belongsToMany(
             collector::class,
            'collector_farmer',
            'farmer_id',
            'collector_id');
    
    }
    public function users()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function dailyRecords()
    {
        return $this->hasMany(DailyRecord::class);
    }//1-m
}
