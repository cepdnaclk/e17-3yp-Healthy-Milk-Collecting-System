import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:milkapp/screens/signUpScreen.dart';
import 'package:milkapp/screens/verificationforforgotpassword_screen.dart';
import 'package:milkapp/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_urls/ApiUrl.dart';
import 'root_screen.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isLoading = false;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();



  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            controller:_passwordController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: isLoading ? null : login,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => SignUpScreen()
        ));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginAsGuestBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'GO AS A GUEST',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

Widget _buildForgotPasswordBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => VerifyForForgotPasswordScreen()
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left:180),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Forgot password? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration:const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.pinkAccent
                    ],
                   // stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
             
               Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics:const AlwaysScrollableScrollPhysics(),
                  padding:const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     const SizedBox(height: 30.0),
                      _buildEmailTF(),
                     const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      const SizedBox(height: 10,),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                     // _buildLoginAsGuestBtn()
                    ],
                  ),
                ),
              ),


           (isLoading) ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                      //  color: Colors.white,
                         borderRadius: BorderRadius.circular(8)
                      ),
                      child:const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(color: Colors.white,),
                      )),
                  ),
                )
                ) :const SizedBox.shrink(),




            ],
          ),
        ),
      ),
    );
  }

  void login() async{

    setState(() {
      isLoading = true;
    });
   
   if(_emailController.text.isEmpty){
    setState(() {
      isLoading = false;
    });
     showSnack("Please enter the email");
   }else if(_passwordController.text.isEmpty){
     setState(() {
      isLoading = false;
    });
    showSnack("Please enter the password");
   }else{


   var client = http.Client();

try {
  var uriResponse = await client.post(Uri.parse(ApiUrl.LOGIN_URL),

      body: {'email': _emailController.text, 'password': _passwordController.text});

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){


    setState(() {
      isLoading = false;
    });

     showSnack('Login Success');
     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", true);
    sharedPreferences.setString("name", body_["user"]["name"]);
    sharedPreferences.setString("email", body_["user"]["email"]);
    sharedPreferences.setInt("id", body_["user"]["id"]);
    sharedPreferences.setInt("type", body_["user"]["type"]);
    sharedPreferences.setString("token", body_["token"]);

    var tokn  = sharedPreferences.getString("token");
    print(tokn);
    Timer(Duration(seconds: 2), () {
 Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
});
    


  }else{
    setState(() {
      isLoading = false;
    });

  showSnack('Login Failed');
  }
  

} finally {
  client.close();
}




   }





  }

  void showSnack(String message) {

     final snackBar = SnackBar(
            content:  Text(message),
            backgroundColor: (Colors.black.withOpacity(0.6)),
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }






}
