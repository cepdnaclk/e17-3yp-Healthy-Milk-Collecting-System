<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;

class RecordController extends Controller
{
    


public function addDailyRecord(Request $request){

    $data = [
        'collector_id' => $request->input('collector_id'),
        'farmer_id' => $request->input('farmer_id'),
        'ph_value' => $request->input('ph_value'),
        'density' => $request->input('density'),
        'total_volume' => $request->input('volume'),
        'fat_rate' => $request->input('fat_rate'),
        'temperature' => $request->input('temperature'),
        'device_id' => $request->input('device_id'),
        'total_price' => $request->input('total_price'),
    ];
    
    
    try {
        $dailyRecord = DailyRecord::create($data);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
    


    return response(
        [
            'record' => $dailyRecord,
            'message' => 'daily record is added success',
            
        ],
        201
    );



}


public function test1(){
    return response([
        "test" => "test1"
    ]);
}


}
