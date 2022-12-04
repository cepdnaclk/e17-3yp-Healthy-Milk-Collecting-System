import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:milkapp/utilities/constants.dart';
import 'dart:convert';
import '../api_urls/ApiUrl.dart';
import 'colors.dart';




class ChangePasswordScreen extends StatefulWidget {



  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {


           TextEditingController _oldPasswordController = TextEditingController();
           TextEditingController _newPasswordController = TextEditingController();
           TextEditingController _newPasswordConfirmController = TextEditingController();


     bool _isLoading = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: getBody(),
      backgroundColor: white,
      
    
    );
  }
  getBody(){
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 25),
              child: Column(
                children: [

                  Row(
             
                    children: [
                      GestureDetector(
                        onTap: (){ Navigator.pop(context);},
                        child: Icon(Icons.arrow_back_ios)),
                      SizedBox(width: 20,),
                      Text("Change Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),

                       


                    ],
                  ),




                ],
              ),
            ),
          ),


        
          SizedBox(height: 20,),

         

        


          SizedBox(height: 20,),
         
        
             
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             Text("Old Password",style: TextStyle(color: white,fontFamily: 'OpenSans',),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                controller:_oldPasswordController,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.adjust_sharp,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the Old Password',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
                obscureText: true,
              ),
            ),


              ],
            )
          ),

          SizedBox(height: 20,),




         
        
             
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             Text("New Password",style: TextStyle(color: white,fontFamily: 'OpenSans',),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                controller: _newPasswordConfirmController,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.adjust_sharp,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the New Password',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
                obscureText: true,
              ),
            ),


              ],
            )
          ),



          SizedBox(height: 20,),
         
        
             
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             Text("Confirm New Password",style: TextStyle(color: white,fontFamily: 'OpenSans',),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                controller: _newPasswordConfirmController,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.adjust_sharp,
                    color: Colors.white,
                  ),
                  hintText: 'Confirm New Password',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
                obscureText: true,
              ),
            ),


              ],
            )
          ),
          SizedBox(height: 20,),

         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: GestureDetector(
                 onTap: (){
                   _changePassword();
                 },
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.45,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     gradient: LinearGradient(
                         colors: [
                           primary,
                           Colors.purple,
                         ]
                     ),
                   ),
                   child: Center(
                     child: Text(
                       "Change Password",
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
             ),



           ],
         ),


          SizedBox(height: 20,),


        ],
      ),
    );

  }




getBodyWithProgressBar(){

return Stack(
  children: [

   getBody(),

  _isLoading ? Align(
     alignment: Alignment.center,
     child: Container(
       padding: EdgeInsets.all(20),
       width: 80,
       height: 80,
       decoration: BoxDecoration(
         color: white,
         borderRadius: BorderRadius.circular(10)
       ),
       child: CircularProgressIndicator(backgroundColor: Colors.purple,)),
   ) : SizedBox.shrink()



  ],
);


}










  void _changePassword() async{

  if(false){}
/*
  if(_oldPasswordController.text.isEmpty){
    showSnack("please enter the old password");
  }
  else if(_newPasswordController.text.isEmpty){
     showSnack("please enter the new password");
  }
  else if(_newPasswordConfirmController.text.isEmpty){
     showSnack("please enter valid email");
  }
  else if(_newPasswordConfirmController.text != _newPasswordController){
     showSnack("password does not match");
  }*/else{

setState(() {
      _isLoading = true;
    });



var client = http.Client();

try {
  var uriResponse = await client.post(Uri.parse(ApiUrl.CHANGE_PASSWORD_URL),
      body: {
          'user_id': "1", //give the authenticated user id
         'password': _newPasswordConfirmController.text
       
        });

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_['success']){


setState(() {
    _isLoading = false;
  });

  showSnack("Password changed successfully");

  Navigator.pop(context);



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
