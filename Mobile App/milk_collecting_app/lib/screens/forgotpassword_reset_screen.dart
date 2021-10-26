import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/signInScreen.dart';
import 'package:milk_collecting_app/screens/signUpScreen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordResetScreen extends StatefulWidget {


  @override
  _ForgotPasswordResetScreenState createState() => _ForgotPasswordResetScreenState();
}

class _ForgotPasswordResetScreenState extends State<ForgotPasswordResetScreen> {

  bool _isLoading = false;
  TextEditingController _newPasswordController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBodyWithProgressBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: black,)),
      ),
    );
  }



getBodyWithProgressBar(){

return Stack(
  children: [

   getBody(),

 (_isLoading) ? Align(
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(color: Colors.white,),
                      )),
                  ),
                )
                ) : SizedBox.shrink(),


  ],
);


}

getBody() {

return Container(
  height:double.infinity,
  width: double.infinity,
  color: Colors.white,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(height:200),
                   Text("Reset Password",style: TextStyle(fontSize: 30,color:black,fontWeight: FontWeight.bold)),
                    SizedBox(height:20),
                 Padding(
                     padding: const EdgeInsets.symmetric(horizontal:30),
                     child: Text("Please enter a strong password",style: TextStyle(fontSize: 20,color:Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400)),
                   ),
                      SizedBox(height:35),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal:30),
                     child:_buildPasswordTF()
                   ),
                 
                  
                   SizedBox(height: 50,),

                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: _buildResetPasswordBtn(),
                   )

             ],
    ),
  ),
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
            keyboardType: TextInputType.emailAddress,
            controller: _newPasswordController,
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
              hintText: 'Enter a strong password',
              hintStyle: kHintTextStyle,
              
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }



  Widget _buildResetPasswordBtn() {
    return  Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: GestureDetector(
                 onTap: (){
                      _resetPassword();
                 },
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.45,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: Colors.lightBlue,
                   ),
                   child: Center(
                     child: Text(
                       "Reset Password",
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontFamily: "OpenSans",
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ),
               ),
             );
  }

  void _resetPassword() async{

if(_newPasswordController.text.isNotEmpty){



setState(() {
      _isLoading = true;
    });



var client = http.Client();

try {
  var uriResponse = await client.post(Uri.parse('http://172.20.10.3:80/api/changePassword'),
      body: {
          'user_id': "4", //give the authenticated user id
         'password': _newPasswordController.text
       
        });

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_['success']){


setState(() {
    _isLoading = false;
  });

  showSnack("Password changed successfully");
   Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));

  }

  }finally{
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