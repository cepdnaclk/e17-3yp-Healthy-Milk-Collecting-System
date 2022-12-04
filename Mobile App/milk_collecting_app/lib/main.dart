import 'package:flutter/material.dart';
import 'package:milkapp/screens/current_collection.dart';
import 'package:milkapp/screens/root_screen.dart';
import 'screens/signInScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
 
  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
  ));

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
     return  SplashScreen(
     seconds: 1,
     navigateAfterSeconds: SignInScreen(),
     /* title: new Text('Healty Milk Collector',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color : Colors.blue
      ),), */
      image: Image.asset("images/logo.png",alignment: Alignment.center,),
      backgroundColor: Colors.blue,
      
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 50,
      onClick: ()=>print("Flutter splash"),
      loaderColor: Colors.white
    );
  }
}



class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}
