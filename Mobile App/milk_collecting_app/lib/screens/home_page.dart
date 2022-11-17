import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:milk_collecting_app/controllers/record_controller.dart';
import 'package:milk_collecting_app/screens/BluetoothConScreen.dart';
import 'package:milk_collecting_app/screens/change_price_screen.dart';
import 'package:milk_collecting_app/screens/home_screen.dart';
import 'package:milk_collecting_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'colors.dart';




class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isStart = true;
  int selectedFarmerIndex = -1;
  String selectedFarmer = "";
    String defaultFarmer = "";
    String defaultFarmerName = "";

   bool isdefaultFarmerSelected = false;
   bool isConnectedFarmerSelected = false;


  bool isFarmer = false;

  bool isDefaultCow = false;
  bool isDefaultBuffalo = false;

  bool isConnected = false;

  bool isDeviceConnected = false;
  bool isGoBtnActive = false;
  

  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  late BluetoothDevice _device;
  bool _connected = false;
  bool _pressed = false;

  bool _isDataLoading = false;

   TextEditingController _defaultFarmerController = TextEditingController();

  final controller = Get.put(RecordController());

  @override
initState() {
  super.initState();
  bluetoothConnectionState();
  loadData();
 
}

  double _pH = 0.0;
	double _fatrate = 0.0;
	double _density = 0.0;
  String _grade = "";
  double _temperature = 0.0;
  double _volume = 0.0;

_getDataViaBlue(){

  //sleep(Duration(seconds: 20));
    
  double pH = 6.7;
	double fatrate = 80;
	double density = 1.2;
  String grade = calcGrade(pH,fatrate,density);
  double temperature = 27.0;
  double volume = 1.0;




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





 // We are using async callback for using await
  Future<void> bluetoothConnectionState() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Errorxxxx");
    }

    // For knowing when bluetooth is connected and when disconnected
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });

          break;

        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;

        default:
          print(state);
          break;
      }
    });

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
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
      body: getBody(),
      backgroundColor: grey.withOpacity(.3),
     
      
    
    );
  }

  List<String> farmers_list = [
    "H K Perera",
    "C M Chandrasekara",
    "H M Saman",
    "Kamal",
    "Namal"
    
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

  



  Widget _buildConnectWithFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0,horizontal: 30),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
         setState(() {
           
           isStart = false;
           _isDataLoading = true;

          _getDataViaBlue();
           
              Timer(Duration(seconds: 5), () {
                    
                     setState(() {
                       _isDataLoading = false;
                     });
                   });

         

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


Widget _buildConnectWithDefaultFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
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
              hintText: 'Enter your a quick farmer',
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
                width: 80,
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
                width: 80,
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
    if(isStart){

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

         

      
       
        _buildConnectWithDefaultFarmerBtn(),
          _buildConnectWithFarmerBtn(),



        ]
      ),);

    }
          
    /*  if(controller.c < 12){

   return ;
      }  */
 
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              
                              isStart = true;

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Switch farmer",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 20,
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


        
          SizedBox(height: 20,),

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
                    width: 120,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                        Text("100.00 lkr",style: TextStyle(color: white,fontSize: 15,fontWeight: FontWeight.bold),),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePriceScreen()));
                          },
                          child: Icon(Icons.edit,color:white))

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
                                   child: Text( (_isDataLoading) ? "..":_grade,style: TextStyle(
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
                              Text((_isDataLoading) ? "Loading..." : _fatrate.toStringAsFixed(0),
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

                              Text("PH",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : _pH.toString(),
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

                              Text("Density(gcm-3)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : _density.toString(),
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

                              Text("Volume(Litres)",
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),
                              SizedBox(height: 10,),
                              Text((_isDataLoading) ? "Loading..." : _volume.toStringAsFixed(1),
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
                              Text((_isDataLoading) ? "Loading..." : _temperature.toStringAsFixed(0),
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
            SizedBox(height:10),

           ////arcs
           Text("Fat Rate",style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize:20,)),
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
 angle: 90,
 widget: Text(
 "90%",
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)
 ))
]
                      )
                 ],
                 


             )
             
             ),




             Text("pH",style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize:20,)),
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
                   RangePointer(value: 6.6,
                   color: Colors.cyan ), 
                                      
],
annotations: [
   GaugeAnnotation(
 positionFactor: 0.1,
 angle: 90,
 widget: Text(
 "6.6",
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)
 ))
]
                      )
                 ],
                 


             )
             
             ),
      
      

      
             Text("Density",style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize:20,)),
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
                   RangePointer(value: 1.030,
                   color: Colors.blue ), 
                                      
],
annotations: [
   GaugeAnnotation(
 positionFactor: 0.1,
 angle: 90,
 widget: Text(
 "1.030",
 style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)
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
                 _addSub();
               },
               child: Padding(
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: RaisedButton(
                          onPressed:
                              // To be implemented : _disconnect and _connect
                              _pressed ? null : _connected ? _disconnect : _connect, 
                          child: Text(_connected ? 'Disconnect' : 'Connect'),
                        ),
                      ), 
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


  Container _buildBluetoothInterface() {



return Container(
          // Defining a Column containing FOUR main Widgets wrapped with some padding:
          // 1. Text
          // 2. Row
          // 3. Card
          // 4. Text (wrapped with "Expanded" and "Padding")
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
          
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "PAIRED DEVICES",
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),

               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Defining a Row containing THREE main Widgets:
                  // 1. Text
                  // 2. DropdownButton
                  // 3. RaisedButton
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Device:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        // To be implemented : _getDeviceItems()
                        items: _getDeviceItems(),
                        onChanged: (value){
                          setState(() {
                           // _device = value;
                          });
                        },
                        //value: _device,
                      ),
                      RaisedButton(
                        onPressed:
                            // To be implemented : _disconnect and _connect
                            _pressed ? null : _connected ? _disconnect : _connect, 
                        child: Text(_connected ? 'Disconnect' : 'Connect'),
                      ),
                       
                    ],
                  ),
                ),
          
          
                Padding(
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
                ),
          
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "NOTE: If you cannot find the device in the list, "
                        "please turn on bluetooth and pair the device by "
                        "going to the bluetooth settings",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                )  
          
          
          
              ],
            ),
          ),
        );
      






  }



   // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
}


// Method to connect to bluetooth
  void _connect() {
    if (_device == null) {
      show('No device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth
              .connect(_device)
              .timeout(Duration(seconds: 10))
              .catchError((error) {
            setState(() => _pressed = false);
          });
         // setState(() =>   _pressed = true);

          setState(() {
            _pressed = true;
            isGoBtnActive = true;
          });
          
        }
      });
    }
  }  

  // Method to disconnect bluetooth
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }
   // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState!.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }



  // Method to send message,
  // for turning the bletooth device on
  void _sendOnMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("1");
        show('Device Turned On');
      }
    });
  }

  // Method to send message,
  // for turning the bletooth device off
  void _sendOffMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("0");
        show('Device Turned Off');
      }
    });
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

  void _addSub() {

    var random = new Random();
 
 double ph = random.nextInt(100).toDouble();
 double den = random.nextInt(2).toDouble();
 double fat = random.nextInt(100).toDouble();
 double temp = random.nextInt(30).toDouble();

  controller.updatePh(ph);
  controller.updateDensity(den);
  controller.updateFatRate(fat);
  controller.updateVolume(1);
  controller.updatePrice(90);
   controller.updateVolume(1);
  controller.updatePrice(90);
   controller.updateTemperature(temp);

  controller.addSubRecord(ph, fat, den, 1, 90,temp,"a");
  

  print(controller.ph_value);
  print(controller.density);
  print(controller.fat_rate);

  for(int i = 0;i<controller.subRecords.length;i++){
    print(controller.subRecords[i].ph_value.toStringAsFixed(2));
    print(controller.subRecords[i].fat_rate.toStringAsFixed(2));
    print(controller.subRecords[i].density.toStringAsFixed(2));
    print(controller.subRecords[i].volume.toStringAsFixed(0));
    print(controller.subRecords[i].price.toStringAsFixed(0));
      print(controller.subRecords[i].temperature.toStringAsFixed(0));
    print(controller.subRecords[i].grade);
  }

  



  }



}
