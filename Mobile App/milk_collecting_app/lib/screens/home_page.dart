import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:milkapp/screens/change_price_screen.dart';
import 'package:milkapp/screens/current_collection.dart';
import 'package:milkapp/screens/popup.dart';
import 'package:milkapp/screens/root_screen.dart';
import 'package:milkapp/test/led.dart';
import 'package:popup_window/popup_window.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controllers/record_controller.dart';
import '../test/connection.dart';
import '../utilities/constants.dart';
import 'colors.dart';




class HomePage extends StatefulWidget {


bool hc05Connected;
bool isStart;
List<double> parameterList;

bool getShowStatus(){
  return this.isStart;
}


HomePage({required this.hc05Connected,required this.isStart,required this.parameterList});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 
  int selectedFarmerIndex = -1;
  String selectedFarmer = "";
  String defaultFarmer = "";
  String defaultFarmerName = "";

   bool isdefaultFarmerSelected = false;
   bool isConnectedFarmerSelected = false;


  bool isFarmer = false; //////////////////////set to true for testing

  bool isDefaultCow = false; 
  bool isDefaultBuffalo = false;

  bool isConnected = false;

  bool isDeviceConnected = false;
  bool isGoBtnActive = false;

  bool _isHc05Connected = false;
  

  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  late BluetoothDevice _device;
  bool _connected = false;
  bool _pressed = false;

  bool _deviceFound = false;

  bool _isDataLoading = false;

   TextEditingController _defaultFarmerController = TextEditingController();

  final controller = Get.put(RecordController());

  TextEditingController _priceController = TextEditingController();

  TextEditingController _volumeController = TextEditingController();

  String currentPrice = "";

  @override
initState() {
  super.initState();
  loadData();
 // _getDataViaBlue();
}

  double _pH = 0.0;
	double _fatrate = 0.0;
	double _density = 0.0;
  String _grade = "";
  double _temperature = 0.0;
  double _volume = 0.0;

_getDataViaBlue(){

  //sleep(Duration(seconds: 20));
    
  double pH = widget.parameterList[0];
	double fatrate = widget.parameterList[4];//not get yet
	double density = (widget.parameterList[3])/(widget.parameterList[2]);
  String grade = calcGrade(pH,fatrate,density);
  double temperature = widget.parameterList[1];
  double volume = widget.parameterList[2];




  setState(() {
   _pH = pH;
   _fatrate = fatrate;
   _density = density;
   _grade = grade;
   _temperature = temperature;
   _volume = volume;

  });




}


String calcGrade(pH,fatrate,density){
       

  double pH1low=6.6;
	double pH2low=6.5;
	double pH3low=6.4;
	double pH1high=6.8;
	double pH2high=6.9;
	double pH3high=7;

	double f1low=60;
	double f2low=55;
	double f3low=45;
	double f1high=70;
	double f2high=75;
	double f3high=85;

	double d1low=1.026;
	double d2low=1.020;
	double d3low=1.010;
	double d1high=1.032;
	double d2high=1.034;
	double d3high=1.04;

      int mark = 9;
      String grade;


		if(pH < pH1low || pH > pH1high){
			--mark;
		}
		if(fatrate < f1low || fatrate > f1high){
			--mark;
		}
		if(density < d1low || density > d1high){
			--mark;
		}
		if(pH < pH2low || pH > pH2high){
			--mark;
		}
		if(fatrate < f2low || fatrate > f2high){
			--mark;
		}
		if(density < d2low || density > d2high){
			--mark;
		}
		if(pH < pH3low || pH > pH3high){
			--mark;
		}
		if(fatrate < f3low || fatrate > f3high){
			--mark;
		}
		if(density < d3low || density > d3high){
			--mark;
		}
		if(mark>=7){
			grade = "A";
		}else if(mark>=5){
			grade = 'B';
		}else if(mark>=3){
			grade = 'C';
		}else{
			grade = 'D';
		}
		return grade;

	}





void loadData() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
 
    
    print(sharedPreferences.getString("type"));
  if(sharedPreferences.getString("type") == "Farmer"){

    setState(() {  
      isFarmer = true;
    });
    
  }

}



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: widget.hc05Connected ?
      
       FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            // return MyHomePage(title: 'Flutter Demo Home Page');
            return connectDeviceScreen();
          } else {
            return connectDeviceScreen();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ): getBody(),
      backgroundColor: grey.withOpacity(.3),
     
      
    
    );
  }

  List<String> farmers_list = [
   
    "C M Chandrasekara",
    "Piyal",
    "Poorna",
    "Aminda"
    "Ishara"
  ];




  Widget _buildAddDefaultFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 30),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
           

          // _defaultFarmerController.clear();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Colors.white,
        child: Text(
        "Add" ,
          style: TextStyle(
            color: Colors.purple,//Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  
 double windowHeight = 200;


  Widget _buildConnectWithFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 30),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
         setState(() {

           //make the device connection
             //_isHc05Connected = true;
             widget.hc05Connected = true;
       /*    isStart = false;
           _isDataLoading = true;

          _getDataViaBlue();
           
              Timer(Duration(seconds: 5), () {
                    
                     setState(() {
                       _isDataLoading = false;
                     });
                   });  */

         

         });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Colors.blue,
        child: Text(
         (!isdefaultFarmerSelected) ? "Connect with " + selectedFarmer : "Connect with " +defaultFarmerName,
          style: TextStyle(
            color: Colors.white,//Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

final _formKey = GlobalKey<FormState>();
    //pop up screen
Widget _buildConnectWithDefaultFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Container(
        decoration:BoxDecoration(
           color: Colors.white,
        ),
         padding: const EdgeInsets.symmetric(horizontal: 30,vertical:10),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:10),


            child: Column(
              children: [

              Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Farmer',
          style: TextStyle(
                color: Colors.purple,//Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
         decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _defaultFarmerController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_add_alt_sharp,
                color: Colors.white,
              ),
              hintText: 'Enter a farmer name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    ),

      SizedBox(height: 10,),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

             Text(
              "Select type",
              style: TextStyle(
                color: Colors.purple,//Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),


        

            GestureDetector(
              onTap: (){
                    setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Cow";
                       isDefaultCow = true;
                       isDefaultBuffalo = false;
                    });


                controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });





              },
              child: Container(
                width: 50,
                height: 35,
                decoration: BoxDecoration(
                  color: (isdefaultFarmerSelected) && (isDefaultCow) ? Colors.lightBlue : Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Cow",style: TextStyle(fontWeight: FontWeight.w500,color: white),)
                )
              ),
            ),
              SizedBox(width: 6,),
            GestureDetector(
              onTap: (){
                   setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Buffalo";
                       isDefaultBuffalo = true;
                       isDefaultCow = false;
                    });




                  controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });


              },
              child: Container(
                width: 60,
                height: 35,
                decoration: BoxDecoration(
                  color: (isdefaultFarmerSelected) && (isDefaultBuffalo) ? Colors.lightBlue : Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Buffalo",style: TextStyle(fontWeight: FontWeight.w500,color: white),)
                )
              ),
            )




              ]
            ),
             SizedBox(height:10),
             // _buildAddDefaultFarmerBtn()

              ],
            )





          ),
      )
      
    );
  }


  getBody(){
  var size = MediaQuery.of(context).size;
    


if(!isFarmer){

if(!isDeviceConnected){ /////changet to not
    if(widget.isStart){

      return SingleChildScrollView(
        child: Column(
        children : [
               SizedBox(height:10),
         Padding(
           padding: const EdgeInsets.all(0.0),
           child: Container(
             height:MediaQuery.of(context).size.height * 0.45,
             decoration: BoxDecoration(
               color: white,
               borderRadius: BorderRadius.circular(10)
             ),
             child:ListView.builder(

               itemCount: farmers_list.length,
               itemBuilder: (context,index){

               return GestureDetector(
                    onTap: (){
                      setState(() {
                        

                         selectedFarmerIndex = index;
                         selectedFarmer = farmers_list[index];
                         isdefaultFarmerSelected = false;
                         isConnectedFarmerSelected = true;

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          
                          color: (selectedFarmerIndex == index) && (isConnectedFarmerSelected) ?Colors.purple:white,
                          borderRadius: BorderRadius.circular(20),
                          
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                  
                       
                  
                  
                           Padding(
                             padding: const EdgeInsets.only(top: 5),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                  
                                      Icon(Icons.person_pin),
                                  SizedBox(width: 4,),
                                Text(farmers_list[index],style: TextStyle(
                                  color: black,
                                  fontSize: 20
                                  ),),
                  
                              ],
                          ),
                           ),
                  
                            // Divider(color: grey,)
                  
                            ],
                          )
                      ),
                    ),
                  );  




             })
           ),
         ),

         

      
       
      //  _buildConnectWithDefaultFarmerBtn(),
           /////////////////////////////////////pop up////////////////////////////////
          RaisedButton(
            color: Colors.blue,
          
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                   /*
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Cow";
                       isDefaultCow = true;
                       isDefaultBuffalo = false;
                    });


                controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });
                                    },
                                    child: Padding(
                                                                  padding: EdgeInsets.all(8.0),
                                                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration:BoxDecoration(
                                      color: (isdefaultFarmerSelected) && (isDefaultCow) ? Colors.lightBlue : Colors.grey,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(
                                      child:Text("Cow")
                                    ),
                                                                  ),
                                                                  
                                                                ),
                                  ),

                              GestureDetector(
                                onTap:(){


                                  setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Buffalo";
                       isDefaultBuffalo = true;
                       isDefaultCow = false;
                    });




                  controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });

                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration:BoxDecoration(
                                      color: (isdefaultFarmerSelected) && (isDefaultBuffalo) ? Colors.lightBlue : Colors.grey,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(
                                      child:Text("Buffalo")
                                    ),
                                  ),
                                ),
                              ) */

                              

                       Column(
                        children: [
                         Radio(  
                     value: isDefaultCow,  
                     groupValue: true,  
                     onChanged: (value) {  
                     setState(() { 

                       setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Cow";
                       isDefaultCow = true;
                       isDefaultBuffalo = false;
                    });


               // controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });


                            });  
                             },  
                       ),
                       Text("Cow")
                        ],
                       ),

                       Column(
                        children: [
                         Radio(  
                     value: isDefaultBuffalo,  
                     groupValue: true,  
                     toggleable: true,
                     onChanged: (value) {  
                     setState(() {  

                       setState(() {
                       isConnectedFarmerSelected = false;
                       isdefaultFarmerSelected = true;
                       defaultFarmer = "Buffalo";
                       isDefaultBuffalo = true;
                       isDefaultCow = false;
                    });




                //  controller.defaultFarmer = _defaultFarmerController.text;
           setState(() {
             defaultFarmerName = controller.defaultFarmer;
           });


                            });  
                             },  
                       ),
                       Text("Buffalo")
                        ],
                       ),
                       
                                ],
                              ),
                               

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Submit"),
                                  onPressed: () {
                                   
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text("Add another farmer"),
        ),


          _buildConnectWithFarmerBtn(),



        ]
      ),);

    }
          
    /*  if(controller.c < 12){

   return ;
      }  */
 /////////////////////////////////////////////////////////////details/////////////////////////////////////////////////////////
    return Stack(
      children: [


              SingleChildScrollView(

      child: Column(
        children: [

          Container(
            decoration: BoxDecoration(
                color: Colors.white,
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              
                              widget.isStart = true;

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
                               // hc05Connected: false, isStart: true)));

                             /*  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                               return HomeScreen();
                               }));  */

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentCollection()));;

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child:Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: const Text("Collection",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),),
                            ),
                            
                          ),
                        )

                       


                    ],
                  ),




                ],
              ),
            ),
          ),


        
         const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              width: double.infinity,
              height: 120,
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

                   Row(
                     children: [

                      Container(
                    width: 100,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                            Text("${_getPrice()} lkr",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

                        /*  IconButton(onPressed: (){
                            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _priceController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              
                            
                               

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Add"),
                                  onPressed: () {
                                    
                                    setState(() {
                                      currentPrice = _priceController.text;
                                    });

                                    Navigator.pop(context);
                                   

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
         
                          }, icon: Icon(Icons.edit))  */

                        ],
                      ),
                    )
                    
                  ),
                   

                     ],
                   )
                 
            
          



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
                                  /* gradient: LinearGradient(
                                       colors: [
                                         primary,
                                         Colors.purple,
                                       ]
                                   ), */
                                   color:Colors.lightBlueAccent,
                                   shape: BoxShape.circle
                               ),
                               child: Center(
                                   child: Text( (_isDataLoading) ? "..":
                                   calcGrade(widget.parameterList[0],
                                    90,
                                     (widget.parameterList[2] / widget.parameterList[3])),style: TextStyle(
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
                    width: ((size.width)/2)-40,
                    height: 180,
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
                              Text((_isDataLoading) ? "Loading..." : widget.parameterList[4].toString(),
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          ),
                           SizedBox(height: 10,),

                         //_IndicationBar(50,100)

                        



                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ((size.width)/2)-40,
                    height: 180,
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

                             const Text("PH",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                             const SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : widget.parameterList[0].toString(),
                                style:const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          // _IndicationBar(5,6.6)



                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ((size.width)/2)-40,
                    height: 180,
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
                              Text((_isDataLoading) ? "Loading..." : ( widget.parameterList[2]  / widget.parameterList[3] ).toStringAsFixed(2),
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
                    width: ((size.width)/2)-40,
                    height: 180,
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

                              Text("Volume(CC)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : widget.parameterList[3].toString(),
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),),
                            ],
                          ),
                           SizedBox(height: 10,),
                          // _IndicationBar(5,6.6)





                        ],
                      ),
                    ),
                  ),




                    Container(
                    width: ((size.width)/2)-40,
                    height: 180,
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

                              Text("Temperature(Celcious)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : widget.parameterList[1].toString(),
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
                controller: _volumeController,
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
            SizedBox(height:10),

           ////arcs
           Text("Fat Rate",style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize:20,)),
           Container(
             height: 200,
             width: 200,
             child: SfRadialGauge(
               
              axes: <RadialAxis>[
                        RadialAxis(
                         minimum: 0,
                         maximum: 100,
                         showLabels: false,
                         showTicks: false,
                  
                          axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          ///color: Color.fromARGB(30, 0, 169, 181),
                          color: Colors.grey.withOpacity(0.9),
                          thicknessUnit: GaugeSizeUnit.factor,
                       ),
                       pointers: <GaugePointer>[
                   RangePointer(value: 90,
                   color: Colors.lightBlue ), 
                                      
],
annotations: [
   GaugeAnnotation(
 positionFactor: 0.1,
 angle: widget.parameterList[4],
 widget: Text(
 "${widget.parameterList[4].toString()}%",
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: white)
 ))
]
                      )
                 ],
                 


             )
             
             ),




             Text("pH",style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize:20,)),
           Container(
             height: 200,
             width: 200,
             child: SfRadialGauge(
               
              axes: <RadialAxis>[
                        RadialAxis(
                         minimum: 6.2,
                         maximum: 7.2,
                         showLabels: false,
                         showTicks: false,
                  
                          axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          ///color: Color.fromARGB(30, 0, 169, 181),
                          color: Colors.grey.withOpacity(0.9),
                          thicknessUnit: GaugeSizeUnit.factor,
                       ),
                       pointers: <GaugePointer>[
                   RangePointer(value: widget.parameterList[0],
                   color: Colors.cyan ), 
                                      
],
annotations: [
   GaugeAnnotation(
 positionFactor: 0.1,
 angle: 90,
 widget: Text(
 widget.parameterList[0].toString(),
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)
 ))
]
                      )
                 ],
                 


             )
             
             ),
      
      

      
             Text("Density",style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize:20,)),
           Container(
             height: 200,
             width: 200,
             child: SfRadialGauge(
               
              axes: <RadialAxis>[
                        RadialAxis(
                         minimum: 1.026,
                         maximum: 1.032,
                         showLabels: false,
                         showTicks: false,
                  
                          axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          ///color: Color.fromARGB(30, 0, 169, 181),
                          color: Colors.grey.withOpacity(0.9),
                          thicknessUnit: GaugeSizeUnit.factor,
                       ),
                       pointers: <GaugePointer>[
                   RangePointer(value: ( widget.parameterList[2] / widget.parameterList[3] ),
                   color: Colors.blue ), 
                                      
],
annotations: [
   GaugeAnnotation(
 positionFactor: 0.1,
 angle: 90,
 widget: Text(
 ( widget.parameterList[2] / widget.parameterList[3] ).toStringAsFixed(2),
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)
 ))
]
                      )
                 ],
                 


             )
             
             ),
      
           

          SizedBox(height: 20,),

         Row(
          
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [

             GestureDetector(
               onTap: (){
                 _addSub(); ////////////////////////adding  //////////////////////
               },
               child: Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20),
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.2,
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
             ),

             GestureDetector(
               onTap: (){
                Navigator.pop(context);
               },
               child: Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10),
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.2,
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
                     child: Icon(Icons.add),
                   ),
                 ),
               ),
             ),


             GestureDetector(
              onTap: (){
                 ////////////////////////////reject sub colletion/////////////////////////
                 ///
                 _rejectSample();
              },
               child: Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20),
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width*0.3,
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
             ),

           ],
         ),


          SizedBox(height: 20,),


        ],
      ),
    ),

               _isDataLoading ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                      //  color: Colors.white,
                         borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(color: Colors.white,),
                      )),
                  ),
                )
                ): SizedBox.shrink()


      ],
    );





}else{

//_buildBluetoothInterface();

return Container(
  color: white,
  height:double.infinity,
  child : SingleChildScrollView(
    child: Column(
      children : [

       /*  Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "PAIRED DEVICES",
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),*/

                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Defining a Row containing THREE main Widgets:
                  // 1. Text
                  // 2. DropdownButton
                  // 3. RaisedButton
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     /* Text(
                        'Device:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                       
                    /*  DropdownButton(
                        // To be implemented : _getDeviceItems()
                        items: _getDeviceItems(),
                        onChanged: (value){
                          setState(() {
                            _device = value as BluetoothDevice;
                          });
                        },
                       // value: _device,
                      ),*/
                   
                    ],
                  ),
                ),

                /* Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // Defining a Row containing THREE main Widgets:
                      // 1. Text (wrapped with "Expanded")
                      // 2. FlatButton
                      // 3. FlatButton
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "DEVICE 1",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed:
                                // To be implemented : _sendOnMessageToBluetooth()
                                _connected ? _sendOnMessageToBluetooth : null,
                            child: Text("ON"),
                          ),
                          FlatButton(
                            onPressed:
                                // To be implemented : _sendOffMessageToBluetooth()
                                _connected ? _sendOffMessageToBluetooth : null,
                            child: Text("OFF"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/

                   Text("Paired devices",style:TextStyle(color: Colors.blue,fontSize: 25,fontFamily: "OpenSans")),
               // _getDevices(),

               Container(
                 height:200,
                 child:Column(
                   children:[

                          Container(
                       height: 40,
                       width:double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.grey,
                         ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("BT Speaker",style:TextStyle(color: white)),
                     ),
                       ),
                          ),

                          
                          Container(
                       height: 40,
                       width:double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.lightBlueAccent,
                         ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("HC-06",style:TextStyle(color: white)),
                     ),
                       ),
                          ),

                          
                          Container(
                       height: 40,
                       width:double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.grey,
                         ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("BT Speaker",style:TextStyle(color: white)),
                     ),
                       ),
                          ),

                          
                          Container(
                       height: 40,
                       width:double.infinity,
                       decoration: BoxDecoration(
                         color: Colors.grey,
                         ),
                       child: Center(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("Iphone 6s",style:TextStyle(color: white)),
                     ),
                       ),
                          ),


                   ]
                 )
               ),
                 

                SizedBox(height:50),

                GestureDetector(
                  onTap: (){

                       if(!_connected){
                         null;
                       }
                       else{
                         setState(() {
                           
                           isDeviceConnected = true;


                         });
                       }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.5,
                      height: 50,
                      decoration:BoxDecoration(
                        color:!_connected ? Colors.lightBlueAccent : Colors.purple,
                        borderRadius:BorderRadius.circular(25)
                      ),
                      child:Center(child: Text("Go",style: TextStyle(color: Colors.white,fontSize: 25),))
                    ),
                  ),
                ),


       Padding(
         padding: const EdgeInsets.all(8.0),
         child: _buildAddDeviceTF(),
       ),


                GestureDetector(
                  onTap: (){
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.5,
                      height: 50,
                      decoration:BoxDecoration(
                        color:Colors.blueAccent,
                        borderRadius:BorderRadius.circular(25)
                      ),
                      child:Center(child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 25),))
                    ),
                  ),
                ),


          
          
                 



      ]
    ),
  )
);



}
  }else{

 return Container(
          child: SingleChildScrollView(
            child: Column(children: [
              
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   height: 120,
                   width: double.infinity,
                   decoration: BoxDecoration(
                    // color: Colors.purple.withOpacity(0.3),
                     gradient: LinearGradient(colors: [
                       Colors.purple,
                       Colors.pink
                     ])
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                     Text("Find Collectors",style: TextStyle(color: black,fontWeight:FontWeight.bold,fontSize: 20,fontFamily: "OpenSans"),),
                     
                   ],),
                 ),
               ),


                Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   height: 120,
                   width: double.infinity,
                   decoration: BoxDecoration(
                    // color: Colors.purple.withOpacity(0.3),
                     gradient: LinearGradient(colors: [
                       Colors.purple,
                       Colors.pink
                     ])
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                     Text("Be A Collector",style: TextStyle(color: black,fontWeight:FontWeight.bold,fontSize: 20,fontFamily: "OpenSans"),)
                   ],),
                 ),
               )
          
          
              
            ],),
          ),);



  }



  }



   Widget _buildAddDeviceTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Add a device',
          style: TextStyle(color: black,fontWeight:FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
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
                Icons.developer_board,
                color: Colors.white,
              ),
              hintText: 'Enter the device name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  _IndicationBar(double indicatedValue, double totalValue) {

     double _valueCount = (50/totalValue) * indicatedValue;


             return  Container(
                            width: 120,
                            height: 20,
                            decoration: BoxDecoration(
                               color: Colors.grey.withOpacity(0.1)
                            ),
                            child: ListView.builder(
                              itemCount: _valueCount.toInt(),
                               scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 0.0,right: 0.0),
                                  child: Container(
                                  height: 20,
                                  width: 1.2,
                                  decoration: BoxDecoration(
                                    color: Colors.purple),
                                  ),
                                );
                            }
                            
                            ),
                          );




  }


  



int selectedDeviceItem = -1;


  _getDevices() {
List<BluetoothDevice> _deviceListDetected = _devicesList;

int lenDevices  = _deviceListDetected.length;



    return Container(
              
            
                height:200,
                child:ListView.builder(
                  itemCount: lenDevices,
                  itemBuilder: (context,index){
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         
                         selectedDeviceItem = index;
                         _device = _deviceListDetected[index];
                        

                       });
                     },
                     child: Container(
                       height: 40,
                       decoration: BoxDecoration(
                         color: (selectedDeviceItem == index)? Colors.purpleAccent : white
                         ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(_deviceListDetected[index].name,
                         style:TextStyle(color: (selectedDeviceItem == index) ? white : grey)),
                       ),
                     ),
                   );
                },
                )
                );
  }

  //add sample list ==============================================================add sub======================================

  void _addSub() {

    var random =  Random();
 
 double ph = widget.parameterList[0];
 double den = ( widget.parameterList[3] / widget.parameterList[2] );
 double fat = widget.parameterList[4];
 double temp = widget.parameterList[1];
  print("donee");
  controller.updatePh(ph);
  controller.updateDensity(den);
  controller.updateFatRate(fat);
  controller.updateVolume(int.parse(_volumeController.text) * 1000);
  controller.updatePrice(_getPrice());
  controller.updateVolume(widget.parameterList[3].toInt());
  controller.updateTemperature(temp);
  
  controller.addSubRecord(ph, fat, den, 1, _getPrice(),temp,calcGrade(widget.parameterList[0],
                                                             90,
                                                             (widget.parameterList[2] / widget.parameterList[3])));
  


  for(int i = 0;i<controller.subRecords.length;i++){
    print(controller.subRecords[i].ph_value.toStringAsFixed(2));
    print(controller.subRecords[i].fat_rate.toStringAsFixed(2));
    print(controller.subRecords[i].density.toStringAsFixed(2));
    print(controller.subRecords[i].volume.toStringAsFixed(0));
    print(controller.subRecords[i].price.toStringAsFixed(0));
    print(controller.subRecords[i].temperature.toStringAsFixed(0));
    print(controller.subRecords[i].grade);
  }


  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[

                            const  Text("Sample added",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child:const Text("Ok"),
                                  onPressed: () {

                                   


                                     Navigator.pop(context);

                                  },
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Go to current collection"),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentCollection()));
                                  },
                                ),
                              ),

                            

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });



  
  



  }

  bool dataReceived = false;
  
  connectDeviceScreen() {

    if(!dataReceived){
    return SelectBondedDevicePage(
        onCahtPage: (device1) {

          try{
           BluetoothDevice device = device1;
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(server: device);
              },
            ),
          );

          }on Exception catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
    rethrow;
  }
          


        },
      );


    }
    else{
  
    

   








    }
   

  }
  
  void _rejectSample() {
     


      showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: <Widget>[
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Add another sample"),
                                  onPressed: () {
                                     Navigator.pop(context);
                                  },
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Go to current collection"),
                                  onPressed: () {
                                     
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrentCollection()));

                                  },
                                ),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });


  }
  
 int _getPrice() {

    String g = calcGrade(widget.parameterList[0],
                                    90,
                                     (widget.parameterList[2] / widget.parameterList[3]));

    int pr = 0;
    if(g == "A"){
       pr = 100;
    }else if(g == "B"){
     pr = 98;
    }else if(g == "C"){
       pr = 96;
    }else{
      pr=92;
    }

    return pr;
  }



}
