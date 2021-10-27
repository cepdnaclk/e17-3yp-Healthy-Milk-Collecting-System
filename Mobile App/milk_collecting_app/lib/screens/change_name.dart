import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/api_urls/ApiUrl.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'colors.dart';




class ChangeNameScreen extends StatefulWidget {



  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {


TextEditingController _fnameController = TextEditingController();
TextEditingController _lnameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _contactController = TextEditingController();

bool _isLoading = false;

@override
initState() {
  super.initState();
  loadData();
}
  loadData()async{
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
setState(() {
  _fnameController.text = sharedPreferences.getString("firstname").toString();
  _lnameController.text = sharedPreferences.getString("lastname").toString();
  _emailController.text = sharedPreferences.getString("email").toString();
   _contactController.text = sharedPreferences.getString("contact").toString();
   
});


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: getBodyWithProgressBar(),
      backgroundColor: white,
      
    
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


  getBody(){
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            decoration: BoxDecoration(
              color: grey.withOpacity(0.9),
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

                  Container(
                    child: Row(
             
                      children: [
                        GestureDetector(
                          onTap: (){ Navigator.pop(context);},
                          child: Icon(Icons.arrow_back_ios)),
                        SizedBox(width: 20,),
                        Text("Change User Details",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),

                         


                      ],
                    ),
                  ),




                ],
              ),
            ),
          ),


        
          

         

        


          SizedBox(height: 20,),
         
        
             
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             Text("First Name",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                controller: _fnameController,
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
                  hintText: 'Enter the First Name',
                  
                  hintStyle: kHintTextStyle_Home,
                  
                ),
                autofocus: false,
                
                
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
             Text("Last Name",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                controller:_lnameController,
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
                  hintText: 'Enter the Last Name',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
               
              ),
            ),


              ],
            )
          ),
               SizedBox(height:20),
           Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             Text("Change Email",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
                
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
                  hintText: 'Change Email',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
               
                controller: _emailController,
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
             Text("Change Contact Number",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             SizedBox(height: 5,),
              Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle_HomePage,
              height: 60.0,
              child: TextField(
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
                  hintText: 'Enter the New Phone Number',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
                controller: _contactController,
              ),
            ),


              ],
            )
          ),

         
          SizedBox(height: 20,),

         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             GestureDetector(
               onTap: (){
                 _updateData();
               },
               child: Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20),
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
                       "Save",
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

          
          SizedBox(height: 20,),
         
        
             
         


        ],
      ),
    );

  }

  void _updateData() async{

    setState(() {
      _isLoading = true;
    });

  if(_fnameController.text.isEmpty){
    showSnack("please enter first name");
  }
  else if(_lnameController.text.isEmpty){
     showSnack("please enter last name");
  }
  else if(_emailController.text.isEmpty){
     showSnack("please enter valid email");
  }
  else if(_contactController.text.isEmpty){
     showSnack("please enter the contact");
  }
  else{

  var client = http.Client();

try {
  var uriResponse = await client.post(Uri.parse(ApiUrl.UPDATE_NAME_URL),
      body: {
          'user_id': "1", //give the authenticated user id
         'name': _fnameController.text +" "+_lnameController.text,
         'email': _emailController.text,
         'lastname': _lnameController.text,
         'firstname': _fnameController.text,
         'contact': _contactController.text,
        }

        );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_['success']){



SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
setState(() {
  sharedPreferences.setString("name",body_['new_name']);
  sharedPreferences.setString("firstname",body_['firstname']);
  sharedPreferences.setString("lastname",body_['lastname']);
  sharedPreferences.setString("email",body_['email']);
   sharedPreferences.setString("contact",body_['contact']);
   
});

setState(() {
    _isLoading = false;
  });

  showSnack("details updated");

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
