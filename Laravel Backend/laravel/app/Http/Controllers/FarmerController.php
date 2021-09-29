<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;
class FarmerController extends Controller
{
    public function show(){
        try{
            $users = DB::select('select * from farmers');
            return view('farmer',['users'=>$users]);
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
        $email = $req->input('email');
        $id = $req->input('id');
        $name = $req->input('name');
        $business_type = $req->input('businesstype');
        
        DB::update('update farmers set name = ?,email = ?, businesstype = ? where id = ?',[$name, $email,$business_type,$id]);
        return view('success',['user'=>$email]);
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
        $id = $req->input('user_id');
        $user = DB::table('users')->select('*')->where('id','=', $id)->first();
        return view('farmer_edit',['user'=>$user]);
        //return $user[0];
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function get(Request $req){
        try{
            $id = $req->input('id');
            $users = DB::table('collector_farmer')->select('*')->where('collector_id','=', $id)->get();
            //return view('farmer',['users'=>$users]);
            //dd($users);
            $arr=array();
            
            foreach ($users as $user) {
                $farmer = DB::table('user')->select('*')->where('id','=', $user->farmer_id)->first(); 
                array_push($arr,$farmer);
            }
            //dd($arr);
            return view('farmer',['users'=>$arr]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
