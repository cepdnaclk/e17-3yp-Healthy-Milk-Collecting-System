<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\SubRecord;
use App\Models\Farmer;
use App\Models\Device;

class Collector extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'device_id',
    ];



    // public function farmers(){

    //     return $this->hasMany(Farmer::class);
    // }
    public function farmer()
    {
        return $this->belongsToMany(
            Farmer::class,
            'collector_farmers',
            'collector_id',
            'farmer_id');
    }
    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }
    public function priceChange()
    {
        return $this->hasMany(PriceChange::class);
    }//1-m

    public function device()
    {
        return $this->belongsTo(Device::class);
    }//m-1

    public function dailyRecord()
    {
        return $this->hasMany(DailyRecord::class);
    }//1-m

}
