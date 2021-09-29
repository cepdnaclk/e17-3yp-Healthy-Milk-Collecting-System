<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class UserRemoveController extends Controller
{
    public function remove(Request $req){
        try{
        $id = $req->input('user_id');
        $user = DB::table('users')->select('*')->where('id','=', $id)->get();
        return view('UserRemove',['user'=>$user[0]]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function removeConfirm(Request $req){
        try{
        $id = $req->input('id');
        $user = DB::table('users')->delete($id);;
        //
        return view('index',['user'=>$user]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
