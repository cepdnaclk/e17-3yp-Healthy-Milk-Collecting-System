<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Support\Facades\DB;

class UserRemoveController extends Controller
{
    public function remove(Request $req){
        try{
        $id = $req->input('id');
        $user = DB::table('users')->select('*')->where('id','=', $id)->first();
        return view('UserRemove',['user'=>$user]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function removeAdmin(Request $req){
        try{
        $id = $req->input('id');
        $user = DB::table('admins')->select('*')->where('id','=', $id)->first();
        return view('adminRemove',['user'=>$user]);
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
        $type=DB::table('users')->where('id','=', $id)->value('type');
        if($type =='collector'){
            $collector_id=DB::table('collectors')->where('user_id','=', $id)->value('id');
            $collector = DB::table('collectors')->delete($collector_id);
        }else if($type =='farmer'){
            $farmer_id=DB::table('farmers')->where('user_id','=', $id)->value('id');
            $farmer = DB::table('farmers')->delete($farmer_id);
        }
        $user = DB::table('users')->delete($id);
        //
        $ccount = Collector::count();  
        $fcount = Farmer::count(); 
        $ucount = User::count(); 
        $arr = [$ccount,$fcount,$ucount];
        return view('index',['user'=>$user,'userscount'=>$arr]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function removeConfirmAdmin(Request $req){
        try{
        $id = $req->input('id');
        
        $user = DB::table('admins')->delete($id);
        //
        $ccount = Collector::count();  
        $fcount = Farmer::count(); 
        $ucount = User::count(); 
        $arr = [$ccount,$fcount,$ucount];
        return view('index',['userscount'=>$arr]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }

}
