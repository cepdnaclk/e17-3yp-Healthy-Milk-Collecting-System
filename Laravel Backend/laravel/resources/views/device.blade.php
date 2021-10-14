@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                
                <div class="container col-sm-6 col-md-10"><h5 class="mb-2">Registered Devices</h5>
                    <form id="device-form" class="form row" action="{{ route('device.add') }}" method="get">
                        @csrf
                            <h6 class="text-center text-gray m-2 ">Create new device record</h6>
                            <div class="form-group m-4 col-2">
                                
                                <input type="text" name="batch" id="batch" class="form-control" placeholder="batch" required>
                            </div>
                            <div class="form-group m-4 col-3">
                                
                                <input type="text" name="desc" id="desc" placeholder="description" class="form-control">
                            </div>
                            <div class="form-group m-4 col-2">
                               
                                <button  type="submit" class="btn btn-info btn-md">Add</button>
                            </div>
                            
                        </form>
                  <table class="table table-bordered table-hover" style="background-color: deepskyblue;">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">ID</th>
                            <th scope="col" class="bg-primary">Batch</th>
                            <th scope="col" class="bg-primary">Description</th>
                            
                            <th scope="col" class="bg-danger">options</th>
                          </tr>
                      </thead>
                      <tbody>
                          @foreach ($devices as $device)
                          <tr>
                          <td>{{ $device->id }}</td>
                          <td>{{ $device->batch }}</td>
                          <td>{{ $device->description }}</td>
                          
                          <td><a href="{{route('device-edit') . '?' . http_build_query(['id' => $device->id])}}" class="btn btn-primary">Edit</a>
                          <a href="{{route('device-remove') . '?' . http_build_query(['id' => $device->id])}}"  class="btn btn-danger">Delete</a></td>
                          </tr>
                          @endforeach
                      </tbody>
                  </table>
                  {{ $devices->links() }}
              </div>
        </div>
   
@endsection   