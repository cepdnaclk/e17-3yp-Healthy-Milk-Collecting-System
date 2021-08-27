import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milk_collecting_app/screens/change_contact.dart';
import 'package:milk_collecting_app/screens/change_name.dart';
import 'package:milk_collecting_app/screens/change_password_screen.dart';
import 'package:milk_collecting_app/screens/change_price_screen.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/signInScreen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';

import 'details.dart';
import 'home_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


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
              'Anuruddha chandrasekara',
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
                child: Icon(Icons.edit,color: white,size: 35,)),
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
              'abc@gmail.com',
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNameScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 40,))

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
              '0715446734',
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeContactScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 40,))

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
              'Change Password',
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 40,))

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



  
   Widget _buildPriceTF() {
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
              'Change Price Per Liter',
              style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'OpenSans',
                 fontSize: 20
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePriceScreen()));
              },
              child: Icon(Icons.edit,color: white,size: 40,)
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


    Widget _buildLogOutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 200,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
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
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25.0),

                      Icon(Icons.account_circle,size: 70,color: Colors.white,),
 
                       SizedBox(
                        height: 25.0,
                      ),
                      _buildNameTF(),
                      _buildEmailTF(),
                      _buildContactTF(),
                      _buildPasswordTF(),
                      _buildPriceTF(),
                      SizedBox(height: 20,),
                      _buildLogOutBtn(),
                      SizedBox(
                        height: 30.0,
                      ),
                     
                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
