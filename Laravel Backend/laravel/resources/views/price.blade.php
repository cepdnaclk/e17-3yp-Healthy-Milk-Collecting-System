<?php
 
$dataPointsA = array();
$dataPointsB = array();
$dataPointsC = array();
$dataPointsD = array();

foreach($arr as $key=> $value){
  array_push($dataPointsA,array("y"=>$value[0],"label"=>$key));
  array_push($dataPointsB,array("y"=>$value[1],"label"=>$key));
  array_push($dataPointsC,array("y"=>$value[2],"label"=>$key));
  array_push($dataPointsD,array("y"=>$value[3],"label"=>$key));

}
?>
<!DOCTYPE HTML>
<html lang="en">

<head>
 
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script> 
  <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script> -->
  <script>
window.onload = function () {
 
var chart = new CanvasJS.Chart("chartContainer", {
	title: {
		text: "Milk price changes for each grade"
	},
	subtitles: [{
		text: "collector_id: "+{{$id}}
	}],
	axisY: {
		title: "LKR"
	},
	data: [{
		type: "stepLine",
		dataPoints: <?php echo json_encode($dataPointsA, JSON_NUMERIC_CHECK); ?>
	},
  {
		type: "stepLine",
		dataPoints: <?php echo json_encode($dataPointsB, JSON_NUMERIC_CHECK); ?>
	},
  {
		type: "stepLine",
		dataPoints: <?php echo json_encode($dataPointsC, JSON_NUMERIC_CHECK); ?>
	},
  {
		type: "stepLine",
		dataPoints: <?php echo json_encode($dataPointsD, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 
}
</script>
  <!-- <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script> -->
  </head>
  <body>
@extends('layouts.app')
@section('content')
<div class="container-fluid">
       
        
        
        <div id="chartContainer" style="height: 370px; width: 100%;"></div>
        
</div>

@endsection  
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>
