<?php
namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;

use Illuminate\Support\Facades\DB;
class CollectorController extends Controller
{
    //show all registered collectors
    public function show(){
        try{
            $users = DB::table('users')->select('*')->where('type','=', 'collector')->get();
            $collectors = [];
            foreach($users as $user){
                
                
                $device_id=DB::table('collectors')->where('user_id','=', $user->id)->value('device_id');
                $collector_id=DB::table('collectors')->where('user_id','=', $user->id)->value('id');
                $user_data = ["user_id"=>$user->id,
                        "device_id"=>$device_id,
                        "collector_id"=>$collector_id,
                        "name"=>$user->name,
                        "email"=>$user->email,
                        "location"=>$user->location,
                        "latitude"=>$user->latitude,
                        "longitude"=>$user->longitude,
                        "email_verified_at"=>$user->email_verified_at,
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
                array_push($collectors,$user_data);
                //array_push($new_array,$user);
                //array_merge($tmp,$user);
                //return $new_array;
            }

            $collectors = $this->paginate($collectors,8);
            $collectors = collect($collectors);
            //dd($collectors);
            return view('collector',['collectors'=>$collectors['data'],'page_data'=>$collectors]);
            
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    
    //save collector data after editing
    public function save(Request $req){
        try{
            $id = $req->input('user_id');
            
            DB::update('update users set name = ?,email = ?,
            location=?,latitude=?,longitude=?,firstname=?,
            lastname=?,contact=?,address=?, businesstype = ? where id = ?',
            [
            $req->input('firstname')." ".$req->input('lastname'),$req->input('email'),$req->input('location'),
            $req->input('latitude'),$req->input('longitude'),$req->input('firstname'),
            $req->input('lastname'),$req->input('contact'),
            $req->input('address'),$req->input('businesstype'),$id
            ]);
            return view('success',['user'=>$id]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    //get collectors list for a given farmer
    public function get(Request $req){
        try{
            $id = $req->input('id');
            $users = DB::table('collector_farmers')->select('*')->where('farmer_id','=', $id)->get();
            //return view('collector',['users'=>$users]);
            $collectors = [];
            if(count($users)){
                foreach ($users as $collector) {
                    
                    $device_id=DB::table('collectors')->where('id','=', $collector->collector_id)->value('device_id');
                    $user_id=DB::table('collectors')->where('id','=', $collector->collector_id)->value('user_id');
                    $user = DB::table('users')->select('*')->where('id','=',  $user_id)->first();
                    $user_data = ["user_id"=>$user->id,
                            "device_id"=>$device_id,
                            "collector_id"=>$collector->collector_id,
                            "name"=>$user->name,
                            "email"=>$user->email,
                            "location"=>$user->location,
                            "latitude"=>$user->latitude,
                            "longitude"=>$user->longitude,
                            "email_verified_at"=>$user->email_verified_at,
                            "created_at"=>$user->created_at,
                            "updated_at"=>$user->updated_at,
                            "firstname"=>$user->firstname,
                            "lastname"=>$user->lastname,
                            "contact"=>$user->contact,
                            "address"=>$user->address,
                            "businesstype"=>$user->businesstype,
                            "type"=>$user->type];
                            array_push($collectors,$user_data);
                }
            }else{
                return response(
                    [
                        
                        'error_message' => "not found",
                        
                    ],
                    
                );
            }
            $collectors =colllect($collectors);
            return view('collector',['collectors'=>$collectors]);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    //find collector details for a given collector id
    public function find(Request $req){
        try{
        $id = $req->input('id');
        $user = DB::table('users')->select('*')->where('id','=', $id)->first();
        $device_id=DB::table('collectors')->where('user_id','=', $id)->value('device_id');
        $collector_id=DB::table('collectors')->where('user_id','=', $id)->value('id');
        //$price = DB::table('price_changes')->select('*')->where('collector_id', $id)->orderBy('created_at','DESC')->first();
        $user_data = ["user_id"=>$user->id,
                        "device_id"=>$device_id,
                        "collector_id"=>$collector_id,
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
                        "type"=>$user->type,
                        //"a"=>$price->a,
                        //"b"=>$price->b,
                        //"c"=>$price->c,
                        //"d"=>$price->d
                    ];     
        return view('collector_edit',['user'=>collect($user_data)]);
        //dd(collect($user_data));
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    //set device
    public function setDevice(Request $req){
        $device_id = $req->input('device_id');
        $collector_id = $req->input('collector_id');
        
        DB::update('update collectors set device_id = ? where id = ?',[$device_id, $collector_id]);
    }
    
}
