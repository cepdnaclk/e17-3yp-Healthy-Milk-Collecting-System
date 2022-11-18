<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Collector;

class Device extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'device_id',
        'description',
    ];

  /*  public function dailyRecord(){
        return $this->hasMany(DailyRecord::class);
    }//1-m  */

    public function collector(){
        return $this->hasMany(Collector::class);
    }//1-m
}
