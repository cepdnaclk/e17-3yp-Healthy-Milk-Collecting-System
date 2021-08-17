<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DailyRecord;
use App\Models\SubRecord;

use App\Models\User;
use JWTAuth;

class AuthController extends Controller
{
    


    public function register(Request $request){


        $creds = [
            'email' => $request->input('email'),
            'name' => $request->input('name'),
            'password' => bcrypt($request->input('password'))
        ];
        
        
        try {
            $user = User::create($creds);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'message' => $th,
                    
                ],
                
            );
        }
        
        $token = JWTAuth::fromUser($user);
        
        return response(
            [
                'user' => $user,
                'message' => 'register success',
                'token' => $token
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
    'message' => 'login faild!'
]);

     }

     
$user = Auth()->user();



$token = JWTAuth::fromUser($user);

return response(
    [
        'user' => $user,
        'token' => $token
    ],
    201
    );




}
        
public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
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
