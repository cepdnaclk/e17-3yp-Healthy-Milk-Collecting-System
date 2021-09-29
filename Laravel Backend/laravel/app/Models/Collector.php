<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Farmer;

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
}
