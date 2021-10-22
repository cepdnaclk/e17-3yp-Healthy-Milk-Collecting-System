@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <form id="chart-form" class="form" action="{{ route('collector-save')}}" method="put">
        @CSRF
        <div class="container col-sm-6  col-md-11 col-md-offset-1">
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
        
        </div>
        </form>
        </div>
   
@endsection   
