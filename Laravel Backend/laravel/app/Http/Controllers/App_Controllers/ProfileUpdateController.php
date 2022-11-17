<?php

namespace App\Http\Controllers\App_Controllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\PriceChange;

use Illuminate\Support\Facades\DB;

class ProfileUpdateController extends Controller
{
    

//save collector data after editing
public function updateName(Request $req){

    try{
        $id = $req->input('user_id');

       
        
        DB::update('update users set name = ?,firstname=?,
        lastname=?,email=?,
        contact=? where id = ?', [
            $req->input('name'),
            $req->input('firstname'),
            $req->input('lastname'),
            $req->input('email'),
            $req->input('contact'),
            $id]
        );  

      /*  $user = DB::table('users')
              ->where('id', $id)
              ->update(['name' => input('name'),]); */

        
         $user = User::find($id);

        return response(
            [
                 
                 'new_name' => $user->name,
                 'firstname' => $user->firstname,
                 'lastname' => $user->lastname,
                 'email' => $user->email,
                 'contact' => $user->contact,
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
