<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use JWTAuth;
use Illuminate\Auth\Events\Registered;

class AuthController extends Controller
{
    


    public function register(Request $request){


        $creds = [
            'email' => $request->input('email'),
            'name' => $request->input('name'),
            'password' => bcrypt($request->input('password')),
            'firstname' => $request->input('firstname'),
            'lastname' => $request->input('lastname'),
            'address' => $request->input('address'),
            'contact' => $request->input('contact'),
            'type' => $request->input('type'),
            'businesstype' => $request->input('businesstype'),
        ];
        
        
        try {
            $user = User::create($creds);
            
            
            // if($user->type=='collector'){
            
            //    $collector_creds=[
            //     'user_id' => $user->id
            //    ]; 
            //    try{
            //         $collector=Collector::create($collector_creds);
            //         return response(
            //             [
                            
            //                 'message' => 'Successfully created',
            //                 'success' => true
                            
            //             ],
                        
            //         );
            //    }catch(\Throwable $th){

            //    }
            // }
            // else if($creds['type']=='farmer'){
            //     $farmer_creds=[
            //      'user_id' => $user->id
            //     ]; 
            //     try{
            //          $farmer = Farmer::create($farmer_creds);
            //          return response(
            //             [
                            
            //                 'message' => 'Successfully created',
            //                 'success' => true
                            
            //             ],
                        
            //         );
            //     }catch(\Throwable $th){
 
            //     }
            //  }
             //
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'message' => $th,
                    'success' => false
                    
                ],
                
            );
        }
        
        event(new Registered($user));
        $token = JWTAuth::fromUser($user);
        
        return response(
            [
                'user' => $user,
                'message' => 'register success',
                'token' => $token,
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

     
$user = Auth()->user();



$token = JWTAuth::fromUser($user);

return response(
    [
        'user' => $user,
        'token' => $token,
        'success' => true
    ],
    201
    );




}
        
public function logout()
    {
    
     try {
               auth()->logout();
          return response()->json(['message' => 'Successfully logged out',
                                   'success' => true
                                  ]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'message' => $th,
                    'success' => false
                    
                ],
                
            );
        }
     

       
    }


public function sendResetLink(Request $request) {
    $request->validate(['email' => 'required|email']);

    $status = Password::sendResetLink(
        $request->only('email')
    );

    return $status === Password::RESET_LINK_SENT
                ? back()->with(['status' => __($status)])
                : back()->withErrors(['email' => __($status)]);
}







public function resetPassword(Request $request) {
    $request->validate([
        'token' => 'required',
        'email' => 'required|email',
        'password' => 'required|min:8|confirmed',
    ]);

    $status = Password::reset(
        $request->only('email', 'password', 'password_confirmation', 'token'),
        function ($user, $password) {
            $user->forceFill([
                'password' => Hash::make($password)
            ])->setRememberToken(Str::random(60));

            $user->save();

            event(new PasswordReset($user));
        }
    );

    return $status === Password::PASSWORD_RESET
                ? redirect()->route('login')->with('status', __($status))
                : back()->withErrors(['email' => [__($status)]]);
}    




}
