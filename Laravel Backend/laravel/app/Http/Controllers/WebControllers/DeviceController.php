<?php
namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\Device;
use Illuminate\Support\Facades\DB;
class DeviceController extends Controller
{
    public function show(){
        try{
            $devices = DB::select('select * from devices');
            return view('device',['devices'=>$devices]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function find(Request $req){
        try{
            $device = DB::table('devices')->select('*')->where('id','=', $id)->first();
            return $device;
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function createDevice(Request $req){
        $creds=["description" => $req->input('description'),
        "batch" => $req->input('batch')
        ];
        Device::create($creds);
        
        
    }
    public function remove(Request $req){
        try{
            DB::table('devices')->delete( $req->input('device_id'));
            return view('device',['device'=> $req->input('device_id')]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function deviceEdit(Request $req){
        try{
            $id = $req->input('device_id');
            
            DB::update('update devices set description = ?,batch=? where id = ?',[$req->description,$req->batch,$id]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
