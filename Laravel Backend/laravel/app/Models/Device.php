<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Collector;

class Device extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'batch'
    ];
    public function dailyRecord(){
        return $this->hasMany(DailyRecord::class);
    }//1-m

    public function collector(){
        return $this->hasMany(Collector::class);
    }//1-m
}
