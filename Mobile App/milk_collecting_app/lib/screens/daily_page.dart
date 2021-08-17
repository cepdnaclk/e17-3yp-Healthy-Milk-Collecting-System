
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/json/daily_json.dart';
import 'package:milk_collecting_app/json/day_month.dart';

import 'colors.dart';

class DailyPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {

  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Column(
          children: [
         Container(
           height: 150,
           width: MediaQuery.of(context).size.width,
           color: Colors.white,
           child: SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: List.generate(days.length, (index){

                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         selectedDay = index;
                       });
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Column(
                         children: [
                           Text(days[index]['label'],
                             style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w400
                             ),),
                           SizedBox(height: 10,),
                           Container(
                             width: 30,
                             height: 30,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: selectedDay == index ? primary: Colors.white,
                               border: Border.all(color: selectedDay == index ? primary: grey.withOpacity(0.5),)
                             ),
                             child: Center(
                               child: Text(days[index]['day'],
                                 style: TextStyle(
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                     color: selectedDay == index ? white: Colors.black
                                 ),),
                             ),
                           )


                         ],
                       ),
                     ),
                   );


                 }),
               ),
             ),
           ),
         ),
            Column(
           children: List.generate((daily.length)+1, (index){

            if(index != daily.length){
              return Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: grey.withOpacity(0.5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Icon(Icons.person),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(daily[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              SizedBox(height: 5,),
                              Text(daily[index]['date'])
                            ],
                          ),
                        ],),
                        Text(daily[index]['price'],
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      color: grey.withOpacity(0.5),
                    )

                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),

                          ],
                        ),
                      ],),
                      Text("\$1270.00",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),


                ],
              ),
            );

           }),
            ),
             SizedBox(height: 20,)

          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Daily Transactions",style: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),),

      ),
    );
  }
}
