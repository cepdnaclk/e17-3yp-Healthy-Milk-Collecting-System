<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PriceChange;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
class PriceChartController extends Controller
{
    //
    public function index(Request $req)
    {
    
        $email = $req->input('email');
        $items = DB::table('price_changes')->select('*')->where('collector_email', $email)->orderBy("added_date")->get();
        $day=array();
        $valuesA =array();
        if(count($items)>0){
            foreach ($items as $item) {
                //  $value = DB::table('price_changes')->where('added_date', $date)->value('a');
                  array_push($day,$item->added_date);
                  array_push($valuesA,array($item->a,$item->b,$item->c,$item->d,$item->collector_id));
              }
              $arr=array_combine($day, $valuesA);
              return view('price')->with(compact('arr'));
              //dd(count($items));
              ///return view('price')->with('days',$day)->with('valuesA',$valuesA);
        }else{
            return view('Notfound',['user'=>$email]);
        }
    }
}
