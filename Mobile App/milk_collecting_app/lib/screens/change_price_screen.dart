import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'colors.dart';




class ChangePriceScreen extends StatefulWidget {



  @override
  _ChangePriceScreenState createState() => _ChangePriceScreenState();
}

class _ChangePriceScreenState extends State<ChangePriceScreen> {
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
                color: white,
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
                      Text("Price Per Liter",
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

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              width: double.infinity,
              
              decoration: BoxDecoration(
                  color: grey.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Price per liter",
                                style: TextStyle(
                                    color: black.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 20,),

                   Row(
                     children: [

                      Text("Grade A",style: TextStyle(color: black),),
                      SizedBox(width: 10,),

                      Container(
                    width: 120,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.purple
                      ])
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text("100.00 lkr",style: TextStyle(color: white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.change_circle_rounded,size: 30,color: white,)

                        ],
                      ),
                    )
                    
                  ),
                   

                     ],
                   ),
                    SizedBox(height:20),

                    Row(
                     children: [

                      Text("Grade B",style: TextStyle(color: black),),
                      SizedBox(width: 10,),

                      Container(
                    width: 120,
                    height: 60,
                    alignment: Alignment.center,
                     
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.purple
                      ])
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text("98.00 lkr",style: TextStyle(color: white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.change_circle_rounded,size: 30,color: white,)

                        ],
                      ),
                    )
                    
                  ),
                   

                     ],
                   ),
                        SizedBox(height:20),

                     Row(
                     children: [

                      Text("Grade C",style: TextStyle(color: black),),
                      SizedBox(width: 10,),

                      Container(
                    width: 120,
                    height: 60,
                    alignment: Alignment.center,
                     
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.purple
                      ])
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text("95.00 lkr",style: TextStyle(color: white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.change_circle_rounded,size: 30,color: white,)

                        ],
                      ),
                    )
                    
                  ),
                   

                     ],
                   ),

                    SizedBox(height:20),

                     Row(
                     children: [

                      Text("Grade D",style: TextStyle(color: black),),
                      SizedBox(width: 10,),

                      Container(
                    width: 120,
                    height: 60,
                    alignment: Alignment.center,
                     
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.purple
                      ])
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text("92.00 lkr",style: TextStyle(color: white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.change_circle_rounded,size: 30,color: white,)

                        ],
                      ),
                    )
                    
                  ),
                   

                     ],
                   ),
                 
            
          
                       SizedBox(height: 20,)


                            ],
                          ),





                        ],
                      )
                    ),




                  ],
                ),
              ),
            ),
          ),

        


          SizedBox(height: 20,),
         
        


         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: Container(
                 height: 50,
                 width: MediaQuery.of(context).size.width*0.4,
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
                     "Change",
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
