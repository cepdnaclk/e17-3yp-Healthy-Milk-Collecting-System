<?php
 
$dataPointsA = array();
$dataPointsB = array();
$dataPointsC = array();
$dataPointsD = array();

foreach($priceArr as $value){
  array_push($dataPointsA,array("y"=>$value[1],"label"=>$value[0]));
  array_push($dataPointsB,array("y"=>$value[2],"label"=>$value[0]));
  array_push($dataPointsC,array("y"=>$value[3],"label"=>$value[0]));
  array_push($dataPointsD,array("y"=>$value[4],"label"=>$value[0]));

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
		itemclick: toggleDataSeries
	},
	data: [{
		type: "column",
		name: "A",
		indexLabel: "{y}",
		yValueFormatString: "#0.##",
		showInLegend: true,
		dataPoints: <?php echo json_encode($dataPointsA, JSON_NUMERIC_CHECK); ?>
	},{
		type: "column",
		name: "B",
		indexLabel: "{y}",
		yValueFormatString: "#0.##",
		showInLegend: true,
		dataPoints: <?php echo json_encode($dataPointsB, JSON_NUMERIC_CHECK); ?>
	},
    {
		type: "column",
		name: "C",
		indexLabel: "{y}",
		yValueFormatString: "#0.##",
		showInLegend: true,
		dataPoints: <?php echo json_encode($dataPointsC, JSON_NUMERIC_CHECK); ?>
	},
    {
		type: "column",
		name: "D",
		indexLabel: "{y}",
		yValueFormatString: "#0.##",
		showInLegend: true,
		dataPoints: <?php echo json_encode($dataPointsD, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 
function toggleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	}
	else{
		e.dataSeries.visible = true;
	}
	chart.render();
}
 
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
