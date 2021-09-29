<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\PriceChartController;
use App\Models\Collector;
use App\Models\Farmer;
use App\Models\User;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::get('/', function () {
    return view('welcome');
});
// Route::get('/dashboard', function () {
//     return view('index');
// });
Route::get('/main', function () {
    try{
    $ccount = Collector::count();  
    $fcount = Farmer::count(); 
    $ucount = User::count(); 
    $arr = [$ccount,$fcount,$ucount];
    //dd($arr);
    return view('index',['userscount'=>$arr]);
    }   catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/links', function () {
    return view('links');
});
Route::get('/login', function () {
    return view('login');
});

Route::get('/collectors',function (){
    try{
        $users = DB::select('select * from collectors');
        return view('collector',['users'=>$users]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/farmers',function (){
    try{
        $users = DB::select('select * from farmers');
        return view('farmer',['users'=>$users]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/devices',function (){
    try{
        $users = DB::select('select * from devices');
        return view('device',['users'=>$users]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/admins',function (){
    try{
        $users = DB::select('select * from admins');
        return view('admin',['users'=>$users]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/get-farmers',function (Request $req){
    try{
        $id = $req->input('id');
        $users = DB::table('collector_farmer')->select('*')->where('collector_id','=', $id)->get();
        //return view('farmer',['users'=>$users]);
        //dd($users);
        $arr=array();
        
        foreach ($users as $user) {
            $farmer = DB::table('farmers')->select('*')->where('id','=', $user->farmer_id)->get(); 
            array_push($arr,$farmer[0]);
        }
        //dd($arr);
        return view('farmer',['users'=>$arr]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/get-collectors',function (Request $req){
    try{
        $id = $req->input('id');
        $users = DB::table('collector_farmer')->select('*')->where('farmer_id','=', $id)->get();
        //return view('collector',['users'=>$users]);
        $arr=array();
        
        foreach ($users as $user) {
            $collector = DB::table('collectors')->select('*')->where('id','=', $user->collector_id)->get(); 
            array_push($arr,$collector[0]);
        }
        //dd($arr);
        return view('collector',['users'=>$arr]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/collector-edit',function (Request $req){
    try{
    $id = $req->input('id');
    $user = DB::table('collectors')->select('*')->where('id','=', $id)->get();
    return view('collectoredit',['user'=>$user[0]]);
    //return $user[0];
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/farmer-edit',function (Request $req){
    try{
    $id = $req->input('id');
    $user = DB::table('farmers')->select('*')->where('id','=', $id)->get();
    return view('farmer_edit',['user'=>$user[0]]);
    //return $user[0];
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/user-remove',function (Request $req){
    try{
    $id = $req->input('id');
    $user = DB::table('collectors')->select('*')->where('id','=', $id)->get();
    return view('UserRemove',['user'=>$user[0]]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/user-remove-confirm',function (Request $req){
    try{
    $id = $req->input('id');
    $user = DB::table('collectors')->delete($id);;
    //
    return view('index',['user'=>$user]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/farmer-join',function (Request $req){
    try{
    $farmer_id = $req->input('id');
    $collector_id = $req->input('collector_id');
    $user = DB::table('farmers')->select('id')->where('id','=', $farmer_id)->first();
    //dd($user->id);
    DB::table('collector_farmer')->insert([
        'collector_id' => $collector_id,
        'farmer_id' => $farmer_id
    ]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/pricerate',function (){
    
    return view('filter');
});
Route::get('/collector-save',function (Request $req){
    try{
    $email = $req->input('email');
    $id = $req->input('id');
    $name = $req->input('name');
    $business_type = $req->input('businesstype');
    
    DB::update('update collectors set name = ?,email = ?, businesstype = ? where id = ?',[$name, $email,$business_type,$id]);
    return view('success',['user'=>$email]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/farmer-save',function (Request $req){
    try{
    $email = $req->input('email');
    $id = $req->input('id');
    $name = $req->input('name');
    $business_type = $req->input('businesstype');
    
    DB::update('update farmers set name = ?,email = ?, businesstype = ? where id = ?',[$name, $email,$business_type,$id]);
    return view('success',['user'=>$email]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});
Route::get('/get-price', [PriceChartController::class, 'index']);
