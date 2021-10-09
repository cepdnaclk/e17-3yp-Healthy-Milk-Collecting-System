<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class MainController extends Controller
{
    //
    public function index() {
        try{
        $ccount = Collector::count();  
        $fcount = Farmer::count(); 
        $ucount = User::count(); 
        $arr = [$ccount,$fcount,$ucount];
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
}
