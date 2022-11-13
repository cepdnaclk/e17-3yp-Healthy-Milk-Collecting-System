import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/email_verification.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/screens/signUpScreen.dart';
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
     return new SplashScreen(
      seconds: 4,
     navigateAfterSeconds: new SignInScreen(),
     /* title: new Text('Healty Milk Collector',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color : Colors.blue
      ),), */
      image: new Image.asset("images/logo.png",alignment: Alignment.center,),
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
