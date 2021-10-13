@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <!-- Small boxes (Stat box) -->
        <form id="chart-form" class="form" action="{{url('admin-save')}}" method="put">
        <div class="container col-sm-6  col-md-11 col-md-offset-1">
        <label for="id" class="text-gray">ID:</label>
        <input name="id" readonly value="{{ $user['id'] }}" style="border:none;outline:0;"></input>
        <table class="table table-bordered " style="background-color: white;">
                      <thead class="thead-light">
                          <tr>
                           
                            <th class="bg-primary">name</th>
                            <th class="bg-primary">Email</th>
                            <th class="bg-primary">Contact</th>

                            
                          </tr>
                      </thead>
                      <tbody>
                          
                          <tr>
                          <td><input name="name" value="{{ $user['name'] }}" style="border:none;outline:0;"></input></td>
                          <td><input name="email" value="{{ $user['email']}}" style="border:none;outline:0;"></input></td>
                          <td><input name="contact" value="{{ $user['contact'] }}"  style="border:none;outline:0;"></input></td>
                          </tr>
                          
                      </tbody>
        </table>
        <input type="submit" name="submit" class="btn btn-info btn-md" value="Save changes">
        
        </div>
        </form>
        </div>
   
@endsection   
