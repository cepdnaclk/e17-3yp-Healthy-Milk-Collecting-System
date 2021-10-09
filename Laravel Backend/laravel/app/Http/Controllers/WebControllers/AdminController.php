<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;
class AdminController extends Controller
{
    public function show(){
        try{
            $users = DB::select('select * from admins');
            return view('admin',['users'=>$users]);
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
        $id = $req->input('id');
        $user = DB::table('collectors')->select('*')->where('id','=', $id)->get();
        return view('collectoredit',['user'=>$user[0]]);
        //return $user[0];
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
        
        DB::update('update collectors set name = ?,email = ?, businesstype = ? where id = ?',[$name, $email,$business_type,$id]);
        return view('success',['user'=>$email]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
