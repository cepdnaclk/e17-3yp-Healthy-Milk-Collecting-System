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
        $user = DB::table('farmers')->select('id')->where('id','=', $farmer_id)->first();
        //dd($user->id);
        DB::table('collector_farmer')->insert([
            'collector_id' => $collector_id,
            'farmer_id' => $farmer_id
        ]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
