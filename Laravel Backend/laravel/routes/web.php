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

Auth::routes(['verify' => true],['register' => false]);
Route::get('/', function () {
    return redirect('https://cepdnaclk.github.io/e17-3yp-Milk-Testing-and-Collecting-System');
});

Route::group(['prefix'=>'/main','middleware' => 'auth:admins'], function () {
    
    Route::get('', [MainController::class, 'index'])->name('admin.dashboard');
    Route::get('/edit_my_details', [AdminController::class, 'profile'])->name('admin.edit_self');
    Route::post('/changed', [AdminController::class, 'pwd_change'])->name('admin.edit.submit');
    Route::get('/links',[MainController::class, 'links'])->name('admin.dashboard.links');

    Route::get('/sub_records',[RecordController::class, 'subView'])->name('admin.dashboard.sub_records');
    Route::get('/daily_records',[RecordController::class, 'View'])->name('admin.dashboard.daily_records');

    Route::get('/collectors',[CollectorController::class, 'show'])->name('admin.dashboard.collectors');
    Route::get('/farmers',[FarmerController::class, 'show'])->name('admin.dashboard.farmers');
    Route::get('/devices',[DeviceController::class, 'show'])->name('admin.dashboard.devices');
    Route::get('/admins',[AdminController::class, 'show'])->name('admin.dashboard.admins');

    Route::get('/collector-edit',[CollectorController::class, 'find'])->name('collector-edit');
    Route::get('/farmer-edit',[FarmerController::class, 'find'])->name('farmer-edit');
    Route::get('/admin-edit',[AdminController::class, 'find'])->name('admin-edit');
    Route::get('/device-edit',[DeviceController::class, 'find'])->name('device-edit');
    Route::get('/record-edit',[RecordController::class, 'sub_find'])->name('sub_record_edit');

    Route::get('/collector-save', [CollectorController::class, 'save'])->name('collector-save');
    Route::get('/farmer-save',[FarmerController::class, 'save'])->name('farmer-save');
    Route::get('/admin-save',[AdminController::class, 'save'])->name('admin-save');
    Route::get('/device-save',[DeviceController::class, 'save'])->name('device-save');
    Route::get('/record-save',[RecordController::class, 'update'])->name('record-save');

    Route::get('/get-farmers',[FarmerController::class, 'get'])->name('get-farmers');
    Route::get('/get-collectors',[CollectorController::class, 'get'])->name('get-collectors');
    
    Route::get('/farmer-join',[ConnectController::class,'connect'])->name('farmer-join');
    Route::post('/set-device',[CollectorController::class,'setDevice'])->name('set-device');
    Route::get('/device-add',[DeviceController::class, 'create'])->name('device.add');
    
    Route::get('/user-remove',[UserRemoveController::class,'remove'])->name('user-remove');
    Route::get('/user-remove-confirm',[UserRemoveController::class,'removeConfirm'])->name('user-remove-confirm');
    Route::get('/admin-remove-confirm',[UserRemoveController::class,'removeConfirmAdmin'])->name('admin-remove-confirm');
    Route::get('/admin-remove',[UserRemoveController::class,'removeAdmin'])->name('admin-remove');
    Route::get('/device-remove',[DeviceController::class,'remove'])->name('device-remove');

    Route::get('/pricerate',[PriceChartController::class, 'filter'])->name('admin.get-price-filter');
    Route::get('/price-save',[PriceChartController::class, 'save'])->name('price-save');
    Route::get('/price-all',[PriceChartController::class, 'getAll'])->name('admin.get-price-bar');
    Route::get('/get-price', [PriceChartController::class, 'index'])->name('get-price');
    Route::get('/collector-price', [PriceChartController::class, 'get'])->name('collector-price');

    Route::get('/admins-create-invite', [AdminController::class,'inviteForm'])->name('invite');
    Route::post('/admins-invite', [AdminController::class,'process_invites'])->name('process_invite');
    Route::get('/invite-remove', [AdminController::class,'remove_invites'])->name('invite-remove');

    Route::get('/get-volume-filter',[RecordController::class, 'dailyVolumeFilter'])->name('admin.get-volume-filter');
    Route::get('/get-volume', [RecordController::class, 'dailyVolume'])->name('get-volume');
    Route::get('/quality-chart', [RecordController::class, 'qualityChart'])->name('quality-chart');
    Route::get('/quality-chart-filter',[RecordController::class, 'chartfilter'])->name('admin.get-chart-filter');
    Route::get('/remove-record', [RecordController::class, 'delete'])->name('remove-record');
    
    Route::get('/remove-record-verify', [RecordController::class, 'delete_verify'])->name('remove-record-verify');
    Route::get('/invite-remove-verify', [AdminController::class,'remove_invites_verify'])->name('invite-remove-verify');
    Route::get('/device-remove-verify',[DeviceController::class,'remove_verify'])->name('device-remove-verify');

    Route::get('/success', function(){
            return view('success');
    })->name('success');

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
});

Route::prefix('admin')->group(function() {
    Route::get('/login','AdminLoginController@showLoginForm')->name('admin.login');
    Route::post('/login', 'AdminLoginController@login')->name('admin.login.submit');
    Route::get('/logout', 'AdminLoginController@logout')->name('admin.logout');
    Route::get('/registerAdmin/{token}', 'AdminRegisterController@registerForm')->name('registration');
    Route::get('/register', 'AdminRegisterController@register')->name('admin.register');	
    
});









   