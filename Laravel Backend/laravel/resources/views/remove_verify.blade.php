@extends('layouts.app')
@section('content')
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <script>
  @if (request()->is('main/remove-record-verify'))
  window.onload = function(){
    Swal.fire(
  {
  title:'Are you sure to remove?',
  text:'You are about to remove {{$daily_record_id}}',
  icon:'warning',
  showCancelButton: true,
  confirmButtonText: 'Yes',
   }).then(function() {
       
            window.location.href = "{{route('remove-record') . '?' . http_build_query(['daily_record_id' => $daily_record_id])}}";
    })
  }
  @endif
  @if (request()->is('main/device-remove-verify'))
  window.onload = function(){
    Swal.fire(
  {
  title:'Are you sure to remove?',
  text:'You are about to remove {{$id}}',
  icon:'warning',
  showCancelButton: true,
  confirmButtonText: 'Yes',
   }).then(function() {
       
            window.location.href = "{{route('device-remove') . '?' . http_build_query(['id' => $id])}}";
    })
  }
  @endif
  @if (request()->is('main/invite-remove-verify'))
  window.onload = function(){
    Swal.fire(
  {
  title:'Are you sure to remove?',
  text:'You are about to remove {{$id}}',
  icon:'warning',
  showCancelButton: true,
  confirmButtonText: 'Yes',
   }).then(function() {
       
            window.location.href = "{{route('invite-remove') . '?' . http_build_query(['id' => $id])}}";
    })
  }
  @endif
  
</script>
@endsection  