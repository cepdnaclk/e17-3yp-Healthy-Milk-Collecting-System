import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';







class EmailVerificationSuccessScreen extends StatefulWidget {


  @override
  _EmailVerificationSuccessScreenState createState() => _EmailVerificationSuccessScreenState();
}

class _EmailVerificationSuccessScreenState extends State<EmailVerificationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      
    );
  }



  getBody() {

return Container(
  height:double.infinity,
  width: double.infinity,
  color: Colors.white,
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
             SizedBox(height:MediaQuery.of(context).size.height * 0.3),
               Text("Email verification Success",style: TextStyle(fontSize: 30,color:black,fontWeight: FontWeight.bold)),
                    SizedBox(height:20),
             Container(
               width: 100,
               height: 100,
               child: Image(
                 image: AssetImage("images/success.png"))),

                 SizedBox(height: 20,),
                 Padding(
                     padding: const EdgeInsets.symmetric(horizontal:30),
                     child: Text("Email verified successfully",style: TextStyle(fontSize: 20,color:Colors.grey,fontWeight: FontWeight.w400)),
                   ),

                   SizedBox(height:70),
                   _buildContinueBtn()





      ],
    ),
  ),
);

  }





  Widget _buildContinueBtn() {
    return  Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: GestureDetector(
                 onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                 },
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.45,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: Colors.lightBlue
                   ),
                   child: Center(
                     child: Text(
                       "Continue",
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