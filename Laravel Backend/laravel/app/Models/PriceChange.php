<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Collector;

class PriceChange extends Model
{
    use HasFactory;
    protected $fillable = [
        'collector_id',
        'collector_email',
        'a',
        'b',
        'c',
        'd',
        
    ];
    public function collector()
    {
        return $this->hasOne(collector::class, 'id', 'collector_id');
    }
}
