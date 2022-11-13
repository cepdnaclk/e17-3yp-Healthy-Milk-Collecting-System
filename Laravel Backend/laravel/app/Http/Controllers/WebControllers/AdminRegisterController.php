<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Admin;
use Illuminate\Support\Str;
use App\Models\Invite;
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
    public function registerForm($token){
        $invite = Invite::where('token', $token)->first();
        return view('admin_register',['invite' => $invite]);
       
    }
    public function register(Request $request){

        
        $creds = [
            'email' => $request->input('email'),
            'name' => $request->input('name'),
            'password' => Hash::make($request['password']),
            'contact' => $request->input('contact'),

        ];
        
        $this->validate($request, [
            'email'   => 'required|email',
            'password' => 'required|min:8'
          ]);
        $verify = DB::table('invites')->select('*')->where('email','=', $request->input('email'))->value('id');
        if($verify == null){
            return response([
                'message' => $request->input('email').' is not in invited list',
                'success' => false
            ]);
        }
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
        
        
        return view('adminLogin');
        
        
        
        }
        
    public function verify_email(){
        return view('verify-email');
    }

}
