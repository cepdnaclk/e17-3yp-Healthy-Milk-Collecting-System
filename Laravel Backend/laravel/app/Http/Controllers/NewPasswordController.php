<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\PriceChange;

use Illuminate\Support\Facades\DB;

class NewPasswordController extends Controller//
{
    


public function changePassword(Request $request){
    
     $user_entered_old_pw = bcrypt($request->input('old_password'));

     $old_pw = DB::table('users')->where('id','=', $request->input('user_id'))->value('password');


     if(false /*$user_entered_old_pw != $old_pw*/){

        return response(
            [
                
                  'message' => 'Enter the correct password',
                 'success' => false

            ],
            
        );  
     }else{


        try{
            $id = $request->input('user_id');
    
           
            
            DB::update('update users set password = ? where id = ?', [
    
                bcrypt($request->input('password')),
               
                $id]
            );  
    
        
    
            
             $user = User::find($id);
    
            return response(
                [
                     
                      'password' => $user->password,
                      'message' => 'password changes successfully',
                     'success' => true
    
                    
                    
                ],
                
            );
            
           
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }




     }



    


    }



}
