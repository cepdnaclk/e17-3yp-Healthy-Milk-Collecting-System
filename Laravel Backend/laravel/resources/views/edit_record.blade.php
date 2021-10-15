@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <form id="chart-form" class="form" action="{{ route('record-save')}}" method="put">
        <div class="container col-sm-6  col-md-11 col-md-offset-1">
        <label for="id" class="text-gray">Sub Record ID:</label>
        <input name="id" readonly value="{{ $record['id'] }}" class="text-center" style="border:none;outline:0;"></input>
        <label for="daily_record_id" class="text-gray">Daily Record ID:</label>
        <input name="daily_record_id" readonly value="{{ $record['daily_record_id'] }}" class="text-center" style="border:none;outline:0;"></input>
        <table class="table table-bordered " style="background-color: white;">
                      <thead class="thead-light">
                          <tr>
                           
                            <th class="bg-primary">Price rate</th>
                            <th class="bg-primary">Volume</th>
                            
                          </tr>
                      </thead>
                      <tbody>
                          
                          <tr>
                          <td><input name="price_rate" value="{{ $record['price_rate'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="volume" value="{{ $record['volume'] }}" style="border:none;outline:0;"></input></td>
                          
                          </tr>
                          
                      </tbody>
        </table>
        <input type="submit" name="submit" class="btn btn-info btn-md" value="Save changes">
        
        </div>
        </form>
        </div>
   
@endsection   
