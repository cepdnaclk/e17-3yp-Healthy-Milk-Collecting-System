<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;
use App\Models\Device;

class SubRecord extends Model
{
    use HasFactory;

    public function dailyRecord()
    {
        return $this->belongsTo(SubRecord::class);
    }

    public function device()
    {
        return $this->belongsTo(Device::class);
    }

    
}
