<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DailyRecord;
use App\Models\Device;

class SubRecord extends Model
{
    use HasFactory;

    public function dailyRecord()
    {
        return $this->belongsTo(DailyRecord::class);
    }//m-1

    // public function device()
    // {
    //     return $this->belongsTo(Device::class);
    // }

    
}
