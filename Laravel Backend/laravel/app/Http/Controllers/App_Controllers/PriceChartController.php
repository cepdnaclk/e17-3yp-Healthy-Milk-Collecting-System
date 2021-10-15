<?php

namespace App\Http\Controllers\App_Controllers;

use Illuminate\Http\Request;
use App\Models\PriceChange;
use Illuminate\Support\Facades\DB;////
use Carbon\Carbon;
class PriceChartController extends Controller
{
    
    public function index(Request $req)
    {
        try{
            $id = $req->input('id');
            $items = DB::table('price_changes')->select('*')->where('collector_id', $id)
            ->orderBy('created_at')->get();
            $day=array();
            $values =array();
            if(count($items)>0){
                foreach ($items as $item) {
                    //  $value = DB::table('price_changes')->where('added_date', $date)->value('a');
                    array_push($day,$item->created_at);
                    array_push($values,array($item->a,$item->b,$item->c,$item->d));
                }
                $arr=array_combine($day, $values);
                return view('price')->with(compact('arr'))->with(compact('id'));
                //dd(count($items));
                dd(count($items));
                ///return view('price')->with('days',$day)->with('valuesA',$valuesA);
            }else{
                return view('Notfound',['user'=>$id]);
            }
        }catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function save(Request $req){
        
            $creds=[
                'collector_id'=>$req->input('id'),
                'a'=>$req->input('a'),
                'b'=>$req->input('b'),
                'c'=>$req->input('c'),
                'd'=>$req->input('d')
            ];
            try{
                $collector=DB::table('collectors')->where('id',$req->input('id'))->first();
                //dd($collector);
                if($collector!=null){
                    PriceChange::create($creds);
                }else{
                    return response(
                        [
                            
                            'error_message' => 'no collector with id '.$req->input('id'),
                            
                        ],
                        
                    );
                }
                //
            // //DB::table('price_changes')->insert([
            //     'collector_id' => $req->input('id'),
            //     'a'=>$req->input('a'),
            //     'b'=>$req->input('b'),
            //     'c'=>$req->input('c'),
            //     'd'=>$req->input('d')
            // ]);
            //dd($creds);
        //insert
            }catch (\Throwable $th) {
                return response(
                    [
                        
                        'error_message' => $th,
                        
                    ],
                    
                );
            }
    }
    public function get(Request $req){
        $id = $req->input('id');
        $item = DB::table('price_changes')->select('*')->where('collector_id', $id)->orderBy('created_at','DESC')->first();
        
        return $item;
    }
}
