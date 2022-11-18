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
<<<<<<< HEAD

  /*  public function dailyRecord(){
=======
    public function dailyRecord(){
>>>>>>> 6662a395933cd64c3429fe7355a8604d760153c9
        return $this->hasMany(DailyRecord::class);
    }//1-m  */

    public function collector(){
        return $this->hasMany(Collector::class);
    }//1-m
}
