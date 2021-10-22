<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\Admin;
use App\Mail\MilkTabMail;
use Illuminate\Support\Facades\DB;
use Illuminate\Auth\Events\Registered;
use JWTAuth;
use URL;
use Mail;
use App\Notifications\InviteNotification;
use Illuminate\Notifications\Notifiable;
use Notification;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Invite;
use Auth;

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
    
    
    public function inviteForm(){
       
        return view('invite');
       
    }   

    public function show(){
        try{
            $admins = DB::table('admins')->simplePaginate(8);
            $admins_invites = DB::table('invites')->simplePaginate(8);
            return view('admin',['admins'=>$admins,'invites'=>$admins_invites]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function find(Request $req){
        if($req->input('id')!=null){
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
        }else{
            try{
                $name = $req->input('uname');
                $admin = DB::table('admins')->select('*')->where('name','=', $name)->first();
                return view('admin_edit',['user'=>collect($admin)]);
            
            } catch (\Throwable $th) {
                return response(
                    [
                        
                        'error_message' => $th,
                        
                    ],
                    
                );
            }
        }
    }
    public function save(Request $req){
        try{
            
            $id = $req->input('id');
            $name = $req->input('name');
            $contact = $req->input('contact');
            
            DB::update('update admins set name = ? ,contact = ? where id = ?',[$name, $contact,$id]);
            return view('success',['message'=>'successfully updated '.$name]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function profile(){
        return view('profile');
    }
    public function pwd_change(Request $req){
        $name = $req->input('username');
        $cpwd = $req->input('c_password');
        $pwd = $req->input('password');     
        try{
            $validator = Validator::make($req->all(), [
                'email' => 'required|email'
            ]);
            if (Auth::guard('admins')->attempt(['email' => $req->email, 'password' => $req->c_password])){
                DB::update('update admins set password = ?  where email = ?',[bcrypt($pwd),$req->email]);
                return redirect(route('success'))->with(['message'=>'password changed for '.$name]);
            }else{
                $validator->errors()->add('email','current password or email is not valid!');
                return redirect(route('admin.edit_self'))
                    ->withErrors($validator);
            }
            
        
            
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function process_invites(Request $request)
        {
            $validator = Validator::make($request->all(), [
                'email' => 'required|email|unique:users,email'
            ]);
            $validator->after(function ($validator) use ($request) {
                if (Invite::where('email', $request->input('email'))->exists()) {
                    $validator->errors()->add('email', 'There exists an invite with this email!');
                }
            });
            if ($validator->fails()) {
                return redirect(route('invite'))
                    ->withErrors($validator)
                    ->withInput();
            }
            do {
                $token = Str::random(20);
            } while (Invite::where('token', $token)->first());
            Invite::create([
                'token' => $token,
                'email' => $request->input('email')
            ]);
            $url = URL::temporarySignedRoute(
        
                'registration', now()->addMinutes(300), ['token' => $token]
            );
            $details = [
                'title' => 'Invitation from MilkTab',
                'body' => 'Use this link to register at MilkTab Admin panel. This link will expire after 5 hours ',
                'link' => $url
            ];
            //dd($details);
            \Mail::to($request->input('email'))->send(new \App\Mail\MilkTabMail($details));
            
            //Notification::route('mail', $request->input('email'))->notify(new InviteNotification($url));
            return redirect('/main/success')->with('message', 'The Invite has been sent successfully to '.$request->input('email'));
        }

        public function remove_invites_verify(Request $req){
            return view('remove_verify',['id'=>$req->id]);
        }

        public function remove_invites(Request $req){
            try{
                DB::table('invites')->delete( $req->input('id'));
                $admins = DB::table('admins')->simplePaginate(8);
                $admins_invites = DB::table('invites')->simplePaginate(8);
                return view('success',['message'=>'Invitation was removed']);
            } catch (\Throwable $th) {
                return response(
                    [
                        
                        'error_message' => $th,
                        
                    ],
                    
                );
            }
        }
}
