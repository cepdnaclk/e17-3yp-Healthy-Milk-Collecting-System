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

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'batch',
        'status'
>>>>>>> e379faff510bdbbdebf7e4b40fb0aa6e7b456b0e
    ];

    public function dailyRecord(){
        return $this->hasMany(DailyRecord::class);
    }//1-m

    public function collector(){
        return $this->hasMany(Collector::class);
    }//1-m
}
