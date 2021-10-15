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
                
                <div class="container col-sm-6  col-md-10 col-md-offset-1">
                <h5 class="mb-2">Registered collectors</h5>
                <input type="text" id="myInput" onkeyup="myfilter()" placeholder="Search for names..">

                  <table id="myTable" class="table table-bordered table-hover" style="background-color: deepskyblue;">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">User ID</th>
                            <th scope="col" class="bg-primary">collector id</th>
                            <th scope="col" class="bg-primary">Username</th>
                            <th scope="col" class="bg-primary">Email</th>
                            <th scope="col" class="bg-primary">Contact</th>
                            <th scope="col" class="bg-primary">Address</th>
                            <th scope="col" class="bg-primary">businesstype</th>
                            
                            <th scope="col" class="bg-danger">Options</th>
                          </tr>
                      </thead>
                      <tbody>
                          @foreach ($collectors as $user)
                          <tr>
                          <?php $user_id= $user['user_id'];
                          $collector_id=$user['collector_id']?>
                          <td>{{ $user["user_id"] }}</td>
                          <td>{{ $user["collector_id"] }}</td>
                          <td>{{ $user["name"] }}</td>
                          <td>{{ $user["email"] }}</td>
                          <td>{{ $user["contact"] }}</td>
                          <td>{{ $user["address"] }}</td>
                          <td>{{ $user["businesstype"] }}</td>
                          <td><a href="{{route('get-farmers') . '?' . http_build_query(['id' => $collector_id])}}"  class="btn btn-success">Farmers</a>
                          <a href="{{route('collector-edit') . '?' . http_build_query(['id' => $user_id])}}" class="btn btn-primary">Edit</a>
                          <a href="{{route('user-remove') . '?' . http_build_query(['id' => $user_id])}}"  class="btn btn-danger">Delete</a></td> 
                          </tr>
                          @endforeach
                      </tbody>
                  </table>
                  @if ($page_data['current_page']>1)
                  <a href="{{route('admin.dashboard.collectors'). '?' . http_build_query(['page' => $page_data['current_page']-1])}}" class="btn btn-info"><i class="fas fa-angle-double-left"></i></a>
                  @endif
                  @if ($page_data['next_page_url']!=null)
                  <a href="{{route('admin.dashboard.collectors'). '?' . http_build_query(['page' => $page_data['current_page']+1])}}" class="btn btn-info"><i class="fas fa-angle-double-right"></i></a>
                  @endif
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