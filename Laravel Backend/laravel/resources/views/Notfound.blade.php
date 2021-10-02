
@extends('layouts.app')
@section('content')
<script>
  window.onload = function(){
  Swal.fire(
  'Not Found!',
  'There is no record {{$user}}',
  'warning',
    ).then(function() {
            window.location.href = "main";
        })
  }
</script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script> 
@endsection  