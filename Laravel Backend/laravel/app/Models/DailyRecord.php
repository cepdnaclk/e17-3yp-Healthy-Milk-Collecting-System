<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;

class DailyRecord extends Model
{
    use HasFactory;

    public function subRecord()
    {
        return $this->hasMany(SubRecord::class);
    }
}
