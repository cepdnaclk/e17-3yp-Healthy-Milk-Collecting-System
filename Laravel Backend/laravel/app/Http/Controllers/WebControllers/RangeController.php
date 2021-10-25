<?php
namespace App\Http\Controllers\WebControllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\RangeVariables;
class RangeController extends Controller
{
    
    public function show(){
        try{
            $item = DB::table('range_variables')->select('*')->orderBy('created_at','DESC')->first();
            if($item!=null){
                return view('range',['item'=>collect($item)]);
            }else{
                
                $item = array();
                
                $item['pH3_low'] = 0;
                $item['pH2_low'] = 0;
                $item['pH1_low'] = 0;
                $item['pH1_high'] = 0;
                $item['pH2_high'] = 0;
                $item['pH3_high'] = 0;
                $item['fat3_low'] = 0; 
                $item['fat2_low'] = 0;
                $item['fat1_low'] = 0;
                $item['fat1_high'] = 0;
                $item['fat2_high'] = 0;
                $item['fat3_high'] = 0;
                $item['fat3_low_b'] = 0; 
                $item['fat2_low_b'] = 0;
                $item['fat1_low_b'] = 0;
                $item['fat1_high_b'] = 0;
                $item['fat2_high_b'] = 0;
                $item['fat3_high_b'] = 0;
                $item['den3_low'] = 0;
                $item['den2_low'] = 0;
                $item['den1_low'] = 0;
                $item['den1_high'] = 0;
                $item['den2_high'] = 0;
                $item['den3_high'] = 0;
                //dd(collect($item));
                return view('range',['item'=>collect($item)]);
            }
            
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function show_edit(){
        try{
            $item = DB::table('range_variables')->select('*')->orderBy('created_at','DESC')->first();
            if($item!=null){
                return view('range_edit',['item'=>collect($item)]);
            }else{
                
                $item = array();
                
                $item['pH3_low'] = 0;
                $item['pH2_low'] = 0;
                $item['pH1_low'] = 0;
                $item['pH1_high'] = 0;
                $item['pH2_high'] = 0;
                $item['pH3_high'] = 0;
                $item['fat3_low'] = 0; 
                $item['fat2_low'] = 0;
                $item['fat1_low'] = 0;
                $item['fat1_high'] = 0;
                $item['fat2_high'] = 0;
                $item['fat3_high'] = 0;
                $item['fat3_low_b'] = 0; 
                $item['fat2_low_b'] = 0;
                $item['fat1_low_b'] = 0;
                $item['fat1_high_b'] = 0;
                $item['fat2_high_b'] = 0;
                $item['fat3_high_b'] = 0;
                $item['den3_low'] = 0;
                $item['den2_low'] = 0;
                $item['den1_low'] = 0;
                $item['den1_high'] = 0;
                $item['den2_high'] = 0;
                $item['den3_high'] = 0;
                //dd(collect($item));
                return view('range_edit',['item'=>collect($item)]);
            }
            
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
    public function save(Request $req){
        
        $creds=[
            'pH3_low' => $req->input('PH3_low'),
            'pH2_low' =>$req->input('PH2_low'),
            'pH1_low' =>$req->input('PH1_low'),
            'pH1_high' =>$req->input('PH1_High'),
            'pH2_high' =>$req->input('PH2_High'),
            'pH3_high' =>$req->input('PH3_High'),
            'fat3_low' =>$req->input('Fat3_low'),
            'fat2_low' =>$req->input('Fat2_low'),
            'fat1_low' =>$req->input('Fat1_low'),
            'fat1_high'=>$req->input('Fat1_High'),
            'fat2_high'=>$req->input('Fat2_High'),
            'fat3_high'=>$req->input('Fat3_High'),
            'fat3_low_b' =>$req->input('Fat3_low_b'),
            'fat2_low_b' =>$req->input('Fat2_low_b'),
            'fat1_low_b' =>$req->input('Fat1_low_b'),
            'fat1_high_b'=>$req->input('Fat1_High_b'),
            'fat2_high_b'=>$req->input('Fat2_High_b'),
            'fat3_high_b'=>$req->input('Fat3_High_b'),
            'den3_low' =>$req->input('Density3_low'),
            'den2_low' =>$req->input('Density2_low'),
            'den1_low' =>$req->input('Density1_low'),
            'den1_high' =>$req->input('Density1_high'),
            'den2_high' =>$req->input('Density2_high'),
            'den3_high' =>$req->input('Density3_high'),
            ];
            
            try{
                //dd($creds);
                $record = RangeVariables::create($creds);
                return view('success',['message'=>'successfully updated ranges']);
        } catch (\Throwable $th) {
            return response(
                [
                    
                    'error_message' => $th,
                    
                ],
                
            );
        }
    }
}
