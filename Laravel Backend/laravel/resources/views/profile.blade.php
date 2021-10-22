@extends('layouts.app')
@section('content')
        <div class="container">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-md-4">
                    <div class="col-md-12">
                    <?php $username = session()->get('user');
                    ?>
                    <a href="{{route('admin-edit'). '?' . http_build_query(['uname' => $username])}}" class="btn btn-info">Edit your details</a>
                    <h6 class="bg-cover border mt-3 p-2 text-center">change password</h6>
                        <form id="login-form" class="form" action="{{route('admin.edit.submit')}}" method="put">
                        @CSRF
                        <label for="username" class="text-gray">Username:</label>
                        <input name="username" readonly value="{{ $username }}" class="text-center" style="border:none;outline:0;"></input>
                        <div class="form-group m-4">
                                <label for="email" class="text-gray">Email:</label><br>
                                <input type="text" name="email" id="email" class="form-control" required>
                            </div>
                        <div class="form-group m-4">
                            <label for="c_password" class="text-gray">Current Password:</label><br>
                            <input type="password" name="c_password" id="c_password"  class="form-control" required>
                        </div>
                        <div class="form-group m-4">
                            <label for="password" class="text-gray">New Password:</label><br>
                            <input type="password" name="password" id="password"  class="form-control" required>
                        </div>
                        <div class="form-group m-4">
                            <label for="re-password" class="text-gray">Confirm Password:</label><br>
                            <input type="password" name="re-password" id="re-password" onkeyup="check();" class="form-control" required>
                        </div>
                        @if ($errors->any())
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        <h5 id="message"></h5>
                        <div class="form-group m-4">
                            
                            <button disabled id="btn" type="submit" class="btn btn-info btn-md">Submit</button>
                        </div>   
                            
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
<script>

var check = function() {
  if (document.getElementById('password').value == document.getElementById('re-password').value) {
    document.getElementById('message').style.color = 'green';
    document.getElementById('message').innerHTML = 'matching';
   
    
    if(document.getElementById('password').value.length >= 8){
        document.getElementById('message').style.color = 'green';
        document.getElementById('message').innerHTML = 'strong';
        document.getElementById('btn').disabled = false;
    }else{
        document.getElementById('message').style.color = 'red';
        document.getElementById('message').innerHTML = 'too small';
    }
  } else {
    document.getElementById('message').style.color = 'red';
    document.getElementById('message').innerHTML = 'not matching';
  }
}
</script>
@endsection  