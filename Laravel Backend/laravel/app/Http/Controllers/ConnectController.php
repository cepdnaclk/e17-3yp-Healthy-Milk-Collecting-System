<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class ConnectController extends Controller
{
    public function connect(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $collector_id = $req->input('collector_id');
        $user1 = DB::table('farmers')->select('id')->where('id','=', $farmer_id)->first();
        $user2 = DB::table('collectors')->select('id')->where('id','=', $collector_id)->first();
        //dd($user->id);
        if($user1 != null && $user2 != null){
            DB::table('collector_farmer')->insert([
                'collector_id' => $collector_id,
                'farmer_id' => $farmer_id
            ]);
            return response(
                [
                    
                    'message' => $farmer_id. " is connected with " .$collector_id,
                    
                ],
                
            );
        }else{
            return response(
                [
                    
                    'error_message' => "not found",
                    
                ],
                
            );
        }
        
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
