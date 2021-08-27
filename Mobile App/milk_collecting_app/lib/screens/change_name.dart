import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';

import 'colors.dart';




class ChangeNameScreen extends StatefulWidget {



  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: getBody(),
      backgroundColor: grey.withOpacity(.3),
      
    
    );
  }
  getBody(){
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            decoration: BoxDecoration(
                color: Colors.purpleAccent,
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
                      Text("Change Username",
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
             Text("New Username",style: TextStyle(color: white,fontFamily: 'OpenSans',),),
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
                  hintText: 'Enter the New Username',
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
                     "Change Username",
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



           ],
         ),


          SizedBox(height: 20,),


        ],
      ),
    );

  }
}
