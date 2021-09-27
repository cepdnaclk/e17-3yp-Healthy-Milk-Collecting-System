import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milk_collecting_app/screens/colors.dart';
import 'package:milk_collecting_app/screens/signInScreen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';


class DetailsScreen extends StatefulWidget {

 late String email;
  late String password;
  late String type;

  // constructor
  DetailsScreen(String email, String password, String type) {
    this.email = email;
    this.password = password;
    this.type = type;
  }


  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _businessTypeController = TextEditingController();
   TextEditingController _fnameController = TextEditingController();
    TextEditingController _lnameController = TextEditingController();

bool isLoading = false;


 Widget _buildFirstNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _fnameController,
            style: TextStyle(
              color: Colors.white,
            
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your first name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


   Widget _buildlastNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _lnameController,
            style: TextStyle(
              color: Colors.white,
            
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your last name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Contact',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _contactController,
            style: TextStyle(
              color: Colors.white,
            
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your Contact Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Address',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
          
            controller: _addressController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_history,
                color: Colors.white,
              ),
              hintText: 'Enter your Address',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Business Type',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _businessTypeController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.business,
                color: Colors.white,
              ),
              hintText: 'Enter your business type',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
         // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
         signup();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP',
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

  Widget _buildSkipBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()
        ));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Fill later? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Skip This',
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



  final List<String> user_types = ["Farmer","Collector"];
  String selectedUser = "Collector";

String _chosenValue = "";

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ALMOST DONE!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                    _buildFirstNameTF(),
                    SizedBox(height:30),
                    _buildlastNameTF(),
                     SizedBox(
                        height: 30.0,
                      ),
                      _buildContactTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildAddressTF(),
                      SizedBox(height: 30,),
                     // _buildBusinessTF(),

                     Center(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),

            items: <String>[
              'Android',
              'IOS',
              'Flutter',
              'Node',
              'Java',
              'Python',
              'PHP',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Please choose a langauage",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: null,
          ),
        ),
      ),


                      _buildSubmitBtn(),
                     
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(color: Colors.white,),
                      )),
                  ),
                )
                ) : SizedBox.shrink(),




            ],
          ),
        ),
      ),
    );
  }

  void signup() async{

if(_fnameController.text.isEmpty){
showSnack("Please enter the first name");
}else if(_lnameController.text.isEmpty){
showSnack("Please enter the last name");
}else if(_contactController.text.isEmpty){
showSnack("Please enter the contact");
}else if(_addressController.text.isEmpty){
showSnack("Please enter the address");
}else if(_businessTypeController.text.isEmpty){
showSnack("Please enter the business type");
}else{
  
  setState(() {
    isLoading = true;
  });




   var client = http.Client();

try {
  var uriResponse = await client.post(Uri.parse('http://192.168.1.101:80/api/register'),
      body: { 
        "name" : _fnameController.text + " "+ _lnameController.text,
        "email" : widget.email,
        "password" : widget.password,
        "firstname" : _fnameController.text,
          "lastname" : _lnameController.text,
            "contact" : _contactController.text,
              "address" : _addressController.text,
                "type" : widget.type,
                  "businesstype" : _businessTypeController.text,
        });

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);



  if(body_["success"]){
    setState(() {
      isLoading = false;
    });

     showSnack('Register Success');
    
  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", true);
    sharedPreferences.setString("name", body_["user"]["name"]);
    sharedPreferences.setString("email", body_["user"]["email"]);
    sharedPreferences.setString("firstname", body_["user"]["firstname"]);
    sharedPreferences.setString("lastname", body_["user"]["lastname"]);
      sharedPreferences.setString("contact", body_["user"]["contact"]);
    sharedPreferences.setString("address", body_["user"]["address"]);
      sharedPreferences.setString("type", body_["user"]["type"]);
    sharedPreferences.setString("businesstype", body_["user"]["businesstype"]);
   sharedPreferences.setInt("id", body_["user"]["id"]);
    sharedPreferences.setString("token", body_["token"]);

    var tokn  =sharedPreferences.getString("type");
    print(tokn);
    Timer(Duration(seconds: 2), () {

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

});
    


  }else{
    setState(() {
      isLoading = false;
    }); 

  showSnack('Register Failed');
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
