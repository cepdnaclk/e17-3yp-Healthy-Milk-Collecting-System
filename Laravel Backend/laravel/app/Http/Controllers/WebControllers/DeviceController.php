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
            $devices = DB::select('select * from devices')->where('id',$req->input('id'));
            return view('device',['users'=>$devices]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function createDevice(Request $req){
        $creds=["description" => $req->input('description')];
        Device::create($creds);
        
        
    }
    public function remove(Request $req){
        try{
            DB::table('devices')->delete( $req->input('device_id'));
            return view('device',['users'=> $req->input('device_id')]);
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
            
            DB::update('update devices set description = ? where id = ?',[$req->description,$id]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
