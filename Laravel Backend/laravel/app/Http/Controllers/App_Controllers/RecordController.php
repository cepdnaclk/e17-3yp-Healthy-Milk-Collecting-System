<?php

namespace App\Http\AppControllers\Controllers;////

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;

class RecordController extends Controller
{
    


public function addDailyRecord(Request $request){
    if($request->input('farmer_id')!=null){
        $user_id = $value = DB::table('farmers')->where('id',  $request->input('farmer_id'))->value('user_id'); 
        $farmer_name = $value = DB::table('users')->where('id', $user_id)->value('name'); 
        $data = [
            'farmer_id' => $request->input('farmer_id'),
            'farmer_name'=> $farmer_name,
            'collector_id' => $request->input('collector_id'),
            'ph_value' => $request->input('ph_value'),
            'density' => $request->input('density'),
            'total_volume' => $request->input('volume'),
            'fat_rate' => $request->input('fat_rate'),
            'temperature' => $request->input('temperature'),
            'device_id' => $request->input('device_id'),
            'total_price' => $request->input('total_price'),
            'note'=>$request->input('note')
        ];
    }else{
 
        $data = [
            
            'farmer_name'=> $request->input('farmer_name'),
            'collector_id' => $request->input('collector_id'),
            'ph_value' => $request->input('ph_value'),
            'density' => $request->input('density'),
            'total_volume' => $request->input('volume'),
            'fat_rate' => $request->input('fat_rate'),
            'temperature' => $request->input('temperature'),
            'device_id' => $request->input('device_id'),
            'total_price' => $request->input('total_price'),
            'note'=>$request->input('note')
        ];
    }
    
    
    
    try {
        $dailyRecord = DailyRecord::create($data); 
        $daily_record_id = $dailyRecord->id;
        foreach ($subrecords as $subrecord){
            $sub_data = [
                'ph_value'=>$subrecord,
                'density'=>$subrecord,
                'volume'=>$subrecord,
                'fat_rate'=>$subrecord,
                'temperature'=>$subrecord,
                'grade'=>$subrecord,
                'price_rate'=>$subrecord,
                'daily_record_id'=> $daily_record_id
            ];
            try{
                $subrecord_instance = SubRecord::create($sub_data);
            } catch (\Throwable $th) {
                return response(
                    [
                        
                        'error_message' => $th,
                        
                    ],
                    
                );
            }
            
        }
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



}
