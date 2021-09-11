<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;

class Device extends Model
{
    use HasFactory;

    public function subRecords(){
        return $this->hasMany(SubRecord::class);
    }
}
