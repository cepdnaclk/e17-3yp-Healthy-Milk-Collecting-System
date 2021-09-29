<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;

use Illuminate\Support\Facades\DB;
class CollectorController extends Controller
{
    public function show(){
        try{
            $users = DB::select('select * from collectors');
            return view('collector',['users'=>$users]);
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
        
        DB::update('update users set name = ?,email = ?, businesstype = ? where id = ?',[$name, $email,$business_type,$id]);
        return view('success',['user'=>$email]);
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
            $users = DB::table('collector_farmer')->select('*')->where('farmer_id','=', $id)->get();
            //return view('collector',['users'=>$users]);
            $arr=array();
            
            foreach ($users as $user) {
                $collector = DB::table('collectors')->select('*')->where('id','=', $user->collector_id)->get(); 
                array_push($arr,$collector[0]);
            }
            //dd($arr);
            return view('collector',['users'=>$arr]);
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
        return view('collectoredit',['user'=>$user]);
        //return $user[0];
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
