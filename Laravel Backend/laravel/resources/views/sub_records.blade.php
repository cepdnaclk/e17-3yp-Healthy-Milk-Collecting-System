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
                
                <div class="container col-sm-6  col-md-10 col-md-offset-1">
                <h5 class="mb-2 text-dark">Sub Records</h5>
                <input type="text" id="myInput" onkeyup="myfilter()" placeholder="Search for names..">
                  <table class="table table-bordered table-hover" style="background-color: deepskyblue;" id="myTable">
                      <thead class="thead-light">
                          <tr>
                            <th scope="col" class="bg-primary">Record ID</th>
                            <th scope="col" class="bg-primary">Daily Record ID</th>
                            <th scope="col" class="bg-primary">pH</th>
                            <th scope="col" class="bg-primary">Density</th>
                            <th scope="col" class="bg-primary">Temperature</th>
                            <th scope="col" class="bg-primary">volume</th>
                            <th scope="col" class="bg-primary">fatrate</th>
                            <th scope="col" class="bg-primary">Grade</th>
                            <th scope="col" class="bg-primary">Price rate</th>
                            
                            <th scope="col" class="bg-danger">Options</th>
                          </tr>
                      </thead>
                      <tbody>
                      @foreach($records as $record)
                          <tr>
                          
                          <td>{{ $record['id'] }}</td>
                          <td>{{ $record['daily_record_id'] }}</td>
                          <td>{{ $record['ph_value'] }}</td>
                          <td>{{ $record['density'] }}</td>
                          <td>{{ $record['temperature'] }}</td>
                          <td>{{ $record['volume'] }}</td>
                          <td>{{ $record['fat_rate'] }}</td>
                          <td>{{ $record['grade'] }}</td>
                          <td>{{ $record['price_rate'] }}</td>
                          <td>
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
    td = tr[i].getElementsByTagName("td")[0];
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