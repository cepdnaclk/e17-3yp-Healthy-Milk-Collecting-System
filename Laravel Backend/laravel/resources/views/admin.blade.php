@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                <h5 class="mb-2">Registered collectors</h5>
                <div class="container col-sm-6  col-md-10 col-md-offset-1">
                  <table class="table table-bordered table-hover" style="background-color: deepskyblue;">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">ID</th>
                            <th scope="col" class="bg-primary">Username</th>
                            <th scope="col" class="bg-primary">Email</th>
                            <th scope="col" class="bg-primary">Type</th>
                            <th scope="col" class="bg-primary">Edit</th>
                            <th scope="col" class="bg-danger">Delete</th>
                          </tr>
                      </thead>
                      <tbody>
                          @foreach ($users as $user)
                          <tr>
                          <td>{{ $user->id }}</td>
                          <td>{{ $user->name }}</td>
                          <td>{{ $user->email }}</td>
                          <td>{{ $user->businesstype }}</td>
                          <td><a href="{{url('collector-edit') . '?' . http_build_query(['id' => $user->id])}}" class="btn btn-primary">Edit</a></td>
                          <td><a href="{{url('user-remove') . '?' . http_build_query(['id' => $user->id])}}"  class="btn btn-danger">Delete</a></td>
                          </tr>
                          @endforeach
                      </tbody>
                  </table>
              </div>
        </div>
   
@endsection   