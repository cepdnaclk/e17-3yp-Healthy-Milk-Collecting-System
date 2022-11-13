<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Device;
use Illuminate\Support\Facades\DB;

class MainController extends Controller
{
    //
    public function index() {
        try{
        $ccount = Collector::count();  
        $fcount = Farmer::count(); 
        $ucount = User::count(); 
        $dcount1 = Device::where('status','ordered')->count(); 
        $dcount2 = Device::where('status','using')->count();
        $arr = [$ccount,$fcount,$ucount,$dcount1,$dcount2];
        //dd($arr);
        return view('index',['userscount'=>$arr]);
        }   catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function links(){
        return view('links');
    }
}
