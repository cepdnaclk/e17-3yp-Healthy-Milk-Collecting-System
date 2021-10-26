@extends('layouts.app')
@section('content')
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <script>
  window.onload = function(){
    Swal.fire(
  {title:'Are you sure?',
  text:'You are about to remove {{$user->id}}',
  icon:'warning',
  showCancelButton: true,
  confirmButtonText: 'Yes',
   }).then(function() {
       
            window.location.href = "{{route('user-remove-confirm') . '?' . http_build_query(['id' => $user->id])}}";
    })
  }
</script>
@endsection  