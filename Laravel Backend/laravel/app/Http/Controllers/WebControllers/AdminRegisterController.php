<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Support\Facades\DB;
use Illuminate\Auth\Events\Registered;
use Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;

class AdminRegisterController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
       
            $this->middleware('guest');
            $this->middleware('guest:admins');
            
        
    }
    /**
     * show dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('index');
    }
    public function registerForm(){
        return view('admin_register');
    }
    public function register(Request $request){

        //$this->validator($request->all())->validate();
        $creds = [
            'email' => $request->input('email'),
            'name' => $request->input('name'),
            'password' => Hash::make($request['password']),
            'contact' => $request->input('contact'),

        ];
        
        
        try {
            $admin = Admin::create($creds);
            

             
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'message' => $th,
                    'success' => false
                    
                ],
                
            );
        }
        
        
        return response(
            [
                'user' => $admin,
                'message' => 'register success',
                'success' => true
            ],
            201
        );
        
        
        
        }

    public function login(Request $request){

            $creds = [
                'email' => $request->input('email'),
                'password' => $request->input('password')
            ];
        
             if(!Auth()->attempt($creds)){
        
                return response([
                    'message' => 'login faild!',
                    'success' => false
                ]);
        
             }
        
             
        $admin = Auth()->user();
        
        
        
        $token = JWTAuth::fromUser($admin);
        
        return response(
            [
                'user' => $admin,
                'token' => $token,
                'success' => true
            ],
            201
            );
        
        
        
        
    }
        

    public function show(){
        try{
            $admins = DB::select('select * from admins');
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
            $email = $req->input('email');
            $id = $req->input('id');
            $name = $req->input('name');
            $contact = $req->input('contact');
            
            DB::update('update admins set name = ?,email = ?, contact = ? where id = ?',[$name, $email,$contact,$id]);
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
