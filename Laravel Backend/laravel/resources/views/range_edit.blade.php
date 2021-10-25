@extends('layouts.app')
@section('content')
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
<div class="container">
        <div class="row  d-flex justify-content-center">
            <div class="col-md-12">
                <div class="card bg-gray">
                    <div class="card-header">
                        Edit Ranges
                    </div>
                    <div class="card-body">
                        
                        <form method="get" action="{{route('ranges_save')}}">
                            @csrf
                            <div class="row">
                                <div class="form-group col-2">
                                    <label for="PH3_low">PH3_low</label>
                                    <input type="text" class="form-control" id="PH3_low" name="PH3_low"  value="{{$PH3_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="PH2_low">PH2_low</label>
                                    <input type="text" class="form-control" id="PH2_low" name="PH2_low" value="{{$PH2_low}}" >
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="PH1_low">PH1_low</label>
                                    <input type="text" class="form-control" id="PH1_low" name="PH1_low"  value="{{$PH1_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="PH1_High">PH1_High</label>
                                    <input type="text" class="form-control" id="PH1_High" name="PH1_High"  value="{{$PH1_High}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="PH2_High">PH2_High</label>
                                    <input type="text" class="form-control" id="PH2_HighH" name="PH2_High"  value="{{$PH2_High}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="PH3_High">PH3_High</label>
                                    <input type="text" class="form-control" id="PH3_High" name="PH3_High"  value="{{$PH3_High}}">
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-2">
                                    <label for="Fat3_low">Fat3_low</label>
                                    <input type="text" class="form-control" id="Fat3_low" name="Fat3_low"  value="{{$Fat3_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat2_low">Fat2_low</label>
                                    <input type="text" class="form-control" id="Fat2_low" name="Fat2_low"  value="{{$Fat2_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat1_low">Fat1_low</label>
                                    <input type="text" class="form-control" id="Fat1_low" name="Fat1_low"  value="{{$Fat1_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat1_High">Fat1_High</label>
                                    <input type="text" class="form-control" id="Fat1_High" name="Fat1_High"  value="{{$Fat1_High}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat2_High">Fat2_High</label>
                                    <input type="text" class="form-control" id="Fat2_High" name="Fat2_High"  value="{{$Fat2_High}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat3_High">Fat3_High</label>
                                    <input type="text" class="form-control" id="Fat3_High" name="Fat3_High"  value="{{$Fat3_High}}">
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-2">
                                    <label for="Fat3_low_b">Fat3_low_b</label>
                                    <input type="text" class="form-control" id="Fat3_low_b" name="Fat3_low_b"  value="{{$Fat3_low_b}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat2_low_b">Fat2_low_b</label>
                                    <input type="text" class="form-control" id="Fat2_low_b" name="Fat2_low_b"  value="{{$Fat2_low_b}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat1_low_b">Fat1_low_b</label>
                                    <input type="text" class="form-control" id="Fat1_low_b" name="Fat1_low_b"  value="{{$Fat1_low_b}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat1_High_b">Fat1_High_b</label>
                                    <input type="text" class="form-control" id="Fat1_High_b" name="Fat1_High_b"  value="{{$Fat1_High_b}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat2_High_b">Fat2_High_b</label>
                                    <input type="text" class="form-control" id="Fat2_High_b" name="Fat2_High_b"  value="{{$Fat2_High_b}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Fat3_High_b">Fat3_High_b</label>
                                    <input type="text" class="form-control" id="Fat3_High_b" name="Fat3_High_b"  value="{{$Fat3_High_b}}">
                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-2">
                                    <label for="Density3_low">Density3_low</label>
                                    <input type="text" class="form-control" id="Density3_low" name="Density3_low"  value="{{$Density3_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Density2_low">Density2_low</label>
                                    <input type="text" class="form-control" id="Density2_low" name="Density2_low"  value="{{$Density2_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Density1_low">Density1_low</label>
                                    <input type="text" class="form-control" id="Density1_low" name="Density1_low"  value="{{$Density1_low}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Density1_high">Density1_high</label>
                                    <input type="text" class="form-control" id="Density1_high" name="Density1_high"  value="{{$Density1_high}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Density2_high">Density2_high</label>
                                    <input type="text" class="form-control" id="Density2_high" name="Density2_high"  value="{{$Density2_high}}">
                                    
                                </div>
                                <div class="form-group col-2">
                                    <label for="Density3_high">Density3_high</label>
                                    <input type="text" class="form-control" id="Density3_high" name="Density3_high"  value="{{$Density3_high}}">
                                    
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection   