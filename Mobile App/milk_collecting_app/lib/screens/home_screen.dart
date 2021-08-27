import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:milk_collecting_app/screens/current_collection.dart';
import 'package:milk_collecting_app/screens/daily_page.dart';
import 'package:milk_collecting_app/screens/map_page.dart';
import 'package:milk_collecting_app/screens/profile_screen.dart';
import 'package:milk_collecting_app/screens/stats_page.dart';

import 'colors.dart';
import 'google_map_screen.dart';
import 'home_page.dart';




class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isConnecting = false;
  bool isConnected = false;


  int pageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    DailyPage(),
    MapPage(),
    ProfileScreen(),
    
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConnecting?  Stack(
        children: [


          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
             color: Colors.white
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("",style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20
                    ),),
                    SizedBox(height: 10,),
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ),
          )


        ],
      ):

      IndexedStack(
        index: pageIndex,
        children: pages,
      )
      ,
      bottomNavigationBar: _getBottomNavigationBar(),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text(isConnected ? "Connected" : "Not Connected",
                style: TextStyle(
                  color:isConnected ? Colors.green : Colors.red,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold
                ),),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentCollection() ));


                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.purple,width: 3)
                  ),
                    child: Icon(Icons.shopping_cart,color: Colors.purple,)),
              ),
              SizedBox(width: 5,),
              Icon(Icons.notifications,color: Colors.purple,size: 30,)



            ],
          ),

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

            isConnecting = true;

            if(isConnected){
              //disconnect
              isConnected = false;
            }else if(!isConnected){
              //connect
              isConnected = true;
            }

            isConnecting = false;
          });
        },
        child: Icon(Icons.wifi),
        backgroundColor: isConnected ? Colors.blue:Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _getBottomNavigationBar() {



    List<IconData> iconItems = [
      Ionicons.md_calendar,
      Ionicons.md_stats,
      Ionicons.md_wallet,
      Ionicons.ios_person,
    ];
    return AnimatedBottomNavigationBar(
      activeColor:   primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      //other params
    );







  }






}
