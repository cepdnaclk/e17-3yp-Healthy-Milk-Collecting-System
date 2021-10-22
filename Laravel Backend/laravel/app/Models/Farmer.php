<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Collector;

class Farmer extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
   protected $fillable = [
       'user_id',
   ];
    public function collector(){ 
        //return $this->belongsToMany(Collector::class);
        return $this->belongsToMany(
             collector::class,
            'collector_farmers',
            'farmer_id',
            'collector_id');
    
    }
    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function dailyRecord()
    {
        return $this->hasMany(DailyRecord::class);
    }//1-m
}
