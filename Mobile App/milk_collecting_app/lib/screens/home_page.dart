import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  bool isFarmer = false;

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

  @override
initState() {
  super.initState();
  bluetoothConnectionState();
  loadData();
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
    "Farmer 1",
    "Farmer 2",
    "Farmer 3",
    "Farmer 4",
    "Farmer 5",
    "Farmer 6",
    "Farmer 7",
    "Farmer 8"
  ];


  



  Widget _buildConnectWithFarmerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
         setState(() {
           
           isStart = false;

         });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          "Connect with " + selectedFarmer,
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



  getBody(){
    var size = MediaQuery.of(context).size;
    



if(!isFarmer){

if(isDeviceConnected){
    if(isStart){

      return SingleChildScrollView(
        child: Column(
        children : [

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             height:MediaQuery.of(context).size.height * 0.6,
             decoration: BoxDecoration(
               color: white,
               borderRadius: BorderRadius.circular(20)
             ),
             child:ListView.builder(
               itemCount: farmers_list.length,
               itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        

                         selectedFarmerIndex = index;
                         selectedFarmer = farmers_list[index];

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          
                          color: (selectedFarmerIndex == index)?Colors.purple:white,
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

         

        _buildConnectWithFarmerBtn()



        ]
      ),);

    }



    return SingleChildScrollView(
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
                      color: Colors.purpleAccent,
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
                          child: Icon(Icons.edit))

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
                              Text("90",
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
                              Text("6.6",
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
                              Text("2.0",
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
                              Text("20.0",
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
                   color: Colors.red ), 
                                      
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
                   color: Colors.amber ), 
                                      
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
}else{

//_buildBluetoothInterface();

return Container(
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
                      RaisedButton(
                        onPressed:
                            // To be implemented : _disconnect and _connect
                            _pressed ? null : _connected ? _disconnect : _connect, 
                        child: Text(_connected ? 'Disconnect' : 'Connect'),
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


                _getDevices(),

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
                        color:!_connected ? Colors.grey : Colors.purple
                      ),
                      child:Center(child: Text("Go",style: TextStyle(color: Colors.white,fontSize: 25),))
                    ),
                  ),
                )



          
          
                 



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
              
                color: Colors.white,
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



}
