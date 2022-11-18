<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CollectorController;
use App\Http\Controllers\RecordController;
use App\Http\Controllers\ProfileUpdateController;
use App\Http\Controllers\NewPasswordController;
use App\Http\Controllers\ConnectController;

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



Route::post('/register',[AuthController::class,'register']);
Route::post('/login',[AuthController::class,'login']);
Route::get('/logout',[AuthController::class,'logout']);

//Route::get('/test',[CollectorController::class,'test']);
Route::post('/addDevice',[CollectorController::class,'addDevice']);

 Route::post('/set-device',[CollectorController::class,'setDevice']);
 Route::post('/price-save',[PriceChartController::class, 'save']);
 Route::get('/get-price', [PriceChartController::class, 'index']);
 Route::get('/collector-price', [PriceChartController::class, 'get']);
 Route::get('/connect', [ConnectController::class, 'connect']);

 Route::get('/collectors',[CollectorController::class, 'show']);

 Route::post('/addDaily',[RecordController::class, 'addDailyRecord']);

 Route::post('/addSub',[RecordController::class, 'addSubRecord']);

 Route::post('/test1',[RecordController::class, 'test1']);



 Route::post('/updateName',[ProfileUpdateController::class, 'updateName']);
 Route::post('/changePassword',[NewPasswordController::class, 'changePassword']);



 Route::post('/inactiveCollectors',[ConnectController::class, 'inactiveCollectors']);
 Route::post('/sendRequest',[ConnectController::class, 'sendRequest']);
 Route::post('/incomingReqsFromFarmers',[ConnectController::class, 'incomingReqsFromFarmers']);


 Route::post('/acceptRequest',[ConnectController::class, 'acceptRequest']);

 Route::post('/connectedFarmersWithCollector',[ConnectController::class, 'connectedFarmersWithCollector']);
 Route::post('/connectedCollectorsWithFarmer',[ConnectController::class, 'connectedCollectorsWithFarmer']);
 

 Route::get('/get-farmers',[FarmerController::class, 'get']);
 Route::get('/get-collectors',[CollectorController::class, 'get']);