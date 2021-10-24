<?php

namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use Illuminate\Support\Facades\DB;
class FarmerController extends Controller
{
    public function show(){
        try{
            $users = DB::table('users')->select('*')->where('type','=', 'farmer')->get();
            $farmers = [];
            foreach($users as $user){
                
                
                
                $farmer_id=DB::table('farmers')->where('user_id','=', $user->id)->value('id');
                $user_data = ["user_id"=>$user->id,
                        "farmer_id"=>$farmer_id,
                        "name"=>$user->name,
                        "email"=>$user->email,
                        "location"=>$user->location,
                        "latitude"=>$user->latitude,
                        "longitude"=>$user->longitude,
                        "created_at"=>$user->created_at,
                        "updated_at"=>$user->updated_at,
                        "firstname"=>$user->firstname,
                        "lastname"=>$user->lastname,
                        "contact"=>$user->contact,
                        "address"=>$user->address,
                        "businesstype"=>$user->businesstype,
                        "type"=>$user->type];
                //$user->'device_id'=$device_id;
                //$user['collector_id']=$collector_id;
                //$arr1=json_decode($user);
                //$arr2=json_decode($tmp);
                //$arr3=[$arr1,$arr2];
                array_push($farmers,$user_data);
                //array_push($new_array,$user);
                //array_merge($tmp,$user);
                //return $new_array;
            }
            //dd(collect($farmers));
            //dd($users);
            $farmers = $this->paginate($farmers,8);
            $farmers = collect($farmers);
            
            return view('farmer',['users'=>$farmers['data'],'page_data'=>$farmers]);
            
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
            $id = $req->input('user_id');
            
            DB::update('update users set name = ?,email = ?,
            location=?,latitude=?,longitude=?,firstname=?,
            lastname=?,contact=?,address=?, businesstype = ? where id = ?',
            [$req->input('name'),$req->input('email'),$req->input('location'),
            $req->input('latitude'),$req->input('longitude'),$req->input('firstname'),
            $req->input('lastname'),$req->input('contact'),
            $req->input('address'),$req->input('businesstype'),$id]);
            
            return view('success',['message'=>'successfully updated user data for '.$id]);
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
            $user = DB::table('users')->select('*')->where('id','=', $id)->first();
            $farmer_id = DB::table('farmers')->select('id')->where('user_id','=', $user->id)->first();
            $user_data = ["user_id"=>$user->id,
                        "farmer_id"=>$farmer_id,
                        "name"=>$user->name,
                        "email"=>$user->email,
                        "location"=>$user->location,
                        "latitude"=>$user->latitude,
                        "longitude"=>$user->longitude,
                        "created_at"=>$user->created_at,
                        "updated_at"=>$user->updated_at,
                        "firstname"=>$user->firstname,
                        "lastname"=>$user->lastname,
                        "contact"=>$user->contact,
                        "address"=>$user->address,
                        "businesstype"=>$user->businesstype];
        
        return view('farmer_edit',['user'=>collect($user_data)]);
        //return $user[0];
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function get(Request $req){
        try{
            $id = $req->input('id');
            $users = DB::table('collector_farmers')->select('*')->where('collector_id','=', $id)->get();
            //return view('collector',['users'=>$users]);
            $farmers = [];
            if(count($users)){
                foreach ($users as $farmer) {
                    
                    
                    $user_id=DB::table('farmers')->where('id','=', $farmer->id)->value('user_id');
                    $user = DB::table('users')->select('*')->where('id','=',  $user_id)->first();
                    $user_data = ["user_id"=>$user->id,
                            "farmer_id"=>$farmer->id,
                            "name"=>$user->name,
                            "email"=>$user->email,
                            "location"=>$user->location,
                            "latitude"=>$user->latitude,
                            "longitude"=>$user->longitude,
                            "created_at"=>$user->created_at,
                            "updated_at"=>$user->updated_at,
                            "firstname"=>$user->firstname,
                            "lastname"=>$user->lastname,
                            "contact"=>$user->contact,
                            "address"=>$user->address,
                            "businesstype"=>$user->businesstype,
                            "type"=>$user->type];
                            array_push($farmers,$user_data);
                }
            }else{
                return view('Notfound',['user'=>$id]);
            }
            //dd($farmers);
            return view('farmer',['users'=>collect($farmers)]);
        
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
