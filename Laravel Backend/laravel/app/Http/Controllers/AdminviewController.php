<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use DB;
use App\Http\Requests;
use App\Http\Controllers\Controller;

class AdminviewController extends Controller {

public function index(){
$users = DB::select('select * from admin');
return view('admin',['users'=>$users]);
}


}
//012