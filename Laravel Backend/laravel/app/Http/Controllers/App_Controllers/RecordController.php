<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class RecordController extends Controller
{
    


public function addDailyRecord(Request $request){

    $collector_id = $value = DB::table('collectors')->where('user_id',  $request->input('user_id'))->value('id'); 

    if($request->input('farmer_id')!=null){


        $farmer_user_id = $value = DB::table('farmers')->where('id',  $request->input('farmer_id'))->value('user_id'); 

        $farmer_name = $value = DB::table('users')->where('id', $farmer_user_id)->value('name'); 

        $data = [
            'farmer_id' => $request->input('farmer_id'),
            'farmer_name'=> $farmer_name,
            'collector_id' => $collector_id,
            'ph_value' => $request->input('ph_value'),
            'density' => $request->input('density'),
            'total_volume' => $request->input('volume'),
            'fat_rate' => $request->input('fat_rate'),
            'temperature' => $request->input('temperature'),
            'device_id' => $request->input('device_id'),
            'total_price' => $request->input('total_price'),
            'note'=>$request->input('note'),
            'day'=>$request->input('day')
        ];
    }else{
 
        $data = [
            
            'farmer_name'=> $request->input('farmer_name'),
            'collector_id' => $collector_id,
            'ph_value' => $request->input('ph_value'),
            'density' => $request->input('density'),
            'total_volume' => $request->input('volume'),
            'fat_rate' => $request->input('fat_rate'),
            'temperature' => $request->input('temperature'),
            'device_id' => $request->input('device_id'),
            'total_price' => $request->input('total_price'),
            'note'=>$request->input('note'),
            'day'=>$request->input('day')
        ];
    }
    
   
   /* $subrecords = [
        [
            'ph_value'=>1,
            'density'=>3,
            'volume'=>2,
            'fat_rate'=>3,
            'temperature'=>5,
            'grade'=>8,
            'price_rate'=>9,
            
        ],
        [
            'ph_value'=>1,
            'density'=>3,
            'volume'=>2,
            'fat_rate'=>3,
            'temperature'=>5,
            'grade'=>8,
            'price_rate'=>9,
           
        ],
        [
            'ph_value'=>1,
            'density'=>3,
            'volume'=>2,
            'fat_rate'=>3,
            'temperature'=>5,
            'grade'=>8,
            'price_rate'=>9,
           
        ],
        
    ];  */
    
    try {
        $dailyRecord = DailyRecord::create($data); 
        $daily_record_id = $dailyRecord->id;

        
    

      /* foreach ($subrecords as $subrecord){
            $sub_data = [
                'ph_value'=>$subrecord["ph_value"],
                'density'=>$subrecord["density"],
                'volume'=>$subrecord["volume"],
                'fat_rate'=>$subrecord["fat_rate"],
                'temperature'=>$subrecord["temperature"],
                'grade'=>$subrecord["grade"],
                'price_rate'=>$subrecord["price_rate"],
                'daily_record_id'=> $daily_record_id
            ]; 
            try{
                $subrecord_instance = SubRecord::create($sub_data);
            } catch (\Throwable $th) {
                return response(
                    [
                        
                        'error_message' => $th,
                         'message' => 'sub not added'
                        
                    ],
                    
                );
            }
            
        } */


           return response(
            [
                'record' => $dailyRecord,
                'message' => 'daily record is added success',
                'success' => true,
                'id'      => $dailyRecord->id,
                
            ],
            201
        );  


      /*  return response(
            [
                'subrecords' => $sub_records,
                'message' => 'sub records record is added success',
                'success' => true
                
            ],
            201
        ); */


    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                'success' => false
                
            ],
            
        );
    }
    


  


}

public function addSubRecord(Request $request){
    $sub_data = [
        'ph_value'=>$request->input('ph_value'),
        'density'=>$request->input('density'),
        'volume'=>$request->input('volume'),
        'fat_rate'=>$request->input('fat_rate'),
        'temperature'=>$request->input('temperature'),
        'grade'=>$request->input('grade'),
        'price_rate'=>$request->input('price_rate'),
        'daily_record_id'=> $request->input('id'),
    ];

    try{
        $created_subrecord = SubRecord::create($sub_data);

        return response(
            [
                'sub_record' => $created_subrecord,
                'success' => true,
                'message' => 'added success'
                
            ],
            
        );

    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                'success' => false
                
            ],
            
        );
    }



}



}
