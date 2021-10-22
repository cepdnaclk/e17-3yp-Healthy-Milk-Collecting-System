@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <form id="chart-form" class="form" action="{{ route('device-save')}}" method="put">
        @CSRF
        <div class="container col-sm-6  col-md-11 col-md-offset-1">
        <label for="id" class="text-gray">ID:</label>
        <input name="id" readonly value="{{ $device->id}}" class="text-center" style="border:none;outline:0;"></input>
        <table class="table table-bordered " style="background-color: white;">
                      <thead class="thead-light">
                          <tr>
                           
                            <th class="bg-primary">Batch</th>
                            <th class="bg-primary">Desciption</th>

                            
                          </tr>
                      </thead>
                      <tbody>
                          
                          <tr>
                          <td><input name="batch" value="{{ $device->batch }}" style="border:none;outline:0;"></input></td>
                          <td><input name="description" value="{{ $device->description }}"  style="border:none;outline:0;"></input></td>
                          </tr>
                          
                      </tbody>
        </table>
        <input type="submit" name="submit" class="btn btn-info btn-md" value="Save changes">
        
        </div>
        </form>
        </div>
   
@endsection   
