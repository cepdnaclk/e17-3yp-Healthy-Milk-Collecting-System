<?php

namespace App\Http\AppControllers\Controllers;

use Illuminate\Http\Request;

class NewPasswordController extends Controller
{
    


public function forgotPassword(Request $request){
        $request->validate(['email' => 'required|email']);
    
        $status = Password::sendResetLink(
            $request->only('email')
        );
    
        return $status === Password::RESET_LINK_SENT
                    ? back()->with(['status' => __($status)])
                    : back()->withErrors(['email' => __($status)]);

    }



}
