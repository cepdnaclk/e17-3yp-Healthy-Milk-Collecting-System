<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Support\Facades\DB;
use Illuminate\Auth\Events\Registered;
use JWTAuth;
class AdminController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:admins');
    }
    /**
     * show dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    
        

    public function show(){
        try{
            $admins = DB::table('admins')->simplePaginate(8);
            return view('admin',['admins'=>$admins]);
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
            $admin = DB::table('admins')->select('*')->where('id','=', $id)->first();
            return view('admin_edit',['user'=>collect($admin)]);
        
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
            
            $id = $req->input('id');
            $name = $req->input('name');
            $contact = $req->input('contact');
            
            DB::update('update admins set name = ? ,contact = ? where id = ?',[$name, $contact,$id]);
            return view('success',['user'=>$name]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
