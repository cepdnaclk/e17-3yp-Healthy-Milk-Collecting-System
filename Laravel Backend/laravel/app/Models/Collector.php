<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;
use App\Models\Farmer;
use App\Models\Device;

class Collector extends Model
{
    use HasFactory;



    // public function farmers(){

    //     return $this->hasMany(Farmer::class);
    // }
    public function farmers()
    {
        return $this->belongsToMany(
            Farmer::class,
            'collector_farmer',
            'collector_id',
            'farmer_id');
    }
    public function users()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }
    public function pricechanges()
    {
        return $this->hasMany(PriceChange::class, 'collector_id', 'id');
    }//1-m

    public function device()
    {
        return $this->hasOne(Device::class);
    }//1-1

    public function dailyRecords()
    {
        return $this->hasMany(DailyRecord::class);
    }//1-m
}
