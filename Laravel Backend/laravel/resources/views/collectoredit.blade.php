@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <div class="row d-flex justify-content-center">
        <form id="chart-form" class="form col-12" action="{{url('collector-save')}}" method="put" >
        <table class="table table-bordered " style="background-color: white">
                      <thead class="thead-light">
                          <tr>
                          <th scope="col" class="bg-primary">User ID</th>
                            <th scope="col" class="bg-primary">collector id</th>
                            <th scope="col" class="bg-primary">Username</th>
                            <th scope="col" class="bg-primary">Email</th>
                            <th scope="col" class="bg-primary">Contact</th>
                            <th scope="col" class="bg-primary">Address</th>
                            <th scope="col" class="bg-primary">businesstype</th>
                          </tr>
                      </thead>
                      <tbody>
                          
                          <tr>
                          <td ><input name="id" value="{{ $user['user_id'] }}"  style="border:none;outline:0;"></input></td>
                          <td><input name="name" value="{{ $user['collector_id'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="email" value="{{ $user['name'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="businesstype" value="{{ $user['email']}}" style="border:none;outline:0;"></input></td>
                          <td ><input name="id" value="{{ $user['contact'] }}"  style="border:none;outline:0;"></input></td>
                          <td><input name="name" value="{{ $user['address'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="email" value="{{ $user['businesstype'] }}" style="border:none;outline:0;"></input></td>
                          </tr>
                          
                      </tbody>
        </table>
        <input type="submit" name="submit" class="btn btn-info btn-md" value="Save changes">
        </form>
        </div>
        </div>
   
@endsection   
