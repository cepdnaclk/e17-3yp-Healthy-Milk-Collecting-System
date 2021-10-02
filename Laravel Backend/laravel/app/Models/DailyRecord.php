<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;
use App\Models\Farmer;
use App\Models\Collector;
use App\Models\Device;

class DailyRecord extends Model
{
    use HasFactory;

    public function subRecord()
    {
        return $this->hasMany(SubRecord::class);
    }//1-m

    public function farmer()
    {
        return $this->belongsTo(Farmer::class);
    }//m-1
    
    public function collector()
    {
        return $this->belongsTo(Collector::class);
    }//m-1

    public function device()
    {
        return $this->belongsTo(Device::class);
    }//m-1
}
