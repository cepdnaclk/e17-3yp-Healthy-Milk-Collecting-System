import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/screens/home_page.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';

import 'colors.dart';



class CurrentCollection extends StatefulWidget {
  @override
  _CurrentCollectionState createState() => _CurrentCollectionState();
}

class _CurrentCollectionState extends State<CurrentCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: getAppBar(),

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
                      Text("Overall details",
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
                  border: Border.all(color: Colors.purpleAccent,width: 5),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Total price",
                            style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            ),),
                          SizedBox(height: 10,),
                          Text("1000.00lkr",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                            ),),
                        ],
                      ),
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
                        border: Border.all(color: Colors.purpleAccent,width: 3),
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
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text("91",
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
                        border: Border.all(color: Colors.purpleAccent,width: 3),
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
                        border: Border.all(color: Colors.purpleAccent,width: 3),
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
                              Text("1.01",
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
                        border: Border.all(color: Colors.purpleAccent,width: 3),
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

                              Text("Volume(Litre)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text("10",
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
              height: 50,
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
                  "Upload Data",
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


          SizedBox(height: 20,),


        ],
      ),
    );

  }

  getAppBar() {


    return AppBar(
      leading: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
          child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.settings,color: Colors.purple,size: 35,),
        )
      ],
    );



  }
}
