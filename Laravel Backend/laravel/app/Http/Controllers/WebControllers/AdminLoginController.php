<?php

namespace App\Http\Controllers\WebControllers;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Http\Controllers\WebControllers\Controller;
use Illuminate\Support\Facades\Validator;
use Auth;
use Route;
class AdminLoginController extends Controller
{
   use AuthenticatesUsers;
   /**
     *  where to redirect users after login
     *
     * @var string
     */
    protected $redirectTo = '/main';

    /**
     *  
     *
     * @return void
     */

    public function __construct()
    {
      //$this->middleware('guest', ['except' => ['logout']]);
      $this->middleware('guest:admins', ['except' => ['logout']]);
      
    }
    
    public function showLoginForm()
    {
      return view('adminLogin');
    }
    
    public function login(Request $request)
    {
      //dd($request->email);
      // Validate the form data
      $this->validate($request, [
        'email'   => 'required|email',
        'password' => 'required|min:6'
      ]);
      
      // Attempt to log the user in
      if (Auth::guard('admins')->attempt(['email' => $request->email, 'password' => $request->password])) {
        // if successful, then redirect to their intended location
        
        return redirect()->intended(route('admin.dashboard'));
      } 
      // if unsuccessful, then redirect back to the login with the form data
      //dd($request);
      return redirect()->back()->withInput($request->only('email', 'remember'));
    }
    
    public function logout()
    {
        Auth::guard('admins')->logout();
        return redirect('/admin/login');
    }
}