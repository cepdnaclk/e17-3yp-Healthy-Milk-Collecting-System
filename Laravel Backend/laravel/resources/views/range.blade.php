@extends('layouts.app')
@section('content')
<head>
<style type="text/css">
.slidecontainer {
  width: 100%; /* Width of the outside container */

}

/* The slider itself */
.slider {
  -webkit-appearance: none;  /* Override default CSS styles */
  appearance: none;
  width: 100%; /* Full-width */
  height: 15px;
  border-radius: 5px;
  background: #d3d3d3; /* Grey background */
  outline: none; /* Remove outline */
  opacity: 0.7; /* Set transparency (for mouse-over effects on hover) */
  -webkit-transition: .2s; /* 0.2 seconds transition on hover */
  transition: opacity .2s;
  background: blue;
}

/* Mouse-over effects */
.slider:hover {
  opacity: 1; /* Fully shown on mouse-over */
}

/* The slider handle (use -webkit- (Chrome, Opera, Safari, Edge) and -moz- (Firefox) to override default look) */
.slider::-webkit-slider-thumb {
  -webkit-appearance: none; /* Override default look */
  appearance: none;
  width: 25px; /* Set a specific slider handle width */
  height: 25px;
  border-radius: 50%; 
  background: red; /* Green background */
  cursor: pointer; /* Cursor on hover */
}

.slider::-moz-range-thumb {
  width: 25px; /* Set a specific slider handle width */
  height: 25px;
  border-radius: 50%;
  background: red; /* Green background */
  cursor: pointer; /* Cursor on hover */
}
</style>
</head>
<body>
<div class="container-fluid">
        <!-- /.row -->
        <?php
        $PH3_low = $item['pH3_low'];
        $PH2_low = $item['pH2_low'];
        $PH1_low = $item['pH1_low'];
        $PH1_High = $item['pH1_high'];
        $PH2_High = $item['pH2_high'];
        $PH3_High = $item['pH3_high'];
        $Fat3_low = $item['fat3_low']; 
        $Fat2_low = $item['fat2_low'];
        $Fat1_low = $item['fat1_low'];
        $Fat1_High = $item['fat1_high'];
        $Fat2_High = $item['fat2_high'];
        $Fat3_High = $item['fat3_high'];
        $Fat3_low_b = $item['fat3_low_b']; 
        $Fat2_low_b = $item['fat2_low_b'];
        $Fat1_low_b = $item['fat1_low_b'];
        $Fat1_High_b = $item['fat1_high_b'];
        $Fat2_High_b = $item['fat2_high_b'];
        $Fat3_High_b = $item['fat3_high_b'];
        $Density3_low = $item['den3_low'];
        $Density2_low = $item['den2_low'];
        $Density1_low = $item['den1_low'];
        $Density1_high = $item['den1_high'];
        $Density2_high = $item['den2_high'];
        $Density3_high = $item['den3_high'];
        ?>
        
        <div class="slidecontainer row text-center">
          <label class="text-dark col-4">{{ $PH1_low }}</label><label class="text-dark col-4">PH1:</label><label class="text-dark col-4">{{ $PH1_High }}</label>
          <input type="range" min="0" max="14" value="{{ $PH1_low }}" class="slider my-1 col-6 bg-success" id="myRange1">
          <input type="range" min="0" max="14" value="{{ $PH1_High }}" class="slider my-1 col-6 bg-success" id="myRange2">
          <label class="text-dark col-4">{{ $PH2_low }}</label><label class="text-dark col-4">PH2:</label><label class="text-dark col-4">{{ $PH2_High }}</label>
          <input type="range" min="0" max="14" value="{{ $PH2_low }}" class="slider my-1 col-6" id="myRange3">
          <input type="range" min="0" max="14" value="{{ $PH2_High }}" class="slider my-1 col-6" id="myRange4">
          <label class="text-dark col-4">{{ $PH3_low }}</label><label class="text-dark col-4">PH3:</label><label class="text-dark col-4">{{ $PH3_High }}</label>
          <input type="range" min="0" max="14" value="{{ $PH3_low }}" class="slider my-1 col-6 bg-warning" id="myRange5">
          <input type="range" min="0" max="14" value="{{ $PH3_High }}" class="slider my-1 col-6 bg-warning" id="myRange6">
        </div>
        <hr>
        <div class="slidecontainer row text-center">
          <label class="text-dark col-4">{{ $Fat1_low }}</label>
          <label class="text-dark col-4">fatrate1:</label>
          <label class="text-dark col-4">{{ $Fat1_High }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat1_low }}" class="slider my-1 col-6 bg-success" id="myRange7">
          <input type="range" min="0" max="100" value="{{ $Fat1_High }}" class="slider my-1 col-6 bg-success" id="myRange8">
          <label class="text-dark col-4">{{ $Fat2_low }}</label>
          <label class="text-dark col-4">fatrate2:</label>
          <label class="text-dark col-4">{{ $Fat2_High }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat2_low }}" class="slider my-1 col-6" id="myRange9">
          <input type="range" min="0" max="100" value="{{ $Fat2_High }}" class="slider my-1 col-6" id="myRange10">
          <label class="text-dark col-4">{{ $Fat3_low }}</label>
          <label class="text-dark col-4">fatrate3:</label>
          <label class="text-dark col-4">{{ $Fat3_High }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat3_low }}" class="slider my-1 col-6 bg-warning" id="myRange11">
          <input type="range" min="0" max="100" value="{{ $Fat3_High }}" class="slider my-1 col-6 bg-warning" id="myRange12">
        </div>
        <hr>
        <div class="slidecontainer row text-center">
          <label class="text-dark col-4">{{ $Fat1_low_b }}</label>
          <label class="text-dark col-4">fatrate1_b :</label>
          <label class="text-dark col-4">{{ $Fat1_High_b }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat1_low_b }}" class="slider my-1 col-6 bg-success" id="myRange7">
          <input type="range" min="0" max="100" value="{{ $Fat1_High_b }}" class="slider my-1 col-6 bg-success" id="myRange8">
          <label class="text-dark col-4">{{ $Fat2_low_b }}</label>
          <label class="text-dark col-4">fatrate2_b :</label>
          <label class="text-dark col-4">{{ $Fat2_High_b }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat2_low_b }}" class="slider my-1 col-6" id="myRange9">
          <input type="range" min="0" max="100" value="{{ $Fat2_High_b }}" class="slider my-1 col-6" id="myRange10">
          <label class="text-dark col-4">{{ $Fat3_low_b }}</label>
          <label class="text-dark col-4">fatrate3_b :</label>
          <label class="text-dark col-4">{{ $Fat3_High_b }}</label>
          <input type="range" min="0" max="100" value="{{ $Fat3_low_b }}" class="slider my-1 col-6 bg-warning" id="myRange11">
          <input type="range" min="0" max="100" value="{{ $Fat3_High_b }}" class="slider my-1 col-6 bg-warning" id="myRange12">
        </div>
        <hr>
        <div class="slidecontainer row text-center">
          <label class="text-dark col-4">{{ $Density1_low }}</label><label class="text-dark col-4">density1:</label><label class="text-dark col-4">{{ $Density1_high }}</label>
          <input type="range" min="0" max="2" value="{{ $Density1_low }}" class="slider my-1 col-6 bg-success" id="myRange13">
          <input type="range" min="0" max="2" value="{{ $Density1_high }}" class="slider my-1 col-6 bg-success" id="myRange14">
          <label class="text-dark col-12">density2:</label>
          <input type="range" min="0" max="2" value="{{ $Density2_low }}" class="slider my-1 col-6" id="myRange15">
          <input type="range" min="0" max="2" value="{{ $Density2_high }}" class="slider my-1 col-6" id="myRange16">
          <label class="text-dark col-12">density3:</label>
          <input type="range" min="0" max="2" value="{{ $Density3_low }}" class="slider my-1 col-6 bg-warning" id="myRange17">
          <input type="range" min="0" max="2" value="{{ $Density3_high }}" class="slider my-1 col-6 bg-warning" id="myRange18">
        </div>
        

</div><!-- /.container-fluid -->
</body>
@endsection   
<script>

</script>