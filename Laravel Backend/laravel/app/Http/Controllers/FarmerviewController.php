<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use DB;
use App\Http\Requests;
use App\Http\Controllers\Controller;
class FarmerviewController extends Controller {
public function index(){
$users = DB::select('select * from users');
return view('farmer',['users'=>$users]);
}
}
//012