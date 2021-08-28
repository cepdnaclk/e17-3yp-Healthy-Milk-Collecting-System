import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';

import 'colors.dart';




class SubDetailsScreen extends StatefulWidget {



  @override
  _SubDetailsScreenState createState() => _SubDetailsScreenState();
}

class _SubDetailsScreenState extends State<SubDetailsScreen> {
  @override
  Widget build(BuildContext context) {
        int selectedIndexSample = 0;

    return Scaffold(
      body: SingleChildScrollView(
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
                        Text("Sub Records",
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
            child: Row(
              children: [

 Text("Farmer Name : Alex",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             


              ],
            )
          ),

          SizedBox(height: 20,),
         
        
             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [

 Text("Collecter Name : John",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             


              ],
            )
          ),


            SizedBox(height: 20,),
         
        
             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [

 Text("Date : 11/4/2021",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             


              ],
            )
          ),
               SizedBox(height:20),


             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [
        Text("Average Fat Rate : 80%",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             ],
            )
          ),

           SizedBox(height:20),


             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [
        Text("Average Density : 1.1gcm-3",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             ],
            )
          ),

           SizedBox(height:20),


             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [
        Text("Average pH : 6.6",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             ],
            )
          ),

           SizedBox(height:20),


             Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [
        Text("Totla volume : 10Liters",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             ],
            )
          ),
         

         SizedBox(height:20),
          Container(
            height: 400,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
                double height = 50;
                if(index == 0){
                  height = 150;
                }else{
                  height = 50;
                }
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                   height: height,
                   decoration:BoxDecoration(
                     color: Colors.white,
                     borderRadius : BorderRadius.circular(20),
                     border: Border.all(width: 2,color: Colors.pink)
                   ),
                   child: Column(
                     children: [


                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                     Text("Sample ${index+1}",style: TextStyle(color: black,fontWeight: FontWeight.bold),),
                     GestureDetector(
                       onTap: (){
                         setState(() {
                           selectedIndexSample = index;
                           print(selectedIndexSample);
                         
                         });
                       },
                       child: (index == selectedIndexSample) ? Icon(Icons.arrow_drop_up,size: 40,color: Colors.purple,)
                       :Icon(Icons.arrow_drop_down,size: 40,color: Colors.purple,)
                       ),

                   ],),

                      
                   (index == selectedIndexSample) ?  Container(
                       
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                       Text("Fat Rate : 80%",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
                       Text("Density : 1.2gcm-3",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
                      Text("pH : 6.6",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
                      Text("Volume : 1Liter",style: TextStyle(color: black,fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
             






                        ],
                      ),
                     ):SizedBox.shrink()




                     ],
                   )
                  ),
                  
                );
            }),
          ),

         
         
        
             
         


        ],
      ),
    ),
      backgroundColor: white,
      
    
    );
  }
 
}
