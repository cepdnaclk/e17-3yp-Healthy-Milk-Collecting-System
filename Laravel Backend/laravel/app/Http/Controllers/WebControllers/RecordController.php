<?php

namespace App\Http\Controllers\WebControllers;;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;
use Illuminate\Support\Facades\DB;
class RecordController extends Controller
{
    


public function addDailyRecord(Request $request){
    if($request->input('farmer_id')!=null){
        $user_id = DB::table('farmers')->where('id',  $request->input('farmer_id'))->value('user_id'); 
        $farmer_name = DB::table('users')->where('id', $user_id)->value('name'); 
        $device_id = DB::table('collectors')->where('id', $request->input('collector_id'))->value('device_id'); 
        $data = [
            'farmer_id' => $request->input('farmer_id'),
            'farmer_name'=> $farmer_name,
            'collector_id' => $request->input('collector_id'),
            'ph_value' => $request->input('ph_value'),
            'density' => $request->input('density'),
            'total_volume' => $request->input('volume'),
            'fat_rate' => $request->input('fat_rate'),
            'temperature' => $request->input('temperature'),
            'device_id' => $device_id,
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
            'device_id' => $device_id,
            'total_price' => $request->input('total_price'),
            'note'=>$request->input('note')
        ];
    }
    
    
    
    try {
        $dailyRecord = DailyRecord::create($data); 
        $daily_record_id = $dailyRecord->id;
        $daily_record->day = Carbon\Carbon::createFromFormat('Y-m-d H:i:s', $daily_record->created_at)->format('Y-m-d');
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

    public function View(){
        $records = DailyRecord::all();
        $records = $this->paginate($records,8);
        return view('daily_records',['records'=>$records,'page_data'=>$records]);
    }
    public function subView(Request $req){
        
        if($req->daily_record_id ==null){
            $records = SubRecord::all();
            $records = $this->paginate($records,8);
            return view('sub_records',['records'=>$records,'page_data'=>$records]);
        }else{
            
            $records = SubRecord::all()->where('daily_record_id',$req->daily_record_id);
            $records = $this->paginate($records,8);
            return view('sub_records',['records'=>$records,'page_data'=>$records]);
        }
        

    }
    public function dailyVolumeFilter(){
        return view('filter');
    }
    public function chartfilter(){
        return view('filter');
    }
    public function qualityChart(Request $req){
        $collector_id= $req->id;
        $farmer_id= $req->farmer_id;
        $items = DailyRecord::select(
            DB::raw("ph_value as ph"),
            DB::raw("density as density"),
            DB::raw("fat_rate as fatrate"),
            DB::raw("temperature as temp"),
            DB::raw("day as day"))
            ->orderBy('day')
            ->where('collector_id',$req->id)->where('farmer_id',$farmer_id)
            ->get();
        $day=array();
        $values =array();
        
            if(count($items)>0){
                foreach ($items as $item) {
                   
                    array_push($day,$item['day']);
                    array_push($values,array($item['density'],$item['ph'],$item['total'],$item['fatrate'],$item['temp']));
                }
                $arr=array_combine($day, $values);
                return view('quality')->with(compact('arr'))->with(compact('collector_id'))->with(compact('farmer_id'));
            }else{
                return view('Notfound',['user'=>$id]);
            }
    }
    public function dailyVolume(Request $req){
        $id= $req->id;
        
        $items = DailyRecord::select(
            DB::raw("sum(total_volume) as total"),
            DB::raw("day as day"))
            ->orderBy('day')
            ->groupBy(DB::raw("day"))->where('collector_id',$req->id)
            ->get();
        $day=array();
        $values =array();
        
            if(count($items)>0){
                foreach ($items as $item) {
                   
                    array_push($day,$item['day']);
                    array_push($values,$item['total']);
                }
                $arr=array_combine($day, $values);
                return view('volume')->with(compact('arr'))->with(compact('id'));
            }else{
                return view('Notfound',['user'=>$id]);
            }
    }

    public function sub_find(Request $req){
        try{
            $record = DB::table('sub_records')->select('*')->where('id','=', $req->id)->first();
            return view('edit_record',['record'=>collect($record)]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function update(Request $req){
        try{
            
            $record = DB::table('sub_records')->select('*')->where('id','=', $req->id)->first();
            
            DB::update('update sub_records set price_rate = ?,volume=? where id = ?',[$req->price_rate, $req->volume, $req->id]);
            
            $daily_record = DB::table('daily_records')->select('*')->where('id','=', $req->daily_record_id)->first();
            $old_volume = $record->volume;
            
            $new_volume = $req->volume;
            $v_change = $new_volume-$old_volume;
            
            $old_price = ($record->price_rate)*($old_volume);
            $new_price = ($req->price_rate)*($new_volume);
            $p_change = $new_price - $old_price;
            
            $old_total_volume = $daily_record->total_volume;
            $old_total_price = $daily_record->total_price;
            
            DB::update('update daily_records set total_price = ?,total_volume=? where id = ?',[$old_total_price+$p_change, $old_total_volume+$v_change, $req->daily_record_id]);
            return view('success',['user'=>$req->id]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
