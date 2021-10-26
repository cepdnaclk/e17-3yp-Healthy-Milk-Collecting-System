import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milk_collecting_app/screens/change_contact.dart';
import 'package:milk_collecting_app/screens/change_name.dart';
import 'package:milk_collecting_app/screens/change_password_screen.dart';
import 'package:milk_collecting_app/screens/change_price_screen.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/signInScreen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'details.dart';
import 'home_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   String name = "Loading....";
   String email = "Loading....";
   String contact = "Loading....";
   bool isFarmer = false;
 

   

   @override
initState() {
  super.initState();
  loadData();
}
  loadData()async{
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
setState(() {
  name = sharedPreferences.getString("name").toString();
  email = sharedPreferences.getString("email").toString();
   contact = sharedPreferences.getString("contact").toString();
   if(sharedPreferences.getString("type") == "Farmer"){
     isFarmer = true;
   }
});


  }


  Widget _buildNameTF() {
    return Container(
      decoration: BoxDecoration(
       color:Colors.black.withOpacity(0.2), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
       Text(
            name,
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNameScreen()));
                },
                child: Icon(Icons.edit,color: white,size: 25,)),
            )

              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
          )
         
        ],
      ),
    );
  }

Widget _buildEmailTF() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
       Text(
              email,
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            Padding(padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNameScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 25,))
              ,)

              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
          )
         
        ],
      ),
    );
  }



  Widget _buildContactTF() {
    return Container(
      decoration: BoxDecoration(color: black.withOpacity(0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
       Text(
              contact,
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            Padding(padding: EdgeInsets.only(right:10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNameScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 25,)),
              )

              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey
            ),
          )
         
        ],
      ),
    );
  }


   Widget _buildPasswordTF() {
    return GestureDetector(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));

      },
      child: Container(
        decoration: BoxDecoration(color: black.withOpacity(0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
         Text(
                'Change Password',
                style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontFamily: 'OpenSans',
                   fontSize: 20
                ),
              ),
             
    
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey
              ),
            )
           
          ],
        ),
      ),
    );
  }



  
   Widget _buildPriceTF() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePriceScreen()));
      },
      child: Container(
        decoration: BoxDecoration(color: black.withOpacity(0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
         Text(
                'Change Price Per Liter',
                style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontFamily: 'OpenSans',
                   fontSize: 20
                ),
              ),
             /* Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    
                  },
                  child: Icon(Icons.edit,color: white,size: 25,)
                  ),
              ) */
    
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey
              ),
            )
           
          ],
        ),
      ),
    );
  }


    Widget _buildLogOutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: 200,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){    
          
         setState(() {
           isLogOutPress = true;
         });



        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGOUT',
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




  final List<String> user_types = ["Farmer","Collector"];
  String selectedUser = "Collector";

  bool isLogOutPress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.pinkAccent
                    ],
                    //stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),

                     // Icon(Icons.account_circle,size: 70,color: Colors.white,),
                     Container(
                            width: 65,
                            height:80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("images/pro_img.jpg"))
                            ),
                          ),
                            
                       SizedBox(
                        height: 25.0,
                      ),
                      _buildNameTF(),
                      _buildEmailTF(),
                      _buildContactTF(),
                      _buildPasswordTF(),
                      !isFarmer ?
                      _buildPriceTF():SizedBox.shrink(),
                      SizedBox(height: 50,),
                      _buildLogOutBtn(),
                      SizedBox(
                        height: 30.0,
                      ),
                     
                     
                    ],
                  ),
                ),
              ),
              (isLogOutPress) ? Container(
                height: 100,
                width: 250,
                decoration : BoxDecoration(
                  color: white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                       Text("Confirm logout",style: TextStyle(
                         color : Colors.blue,fontSize: 18
                       ),),
                       Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 isLogOutPress = false;
                               });
                             },
                             child: Text("Cancel",style: TextStyle(
                                                    color : Colors.blue,fontWeight: FontWeight.bold
                                                  ),),
                           ),

                          GestureDetector(
                            onTap: (){
                              print("object");
                              logout();
                            },
                            child: Text("Confirm",style: TextStyle(
                                                   color : Colors.blue,
                                                   fontWeight: FontWeight.bold
                                                 ),),
                          ),
                        ],
                      )

                    ],
                  ),
                ),

              ) : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  void logout() async{

SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");

   Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", 
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

var client = http.Client();
    
try {
  var uriResponse = await client.get(Uri.parse('http://192.168.1.101:80/api/logout'),
      headers: headers);

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);
 
if(body_["success"]){


sharedPreferences.setBool("isLoggedIn",false);



showSnack(body_["message"]);
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);

}else{

showSnack("Logout faild!");
}
  
  

} finally {
  client.close();
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
