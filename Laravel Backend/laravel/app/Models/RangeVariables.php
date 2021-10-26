<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RangeVariables extends Model
{
    use HasFactory;
    protected $fillable=[
        'pH1_low',
        'pH2_low',
        'pH3_low',
        'fat1_low',
        'fat2_low',
        'fat3_low',
        'fat1_low_b',
        'fat2_low_b',
        'fat3_low_b',
        'den1_low',
        'den2_low',
        'den3_low',
        'pH1_high',
        'pH2_high',
        'pH3_high',
        'fat1_high',
        'fat2_high',
        'fat3_high',
        'fat1_high_b',
        'fat2_high_b',
        'fat3_high_b',
        'den1_high',
        'den2_high',
        'den3_high'
      ];
      
}
