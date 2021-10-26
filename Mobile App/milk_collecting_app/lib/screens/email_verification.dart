import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/emailverificationsuccess_screen.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';




class EmailVerificationScreen extends StatefulWidget {
  

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

String email = "";
TextEditingController _emailOtpController = TextEditingController();
bool _isLoading=  false;

 @override
initState() {
  super.initState();
  _getEmail();
  _sendOTP();
}

_getEmail() async{

SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
sharedPreferences.setString("email","anuruddhachandrasekara60@gmail.com");
setState(() {
  
  email = sharedPreferences.getString("email").toString();
   
});

}

_sendOTP() async{


var res = await EmailAuth(sessionName: "Registration").sendOtp(recipientMail: email);

if(res){
showSnack("OTP send");

}else{
  showSnack("OTP not send");
}


}


_verifyOTP() async{
setState(() {
  _isLoading = true;
});

var res = await EmailAuth(sessionName: "Registration").
validateOtp(recipientMail: email, userOtp: _emailOtpController.text);


if(res){

  setState(() {
    _isLoading = false;
  });
  Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerificationSuccessScreen()));


}else{
  setState(() {
    _isLoading = false;
  });
  showSnack("Invalid OTP");
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
                   Text("Email verification",style: TextStyle(fontSize: 30,color:black,fontWeight: FontWeight.bold)),
                    SizedBox(height:20),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal:30),
                     child: Text("Please Enter the verification code sent to $email",style: TextStyle(fontSize: 20,color:Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400)),
                   ),
                      SizedBox(height:35),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal:30),
                     child:_buildEmailTF()
                   ),
                   SizedBox(height:40),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal:30),
                     child: Text("Didn't receive an OTP?",style: TextStyle(fontSize: 20,color:Colors.black,fontWeight: FontWeight.bold)),
                   ),
                   SizedBox(height:20),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal:30),
                     child: GestureDetector(
                       onTap: (){
                        _sendOTP();
                       },
                       child: Text("Resend OTP",
                       style: TextStyle(fontSize: 20,color:Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400))),
                   ),

                   SizedBox(height: 50,),

                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: _buildSubmitBtn(),
                   )

             ],
    ),
  ),
);








  }



  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'OTP',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailOtpController,
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
              hintText: 'Enter your verification code',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildSubmitBtn() {
    return  Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: GestureDetector(
                 onTap: (){
                     _verifyOTP();
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
                       "Submit",
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







}