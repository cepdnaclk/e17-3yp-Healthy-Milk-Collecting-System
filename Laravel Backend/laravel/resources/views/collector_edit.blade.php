@extends('layouts.app')
@section('content')
        <div class="container-fluid row">
                <!-- Small boxes (Stat box) -->
        
        <div class="container col-sm-6  col-md-11 col-md-offset-1">
        <form id="chart-form" class="form" action="{{ route('collector-save')}}" method="put">
        @CSRF
        <label for="user_id" class="text-gray">User ID:</label>
        <input name="user_id" readonly value="{{ $user['user_id'] }}" class="text-center" style="border:none;outline:0;"></input>
        <label for="id" class="text-gray">Collector ID:</label>
        <input name="id" readonly value="{{ $user['collector_id'] }}" class="text-center" style="border:none;outline:0;"></input>
        <table class="table table-bordered " style="background-color: white;">
                      <thead class="thead-light">
                          <tr>
                           
                            <th class="bg-primary">Firstname</th>
                            <th class="bg-primary">Lastname</th>
                            <th class="bg-primary">Email</th>
                            <th class="bg-primary">Contact</th>
                            <th class="bg-primary">Address</th>
                            <th class="bg-primary">businesstype</th>
                            
                          </tr>
                      </thead>
                      <tbody>
                          
                          <tr>
                          <td><input name="firstname" value="{{ $user['firstname'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="lastname" value="{{ $user['lastname'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="email" value="{{ $user['email']}}" style="border:none;outline:0;"></input></td>
                          <td><input name="contact" value="{{ $user['contact'] }}"  style="border:none;outline:0;"></input></td>
                          <td><input name="address" value="{{ $user['address'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="businesstype" value="{{ $user['businesstype'] }}" style="border:none;outline:0;"></input></td>
                          </tr>
                          
                      </tbody>
        </table>
        <input type="submit" name="submit" class="btn btn-info btn-md" value="Save changes">
        </form>
        <form id="set-form" class="form m-4" action="{{ route('set-device')}}" method="put">
        @CSRF
        <label for="collector_id" class="text-gray">Collector ID:</label>
        <input name="collector_id" readonly value="{{ $user['collector_id'] }}" class="text-center" style="border:none;outline:0;"></input>
        <label for="device_id" class="text-dark" style="margin-right:10px;">Device ID:</label>
        <input name="device_id" class="text-center" value="{{ $user['device_id'] }}" style="border:none;outline:0;margin-right:10px;"></input>
        <button type="submit" class="btn btn-success">Set device</button>  
        </form>
        <form id="set-price" class="form m-4" action="{{ route('price-save')}}" method="put">
        @CSRF
        <label for="id" class="text-gray d-none">Collector ID:</label>
        <input name="id" readonly value="{{ $user['collector_id'] }}" class="text-center d-none" style="border:none;outline:0;"></input>
        <br><label for="a" class="text-dark" style="margin-right:10px;">A:</label>
        <input name="a" class="text-center" value="{{ $user['a'] }}" style="border:none;outline:0;margin-right:10px;"></input>
        <label for="b" class="text-dark" style="margin-right:10px;">B:</label>
        <input name="b" class="text-center" value="{{ $user['b'] }}" style="border:none;outline:0;margin-right:10px;"></input>
        <label for="c" class="text-dark" style="margin-right:10px;">C:</label>
        <input name="c" class="text-center" value="{{ $user['c'] }}" style="border:none;outline:0;margin-right:10px;"></input>
        <label for="d" class="text-dark" style="margin-right:10px;">D:</label>
        <input name="d" class="text-center" value="{{ $user['d'] }}" style="border:none;outline:0;margin-right:10px;"></input>
        <button type="submit" class="btn btn-success">Set Price</button>  
        </form>
        </div>
        
        </div>
   
@endsection   
