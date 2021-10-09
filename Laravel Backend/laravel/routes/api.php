<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AppControllers\AuthController;
use App\Http\Controllers\AppControllers\RecordController;
use App\Http\Controllers\AppControllers\NewPasswordController;
use App\Http\Controllers\AppControllers\PriceChartController;
use App\Http\Controllers\AppControllers\CollectorController;
use App\Http\Controllers\AppControllers\FarmerController;
use App\Http\Controllers\AppControllers\ConnectController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Route::middleware('auth:api')->get('/user', function (Request $request) {
  //  return $request->user();
//});


//Authentication
Route::post('/register',[AuthController::class,'register']);
Route::post('/login',[AuthController::class,'login']);
Route::get('/logout',[AuthController::class,'logout']);



Route::post('/add_daily_record',[RecordController::class,'addDailyRecord']);

Route::post('/test1',[RecordController::class,'test1']); 

Route::post('/forgot-password',[NewPasswordController::class,'forgotPassword']);
Route::post('/new-password',[NewPasswordController::class,'forgotPassword']);


// Route::post('/set-device',[CollectorController::class,'setDevice']);
// Route::post('/price-save',[PriceChartController::class, 'save']);
// Route::get('/get-price', [PriceChartController::class, 'index']);
// Route::get('/collector-price', [PriceChartController::class, 'get']);
// Route::get('/connect', [ConnectController::class, 'connect']);

// Route::get('/collectors',[CollectorController::class, 'show']);

// Route::get('/get-farmers',[FarmerController::class, 'get']);
// Route::get('/get-collectors',[CollectorController::class, 'get']);