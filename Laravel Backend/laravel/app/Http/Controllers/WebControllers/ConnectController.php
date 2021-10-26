<?php
namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
use App\Models\CollectorFarmer;
use Illuminate\Support\Facades\DB;///

class ConnectController extends Controller
{
    public function connect(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $collector_id = $req->input('collector_id');
        $user1 = DB::table('farmers')->select('id')->where('id','=', $farmer_id)->first();
        $user2 = DB::table('collectors')->select('id')->where('id','=', $collector_id)->first();
        //dd($user->id);
        if($user1 != null && $user2 != null){
            $creds=[
                'collector_id' => $collector_id,
                'farmer_id' => $farmer_id,
                'status' => 'pending'
            ];
            $record = CollectorFarmer::create($creds);
            return response(
                [
                    
                    'message' => $farmer_id. " is connected with (pending)" .$collector_id,
                    
                ],
                
            );
        }else{
            return response(
                [
                    
                    'error_message' => "not found",
                    
                ],
                
            );
        }
        
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }


    public function accept(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $collector_id = $req->input('collector_id');
        //$user1 = DB::table('farmers')->select('id')->where('id','=', $farmer_id)->first();
        //$user2 = DB::table('collectors')->select('id')->where('id','=', $collector_id)->first();
        //dd($user->id);
        $record_id = DB::table('collector_farmers')->where([['farmer_id','=', $farmer_id],['collector_id','=', $collector_id],['status','pending']])->value('id');
        if($record_id != null){
            DB::update('update collector_farmers set status = ? where id = ?',['active',$record_id]);
            return response(
                [
                    
                    'message' => $farmer_id. " is connected with " .$collector_id,
                    
                ],
                
            );
        }else{
            return response(
                [
                    
                    'error_message' => "not found",
                    
                ],
                
            );
        }
        
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }


    public function pendingCollectors(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $users = DB::table('collector_farmers')->select('*')->where([['farmer_id','=', $farmer_id],['status','pending']])->get();
        $collectors = [];
        if(count($users)){
        foreach ($users   as $user_) {
            $collector_id   = $user_->collector_id;
            $user_id = DB::table('collectors')->where('id','=', $collector_id)->value('user_id');
            $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
                $a = DB::table('price_changes')->where('collector_id', $collector_id)->value('a');
                $b = DB::table('price_changes')->where('collector_id', $collector_id)->value('b');
                $c = DB::table('price_changes')->where('collector_id', $collector_id)->value('c');
                $d = DB::table('price_changes')->where('collector_id', $collector_id)->value('d');
                $user_data = [

                        "user_id"=>$user->id,
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
                       
                        "a"=>$a,
                        "b"=>$b,
                        "c"=>$c,
                        "d"=>$d
                    ];  
                    array_push($collectors,$user_data); 
        }}
        dd($collectors);
        return response(
                [
                    
                    'pcollectors' => $collectors,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }



    public function activeCollectors(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $users = DB::table('collector_farmers')->select('*')->where([['farmer_id','=', $farmer_id],['status','active']])->get();
        $collectors = [];
        
        if(count($users)){
        foreach ($users   as $user_) {
            $collector_id   = $user_->collector_id;
            
            $user_id = DB::table('collectors')->where('id','=', $collector_id)->value('user_id');
            
            $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
                $a = DB::table('price_changes')->where('collector_id', $collector_id)->value('a');
                $b = DB::table('price_changes')->where('collector_id', $collector_id)->value('b');
                $c = DB::table('price_changes')->where('collector_id', $collector_id)->value('c');
                $d = DB::table('price_changes')->where('collector_id', $collector_id)->value('d');
                $user_data = [

                        "user_id"=>$user->id,
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
                       
                        "a"=>$a,
                        "b"=>$b,
                        "c"=>$c,
                        "d"=>$d
                    ];  
                    array_push($collectors,$user_data); 
        }}
        dd($collectors);
        return response(
                [
                    
                    'acollectors' => $collectors,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }


    public function pendingFarmers(Request $req){
        try{
        $collector_id = $req->input('collector_id');
        $users = DB::table('collector_farmers')->select('*')->where([['collector_id','=', $collector_id],['status','pending']])->get();
        $farmers = [];

       
        if(count($users)){
        foreach ($users   as $user_) {
            $farmer_id   = $user_->farmer_id;
            $user_id = DB::table('farmers')->where('id','=', $farmer_id)->value('user_id');
            $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
            
                $user_data = [

                        "user_id"=>$user->id,
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
                        "type"=>$user->type,
        
                    ];  
                    array_push($farmers,$user_data); 
        }}
        dd($farmers);
        return response(
                [
                    
                    'pfarmers' => $farmers,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }

    public function activeFarmers(Request $req){
        try{
        $collector_id = $req->input('collector_id');
        $users = DB::table('collector_farmers')->select('*')->where([['collector_id','=', $collector_id],['status','active']])->get();
        $farmers = [];
        dd($users);
        if(count($users)){
        foreach ($users   as $user_) {
            $farmer_id   = $user_->farmer_id;
            
            $user_id = DB::table('farmers')->where('id','=', $farmer_id)->value('user_id');
            $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
               
                $user_data = [

                        "user_id"=>$user->id,
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
                        "type"=>$user->type,
        
                    ];  
                    array_push($farmers,$user_data); 
        }}
        dd($farmers);
        return response(
                [
                    
                    'afarmers' => $farmers,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }



    public function inactiveFarmers(Request $req){
        try{
        $collector_id = $req->input('collector_id');
        $users = DB::table('farmers')->select('*')->get();
        $farmers = [];
        if(count($users)){
        foreach ($users as $user_) {

            $user_id   = $user_->user_id;
            $farmer_id   = $user_->id;
            
            $id = DB::table('collector_farmers')->select('id')->where([['farmer_id','=', $farmer_id],['collector_id','=', $collector_id]])->first();
            
            if($id==null){
                $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
               
                $user_data = [

                        "user_id"=>$user->id,
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
                        "type"=>$user->type,
        
                    ];  
                    array_push($farmers,$user_data); 
            }
        }}
        dd($farmers);
        return response(
                [
                    
                    'farmers' => $farmers,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }

    public function inactiveCollectors(Request $req){
        try{
        $farmer_id = $req->input('farmer_id');
        $users = DB::table('collectors')->select('*')->get();
        $collectors = [];
        if(count($users)){
        foreach ($users as $user_) {
            $user_id   = $user_->user_id;
            $collector_id   = $user_->id;
            $id = DB::table('collector_farmers')->select('id')->where([['farmer_id','=', $farmer_id],['collector_id','=', $collector_id]])->first();
            if($id==null){
                $user = DB::table('users')->select('*')->where('id','=', $user_id)->first();
                $a = DB::table('price_changes')->where('collector_id', $collector_id)->value('a');
                $b = DB::table('price_changes')->where('collector_id', $collector_id)->value('b');
                $c = DB::table('price_changes')->where('collector_id', $collector_id)->value('c');
                $d = DB::table('price_changes')->where('collector_id', $collector_id)->value('d');
                $user_data = [

                        "user_id"=>$user->id,
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
                        "a"=>$a,
                        "b"=>$b,
                        "c"=>$c,
                        "d"=>$d
                    ];  
                    array_push($collectors,$user_data); 
            }
        }}
        dd( $collectors);
        return response(
                [
                    
                    'collectors' => $collectors,
                    'success' => true
                    
                ],
                
            );
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    'success' => false
                    
                ],
                
            );
        }  

    }
}
