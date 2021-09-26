<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use Illuminate\Routing\Controller as BaseController;

if(isset($_GET['submit'])){
    $email = $_GET['email'];
}
class ChartController extends BaseController
{
   
//    public function viewChart()
//    {   
//        $post = DB::table('chart_data')->paginate(5);

//        return view("chart");
   
//        //return view("blog", compact("posts"));
//    }
//    public function createStudentData(Request $request)
//    {
//         return view('addChart');
//    }

//    public function storeStudentData(Request $request)
//    {
//         $data = array(
//           'student_name'=> $request->post('name'),
//           'student_subject' =>$request->post('subject'),
//           'student_marks'=> $request->post('marks')
//         );

//         $post = DB::table('chart_data')->insert($data);
//         Alert::success('Success', 'Data Berhasil Ditambahkan');
//         return redirect('chart'); //->with('success', 'The Data Inserted');
//    }

//    public function deleteStudentData(Request $request)
//    {
//         $deleteID = $request->post('deleteID');
//         $post = DB::table('chart_data')->where('id', '=', $deleteID)->delete();
//         if($post)
//         {
//             return redirect('chart')->with('success', 'The Data Delete');
//         }
//         else
//         {
//             return redirect('chart')->with('error', 'Cant not Delete');
//         }
//    }

   public function showStatics()
   {
      $post = DB::table('Pricechart')->where('email', '=', $email)->toArray();
      foreach($post as $row)
       {
          $data[] = array
           (
            'label'=>$row->day,
            'y'=>$row->pricerate
           ); 
       }
      return view('price',['data' => $data]);
   }
}

//012