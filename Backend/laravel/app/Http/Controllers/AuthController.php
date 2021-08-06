<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;

class AuthController extends Controller
{
    


public function testv1(Request $request){

$subRecords = DailyRecord::find(1)->subRecord;

$dr =  SubRecord::find(1)->dailyR;

return [
    "success" => true,
    "subRecords" => [$subRecords]
];


}




}
