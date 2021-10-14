@extends('layouts.app')
@section('content')
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
    #myTable {
        border-collapse: collapse;
        width: 100%;
        border: 1px solid #ddd;
        font-size: 18px;
    }

</style>
        <div class="container-fluid">
                
                <div class="container col-sm-6  col-md-10 col-md-offset-1"><h5 class="mb-2">Daily Records</h5>
                <input type="text" id="myInput" onkeyup="myfilter()" placeholder="Search for names..">
                  <table class="table table-bordered table-hover" style="background-color: deepskyblue;" id="myTable">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">Record ID</th>
                            <th scope="col" class="bg-primary">collector id</th>
                            <th scope="col" class="bg-primary">Farmername/ID</th>
                            <th scope="col" class="bg-primary">Device ID</th>
                            <th scope="col" class="bg-primary">Date</th>
                            <th scope="col" class="bg-primary">Total volume</th>
                            <th scope="col" class="bg-primary">Avg temp</th>
                            <th scope="col" class="bg-primary">Avg pH</th>
                            <th scope="col" class="bg-primary">Avg fatrate</th>
                            
                            <th scope="col" class="bg-danger">Options</th>
                          </tr>
                      </thead>
                      <tbody>
                         @foreach($records as $record)
                          <tr>
                          <?php 
                          $daily_record = $record['id']
                          ?>
                          <td>{{ $record['id'] }}</td>
                          <td>{{ $record['collector_id'] }}</td>
                          <td>{{ $record['farmer_id'] }}</td>
                          <td>{{ $record['device_id'] }}</td>
                          <td>{{ $record['created_at'] }}</td>
                          <td>{{ $record['total_volume'] }}</td>
                          <td>{{ $record['temperature'] }}</td>
                          <td>{{ $record['ph_value'] }}</td>
                          <td>{{ $record['fat_rate'] }}</td>
                          <td><a href="{{route('admin.dashboard.sub_records') . '?' . http_build_query(['daily_record_id' => $daily_record])}}"  class="btn btn-success">sub records</a>
                          <a href="" class="btn btn-primary">Edit</a>
                          <a href=""  class="btn btn-danger">Delete</a></td> 
                          </tr>
                        @endforeach
                      </tbody>
                  </table>
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
    td = tr[i].getElementsByTagName("td")[1];
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