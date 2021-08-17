import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';

import 'colors.dart';




class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Details of the sample",
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
              height: 100,
              decoration: BoxDecoration(
                  color: white,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(height: 10,),
                              Text("\100.00lkr",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          ),

                         Row(
                           children: [


                             Text("Grade ",
                               style: TextStyle(
                                   color: black,
                                   fontWeight: FontWeight.w500,
                                   fontSize: 20
                               ),),
                              SizedBox(width: 10,),
                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                       colors: [
                                         primary,
                                         Colors.purple,
                                       ]
                                   ),
                                   shape: BoxShape.circle
                               ),
                               child: Center(
                                   child: Text("A",style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold
                                   ),)
                               ),
                             ),








                           ],
                         )




                        ],
                      )
                    ),




                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  Container(
                    width: ((size.width)/2)-30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: white,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      primary,
                                      Colors.purple,
                                    ]
                                ),
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                Ionicons.md_stats,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Fat rate(%)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,

                                ),),
                              SizedBox(height: 10,),
                              Text("90",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          )



                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ((size.width)/2)-30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: white,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      primary,
                                      Colors.purple,
                                    ]
                                ),
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                Ionicons.md_stats,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("PH",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text("6.6",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          )



                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ((size.width)/2)-30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: white,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      primary,
                                      Colors.purple,
                                    ]
                                ),
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                Ionicons.md_stats,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Density(gcm-3)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text("1.03",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          )



                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ((size.width)/2)-30,
                    height: 200,
                    decoration: BoxDecoration(
                        color: white,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      primary,
                                      Colors.purple,
                                    ]
                                ),
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                Ionicons.md_stats,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Volume(Litres)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text("2.0",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          ),





                        ],
                      ),
                    ),
                  )



    ]),
              ),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
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
                  hintText: 'Enter your volume',
                  hintStyle: kHintTextStyle_Home,
                ),
                autofocus: false,
              ),
            ),
          ),

          SizedBox(height: 20,),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                     "Add",
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
                     "Reject",
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
