<?php
 
$dataPoints = array();


foreach($arr as $key=> $value){
  array_push($dataPoints,array("y"=>$value,"label"=>$key));

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
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "MilkTab Current Price Values for each grade All in one"
	},
	axisY:{
		includeZero: true
	},
	legend:{
		cursor: "pointer",
		verticalAlign: "center",
		horizontalAlign: "right",
	},
	data: [{
		type: "column",
		name: "volume",
		indexLabel: "{y}",
		yValueFormatString: "#0.##",
		showInLegend: true,
		dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 

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
