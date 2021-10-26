@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <div class="row d-flex justify-content-center">
        @if (request()->is('main/pricerate'))
            <form id="chart-form" class="form col-12" action="{{ route('get-price')}}" method="get" >  
        @endif
        @if (request()->is('main/get-volume-filter'))
            <form id="chart-form" class="form col-12" action="{{ route('get-volume')}}" method="get" >  
        @endif
        @if (request()->is('main/quality-chart-filter'))
            <form id="chart-form" class="form col-12" action="{{ route('quality-chart')}}" method="get" >  
        @endif  
            <div class="col-8 m-4">
            <div class="form-group m-4">
                <label for="id" class="text-gray">Collector ID:</label><br>
                <input type="text" name="id" id="id" class="form-control">
            </div>
            @if (request()->is('main/quality-chart-filter'))
            <div class="form-group m-4">
                <label for="farmer_id" class="text-gray">Farmer ID:</label><br>
                <input type="text" name="farmer_id" id="farmer_id" class="form-control">
            </div>
            @endif
            <div class="form-group m-4">
                
                <input type="submit" name="submit" class="btn btn-info btn-md" value="submit">
            </div>
            </div>
            </form>
        </div>
        </div>
@endsection  

