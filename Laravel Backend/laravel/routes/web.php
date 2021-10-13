<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\WebControllers\AuthController;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\WebControllers\PriceChartController;
use App\Http\Controllers\WebControllers\AdminController;
use App\Http\Controllers\WebControllers\CollectorController;
use App\Http\Controllers\WebControllers\FarmerController;
use App\Http\Controllers\WebControllers\DeviceController;
use App\Http\Controllers\WebControllers\AdminLoginController;
use App\Http\Controllers\WebControllers\AdminRegisterController;
use App\Http\Controllers\WebControllers\MainController;
use App\Http\Controllers\WebControllers\UserRemoveController;
use App\Http\Controllers\WebControllers\RecordController;
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
Auth::routes(['verify' => true]);
Route::get('/', function () {
    return view('welcome');
});


Route::get('/', function () {
    return view('welcome');
});
// Route::get('/dashboard', function () {
//     return view('index');
// });
Route::get('/main', [MainController::class, 'index'])->name('admin.dashboard');
Route::get('/links', function () {
    return view('links');
});
Route::get('/login', function () {
    return view('login');
});
Route::get('/sub_records',[RecordController::class, 'subView']);
Route::get('/daily_records',[RecordController::class, 'View']);

Route::get('/collectors',[CollectorController::class, 'show']);
Route::get('/farmers',[FarmerController::class, 'show']);
Route::get('/devices',[DeviceController::class, 'show']);
Route::get('/admins',[AdminController::class, 'show']);
Route::get('/get-farmers',[FarmerController::class, 'get']);
Route::get('/get-collectors',[CollectorController::class, 'get']);
Route::get('/collector-edit',[CollectorController::class, 'find']);
Route::get('/admin-edit',[AdminController::class, 'find']);
Route::get('/farmer-edit',[FarmerController::class, 'find']);
Route::get('/user-remove',[UserRemoveController::class,'remove']);
Route::get('/user-remove-confirm',[UserRemoveController::class,'removeConfirm']);
Route::get('/admin-remove',[UserRemoveController::class,'removeAdmin']);
Route::get('/admin-remove-confirm',[UserRemoveController::class,'removeConfirmAdmin']);
Route::get('/farmer-join',[ConnectController::class,'connect']);
Route::get('/pricerate',function (){
    
    return view('filter');
});
Route::get('/price-save',[PriceChartController::class, 'save']);
Route::get('/price-all',[PriceChartController::class, 'getAll']);
Route::get('/collector-save', [CollectorController::class, 'save']);
Route::get('/farmer-save',[FarmerController::class, 'save']);
Route::get('/admin-save',[AdminController::class, 'save']);
Route::get('/get-price', [PriceChartController::class, 'index']);
Route::get('/collector-price', [PriceChartController::class, 'get']);


Route::get('/register',[AuthController::class,'register']);

Route::get('/users',function(){
    try{
        $users = DB::select('select * from users');
        return view('users',['users'=>$users]);
    } catch (\Throwable $th) {
        return response(
            [
                
                'error_message' => $th,
                
            ],
            
        );
    }
});

Route::post('/set-device',[CollectorController::class,'setDevice']);

Route::prefix('admin')->group(function() {
    Route::get('/login','AdminLoginController@showLoginForm')->name('admin.login');
    Route::post('/login', 'AdminLoginController@login')->name('admin.login.submit');
    Route::get('/logout', 'AdminLoginController@logout')->name('admin.logout');
    Route::get('/register', 'AdminRegisterController@registerForm');
    Route::get('/register', 'AdminRegisterController@register')->name('admin.register');	
   }) ;

 
//    Route::group(['prefix' => 'admin'],function ()
//    {
//        Route::get('/login','AdminLoginController@showLoginForm');
//        Route::get('/adminloginsubmit', 'AdminController@login')->name('admin.login.submit');
//        Route::get('/logout', 'AdminLoginController@logout')->name('admin.logout');
//        Route::get('/register', 'AdminController@registerForm');	
//        Route::post('/register', 'AdminController@register')->name('admin.register');	
//    });
   