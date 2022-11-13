<style type='text/css'>
    #myInput {
        
        background-position: 10px 12px; /* Position the search icon */
        background-repeat: no-repeat; /* Do not repeat the icon image */
        width: 100%; /* Full-width */
        font-size: 16px; /* Increase font-size */
        padding: 12px 20px 12px 40px; /* Add some padding */
        border: 1px solid #ddd; /* Add a grey border */
        margin-bottom: 12px; /* Add some space below the input */
    }
    

</style>
@extends('layouts.app')
@section('content')
        <div class="container-fluid">
                
                <div class="container col-sm-6 col-md-10"><h5 class="mb-2">Registered Devices</h5>
                    <form id="device-form" class="form row" action="{{ route('device.add') }}" method="get">
                        @csrf
                            <h6 class="text-center text-gray m-2 col-12">Create new device record</h6>
                            <div class="form-group m-2 col-2">
                                
                                <input type="text" name="batch" id="batch" class="form-control" placeholder="batch" required>
                            </div>
                            <div class="form-group m-2 col-3">
                                
                                <input type="text" name="description" id="desc" placeholder="description" class="form-control">
                            </div>
                            <div class="form-group m-2 col-3">
                                
                                <input type="text" name="status" id="status" placeholder="status" class="form-control">
                            </div>
                            <div class="form-group m-2 col-2">
                               
                                <button  type="submit" class="btn btn-primary btn-md">Add</button>
                            </div>
                            
                        </form>
                  <input type="text" id="myInput"  onkeyup="myfilter()" placeholder="Search for desc..">
                  <table class="table table-bordered table-hover" style="background-color: deepskyblue;"  id="myTable">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">ID</th>
                            <th scope="col" class="bg-primary">Batch</th>
                            <th scope="col" class="bg-primary">Description</th>
                            <th scope="col" class="bg-primary">Status</th>
                            <th scope="col" class="bg-success">options</th>
                          </tr>
                      </thead>
                      <tbody>
                          @foreach ($devices as $device)
                          <tr>
                          <td>{{ $device->id }}</td>
                          <td>{{ $device->batch }}</td>
                          <td>{{ $device->description }}</td>
                          <td>{{ $device->status }}</td>
                          <td><a href="{{route('device-edit') . '?' . http_build_query(['id' => $device->id])}}" class="btn btn-primary">Edit</a>
                          <a href="{{route('device-remove-verify') . '?' . http_build_query(['id' => $device->id])}}"  class="btn btn-danger">Delete</a></td>
                          </tr>
                          @endforeach
                      </tbody>
                  </table>
                  {{ $devices->links() }}
              </div>
        </div>
   
@endsection   
<script>
function myfilter() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
</script>