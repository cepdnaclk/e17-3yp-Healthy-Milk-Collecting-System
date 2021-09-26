<!DOCTYPE HTML>
<html>

<head>  
  <script type="text/javascript">
  window.onload = function () {
    var chart= new CanvasJS.Chart("chartContainer", {
      
      title:{
        text: "MultiSeries StepLine Chart"
      },


      axisX: {
        lineThickness: 2
      },

      data: [
      {
       type: "stepLine",  
      
       dataPoints: <?php echo json_encode($data, JSON_NUMERIC_CHECK); ?>
     },
    //  {
    //    type: "stepLine",  
    //    dataPoints: [

    //    { x: new Date(2008,02), y: 41.00 },
    //    { x: new Date(2008,03), y: 42.50 },
    //    { x: new Date(2008,04), y: 41.00 },
    //    { x: new Date(2008,05), y: 45.30 },
    //    { x: new Date(2008,06), y: 47.55 },
    //    { x: new Date(2008,07), y: 45.00 },
    //    { x: new Date(2008,08), y: 40.70 },
    //    { x: new Date(2008,09), y: 37.00 }

    //    ]
    //  }
     ]
   });
chart.render();
}
</script>
  <script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script></head>
<body>
  
  <div id="chartContainer" style="height: 300px; width: 100%;">
  </div>
</body>
</html>
