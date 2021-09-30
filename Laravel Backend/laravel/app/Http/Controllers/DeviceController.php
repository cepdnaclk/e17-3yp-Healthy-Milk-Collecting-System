<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;
class DeviceController extends Controller
{
    public function show(){
        try{
            $users = DB::select('select * from devices');
            return view('device',['users'=>$users]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function addDevice(Request $req){
        $device_id = $req->input('device_id');
        $collector_id = $req->input('collector_id');
        
        
    }
}
