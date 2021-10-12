


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'colors.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  int selectedMonth = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      backgroundColor: grey.withOpacity(0.05),
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
           padding: const EdgeInsets.only(top: 60,left: 20,right: 20,bottom: 25),
           child: Column(
             children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text("Stat",
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
           height: 250,
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
               padding: const EdgeInsets.only(top: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text("Total price",
                     style: TextStyle(
                         color: black.withOpacity(0.5),
                         fontWeight: FontWeight.w500,
                         fontSize: 13
                     ),),
                   SizedBox(height: 10,),
                   Text("\$29.00",
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
           children: List.generate(6, (index){

           return  Container(
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
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                         Icons.arrow_back_ios_outlined,
                         color: white,
                       ),
                     ),
                   ),


                       Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Text("Fat",
                             style: TextStyle(
                                 color: black.withOpacity(0.5),
                                 fontWeight: FontWeight.w500,
                                 fontSize: 13
                             ),),
                           SizedBox(height: 10,),
                           Text("\2459.00",
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
             );


           }),
         )
       )

     ],
   ),
 );

  }
  
}
