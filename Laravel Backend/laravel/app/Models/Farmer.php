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
        return $this->belongsToMany(Collector::class);
    }
}
