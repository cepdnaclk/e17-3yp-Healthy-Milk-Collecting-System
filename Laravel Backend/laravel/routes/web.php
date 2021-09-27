<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

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
// Route::get('/dashboard', function () {
//     return view('index');
// });
Route::get('/main', function () {
    return view('index');
});
Route::get('/links', function () {
    return view('links');
});

//012
Route::get('/collectors',function (){
    $users = DB::select('select * from users');
    return view('collector',['users'=>$users]);
});
Route::get('/farmers',function (){
    $users = DB::select('select * from users');
    return view('farmer',['users'=>$users]);
});
Route::get('/devices',function (){
    $users = DB::select('select * from users');
    return view('device',['users'=>$users]);
});
Route::get('/admins',function (){
    $users = DB::select('select * from users');
    return view('admin',['users'=>$users]);
});
Route::get('/collector-edit',function (){
    
    return view('collectorfilter');
});
Route::get('/edit-collectors',function (Request $req){
    $email = $req->input('email');
    $user = DB::table('users')->select('*')->where('email','=', $email)->get();
    return view('collectoredit',['user'=>$user[0]]);
    //return $user[0];
});
Route::get('/pricerate',function (){
    
    return view('filter');
});
Route::get('/collector-save',function (Request $req){
    $email = $req->input('email');
    return view('success',['user'=>$email]);
});
Route::get('/get-price',function (Request $req){
    $email = $req->input('email');
    //if($email){
       $post = DB::table('users')->select('*')->where('email','=', $email)->get();
    //   foreach($post as $row)
    //    {
    //       $data[] = array
    //        (
    //         'label'=>$row->$id,
    //         'y'=>$row
    //        ); 
    //    }
      //return view('price',['data' => $data]);
        return $post;
    
    
});