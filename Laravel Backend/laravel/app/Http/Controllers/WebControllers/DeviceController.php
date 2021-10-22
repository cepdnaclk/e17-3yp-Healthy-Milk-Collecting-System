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
            $devices = DB::table('devices')->simplePaginate(8);
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
            $device = DB::table('devices')->select('*')->where('id','=', $req->id)->first();
            return view('device_edit',['device'=>$device]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function create(Request $req){
        $creds=["description" => $req->input('description'),
        "batch" => $req->input('batch')
        ];
        try{
            Device::create($creds);
            $devices = DB::table('devices')->simplePaginate(8);
            return view('success',['message'=>'successfully created device ']);
        }catch(\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
        
        
    }
    public function remove_verify(Request $req){
        return view('remove_verify',['id'=>$req->id]);
    }
    public function remove(Request $req){
        try{
            DB::table('devices')->delete($req->id);
            return view('success',['message'=>'successfully removed device']);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function save(Request $req){
        try{
            $id = $req->input('id');
            
            DB::update('update devices set description = ?,batch=? where id = ?',[$req->description,$req->batch,$id]);
            return view('success',['message'=>'successfully updated device']);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
