import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'colors.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

Completer<GoogleMapController> _controlller = Completer();
static final CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(
    11.5760029,
    104.845914
  ),
  zoom: 15.4746
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    // floatingActionButton: getFloatingActionButtons(),
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }


getBody(){

    return GoogleMap(
        initialCameraPosition: _kGooglePlex,
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
     onMapCreated: (GoogleMapController controller){
         _controlller.complete(controller);

    },
    );
}



  getFloatingActionButtons()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 60,left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Entypo.user,color: primary,size: 28,),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Feather.search,color: white,size: 23,),
                      )
                    ],
                  ),

                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle
                    ),
                    child: Icon(AntDesign.setting,color: white,size: 20,),
                  ),

                ],
              )


            ],
          ),

          Row(
            children: [
              Container(
                width: 80,
                height: 75,
                child: Stack(
                  children: [

                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                            border: Border.all(color: Colors.white,
                                width: 6)
                        ),
                        child: Icon(Entypo.user,color:grey.withOpacity(0.4),size: 28,),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("My Bitmoji",style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    )

                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Icon(FontAwesome.location_arrow,color: black,size: 23,)),
              Spacer(),
              Container(
                width: 80,
                height: 75,
                child: Stack(
                  children: [

                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                            border: Border.all(color: Colors.white,
                                width: 6)
                        ),
                        child: Icon(Entypo.user,color:grey.withOpacity(0.4),size: 28,),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Friends",style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),


        ],
      ),
    );



  }

}
