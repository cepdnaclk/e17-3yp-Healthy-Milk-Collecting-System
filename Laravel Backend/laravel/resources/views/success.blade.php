
@extends('layouts.app')
@section('content')
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  
<script>
  window.onload = function(){
    Swal.fire(
  'Good job!',
  '{{$message}}',
  'success',
    ).then(function() {
            window.location.href = "{{route('admin.dashboard')}}";
        })
  }
</script>
@endsection  
