import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:milkapp/screens/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_urls/ApiUrl.dart';





class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

//for farmer
var collectorList = []; //inacive collectors
var activeCollectorList = []; //acive collectors

//for collector
var farmerReqsList = [];
var activeFarmerList = [];

bool isFarmer = false;

  @override
initState() {
  super.initState();
    
    getUserType();
  

 if(isFarmer){
   loadCollectorsList();
   loadActiveCollectorList();
 }else{
   loadRequestList();
   loadActiveFarmers();
 }  
  
  
}


getUserType () async{

  setState(() {
      isFarmer = true;
    });
    

 /* SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
 
    
    print(sharedPreferences.getString("type"));
  if(sharedPreferences.getString("type") == "Farmer"){

    setState(() {
      isFarmer = true;
    });
    
  }  */

}


loadRequestList() async{
  //send a request with collector id to get the request list (pending farmers)

var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.FARMER_REQUEST_URL),body: {'collector_id' : "2"} );
  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
  
  setState(() {
    isLoading = false;
    farmerReqsList = body_["pfarmers"];
  });



for (var item in body_["pfarmers"]) {

  print(item);

}

  }
  else{
print(body_);

  }



  }finally {

  client.close();

}



}



loadActiveFarmers() async{

var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.CONNECTED_FARMERS_WITH_COLLECTOR_URL),body: {'collector_id' : "2"} );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
  
  setState(() {
    isLoading = false;
    activeFarmerList = body_["afarmers"];
  });



for (var item in body_["afarmers"]) {

  print(item);

}

  }
  else{
print(body_);

  }



  }finally {

  client.close();

}




}



loadCollectorsList() async{

 var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.INACTIVE_COLLECTORS_URL),body: {'farmer_id' : "1"} );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
  
  setState(() {
    isLoading = false;
    collectorList = body_["collectors"];
  });



for (var item in body_["collectors"]) {

  print(item);

}

  }
  else{


  }



  }finally {
  client.close();
}


}


loadActiveCollectorList() async{

var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.ACTIVE_COLLECTORS_URL),body: {'farmer_id' : "6"} );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
  
  setState(() {
    isLoading = false;
    activeCollectorList = body_["acollectors"];
  });



for (var item in body_["acollectors"]) {

  print(item);

}

  }
  else{
print(body_);

  }



  }finally {

  client.close();

}



}



int selectedCollector = -1;

bool isLoading = true;


  @override
  Widget build(BuildContext context) {

  
  


    return Scaffold(
       body: isLoading ? Center(child: CircularProgressIndicator(color: Colors.purple,)) : getBody(),

       backgroundColor: white,
       
    );
  }


//accepting part
List<int> acceptedFarmersIndexes = [];
List<int> acceptingFarmersIndexes = [];


//senting part
List<int> sentRequestIndexes = [];
List<int> sentingRequestIndexes = [];



bool isFriendTabSelected = true;

  getBody(){        



if(isFarmer) {

  
return Container(
  child:SingleChildScrollView(
    child: Column(
  children: [

     Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
           GestureDetector(
             onTap: (){
                setState(() {
               isFriendTabSelected = !isFriendTabSelected;
             });
             },
             child: Container(
               width: MediaQuery.of(context).size.width * 0.45,
               height:50,
               decoration: BoxDecoration(
                 color: isFriendTabSelected ?  Colors.lightBlue : white
               ),
               child: Center(
                 child:Text("Connections",style: TextStyle(color: isFriendTabSelected ? white : grey,fontSize: 20),)
               ),
             ),
           ),

         GestureDetector(
           onTap: (){
             setState(() {
               isFriendTabSelected = !isFriendTabSelected;
             });
           },
           child: Container(
               width: MediaQuery.of(context).size.width * 0.45,
               height:50,
               decoration: BoxDecoration(
                 color: !isFriendTabSelected ?  Colors.lightBlue : white
               ),
               child: Center(
                 child:Text("Suggestions",style: TextStyle(color: !isFriendTabSelected ? white : grey,fontSize: 20),)
               ),
             ),
         ),


         ],
       ),
     ),

   !isFriendTabSelected ? _returnInactiveCollectorsForFarmer() : _returnActiveCollectorListForFarmer()




  ],
  ),)
);




}

else{

 
return SingleChildScrollView(
  child: Column(
children: [


 Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
           GestureDetector(
             onTap: (){
                setState(() {
               isRequestTabSelected = !isRequestTabSelected;
             });
             },
             child: Container(
               width: MediaQuery.of(context).size.width * 0.45,
               height:50,
               decoration: BoxDecoration(
                 color: !isRequestTabSelected ?  Colors.lightBlue : white
               ),
               child: Center(
                 child:Text("Connections",style: TextStyle(color: !isRequestTabSelected ? white : grey,fontSize: 20),)
               ),
             ),
           ),

         GestureDetector(
           onTap: (){
             setState(() {
              isRequestTabSelected = !isRequestTabSelected;
             });
           },
           child: Container(
               width: MediaQuery.of(context).size.width * 0.45,
               height:50,
               decoration: BoxDecoration(
                 color: isRequestTabSelected ?  Colors.lightBlue : white
               ),
               child: Center(
                 child:Text("Requests",style: TextStyle(color: isRequestTabSelected ? white : grey,fontSize: 20),)
               ),
             ),
         ),


         ],
       ),
     ),


     isRequestTabSelected ? _returnRequetsTabForCollector() : _returnFriendTabForCollectors()



],
),);



}




  }


_returnInactiveCollectorsForFarmer(){
  if (collectorList.isNotEmpty) {
  return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.symmetric(
          horizontal:15,
         ),
         
         child: ListView.builder(
           itemCount: collectorList.length,
           itemBuilder: (context,index){
  
             return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 150,
                       padding: EdgeInsets.symmetric(
                         horizontal: 20,
                         vertical: 15
                       ),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius:BorderRadius.circular(20),
                         gradient: LinearGradient(
                           colors: [
                             Colors.purpleAccent,
                             Colors.pink
                         ])
                       ),
                      child: Column(
                        children: [
  
  
                          Row(
                        children: [
                           
                          Container(
                            width: 40,
                            height:50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("images/pro_img.jpg"))
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(collectorList[index]['name'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          
  
                        ],
                      ),
  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           
  
                               Row(
                        children: [
  
                          Icon(Icons.place,size: 40,color: blue,),
                          Text(collectorList[index]['address'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          
  
                        ],
                      ),
  
                              GestureDetector(
                                onTap:(){
  
                                  if(!isSentReq(index)){
                                  
                                 setState(() {
                                    sentRequestIndexes.add(index);
                                    sentingRequestIndexes.add(index);
                                  });
  
                                      _sentRequest(collectorList[index]['collector_id'],index);
  
                                  }
  
                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color:isSentReq(index)  ? grey : blue,
                                                          ),
                                                          child: Center(
                                                           child: isSentingReq && isSentingReqIndex(index) ? CircularProgressIndicator() : Text(
                                !isSentReq(index) ? "Add" : "Sent",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              )
  
                        ],
                      ),
  
  
                      
                        SizedBox(height:5),
                    
                         Row(
                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                           children: [
  
                                Text(( collectorList[index]['a'] != null) ?"GradeA - ${ collectorList[index]['a']} |":"--",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                Text(( collectorList[index]['b'] != null) ?"GradeB - ${ collectorList[index]['b']} |":"--",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                Text(( collectorList[index]['c'] != null) ?"GradeC - ${ collectorList[index]['c']} |":"--",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                Text(( collectorList[index]['d'] != null) ?"GradeD - ${ collectorList[index]['d']} ":"--",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
  
                                    ],
                         )
  
  
  
                      ],)
                     ),
                   );
  
  
         })
       );
}

else{
   return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child:Center(
          child: Text("No suggested collectors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: grey),),
        )
    );

}

}

_returnActiveCollectorListForFarmer(){
  

if(activeCollectorList.isNotEmpty){
     
   return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.symmetric(
          horizontal:15,
         ),
         
         child: ListView.builder(
           itemCount: activeCollectorList.length,
           itemBuilder: (context,index){

             return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 160,
                       padding: EdgeInsets.symmetric(
                         horizontal: 20,
                         vertical: 15
                       ),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius:BorderRadius.circular(20),
                         gradient: LinearGradient(
                           colors: [
                             Colors.purpleAccent,
                             Colors.pink
                         ])
                       ),
                      child: Column(
                        children: [


                          Row(
                        children: [
                           
                          Container(
                            width: 40,
                            height:50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("images/pro_img.jpg"))
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(activeCollectorList[index]['name'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.place,size: 40,color: blue,),
                          Text(activeCollectorList[index]['address'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                             /* GestureDetector(
                                onTap:(){

                                

                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color: blue,
                                                          ),
                                                          child: Center(
                                                           child:  Text(
                                                            "Message",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              ) */

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.phone,size: 40,color: blue,),
                          Text(activeCollectorList[index]['contact'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                              GestureDetector(
                                onTap:(){

                                

                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color: blue,
                                                          ),
                                                          child: Center(
                                                           child:  Text(
                                                            "Call",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              )

                        ],
                      ),
                      
                     

                         


                      ],)
                     ),
                   );


         })
       );


   }else{

  return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child:Center(
          child: Text("No connected collectors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: grey),),
        )
    );
     


   }





}




  bool isRequestTabSelected = false;

  _returnRequetsTabForCollector(){

 if(farmerReqsList.isNotEmpty){

return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.symmetric(
          horizontal:15,
         ),
         
         child: ListView.builder(
           itemCount: farmerReqsList.length,
           itemBuilder: (context,index){

             return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 150,
                       padding: EdgeInsets.symmetric(
                         horizontal: 20,
                         vertical: 15
                       ),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius:BorderRadius.circular(20),
                         gradient: LinearGradient(
                           colors: [
                             Colors.purpleAccent,
                             Colors.pink
                         ])
                       ),
                      child: Column(
                        children: [


                          Row(
                        children: [
                           
                          Container(
                            width: 40,
                            height:50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("images/pro_img.jpg"))
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(farmerReqsList[index]['name'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.place,size: 40,color: blue,),
                          Text(farmerReqsList[index]['address'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                              GestureDetector(


                                onTap:(){


                                  if(!isAcceptedReq(index)){



                                    setState(() {
                                    acceptedFarmersIndexes.add(index);
                                    acceptingFarmersIndexes.add(index);
                                  });
                                     _acceptFarmerReq(farmerReqsList[index]['farmer_id'], index);

                                  }



                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color:isAcceptedReq(index) ? grey : blue,
                                                          ),
                                                          child: Center(
                                                           child: isAcceptingReq && isAcceptingReqIndex(index) ? 
                                                            CircularProgressIndicator()
                                                             : Text(
                                !isAcceptedReq(index) ? "Accept" : "Accepted",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              )

                        ],
                      ),


                      
                   


                      ],)
                     ),
                   );


         })
       );






  }
  else{


 return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child:Center(
          child: Text("No incoming farmer requests",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: grey),),
        )
    );


  }  




  }


  _returnFriendTabForCollectors(){

   if(activeFarmerList.isNotEmpty){
     
   return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.symmetric(
          horizontal:15,
         ),
         
         child: ListView.builder(
           itemCount: activeFarmerList.length,
           itemBuilder: (context,index){

             return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 160,
                       padding: EdgeInsets.symmetric(
                         horizontal: 20,
                         vertical: 15
                       ),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius:BorderRadius.circular(20),
                         gradient: LinearGradient(
                           colors: [
                             Colors.purpleAccent,
                             Colors.pink
                         ])
                       ),
                      child: Column(
                        children: [


                          Row(
                        children: [
                           
                          Container(
                            width: 40,
                            height:50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("images/pro_img.jpg"))
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(activeFarmerList[index]['name'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.place,size: 40,color: blue,),
                          Text(activeFarmerList[index]['address'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                             /* GestureDetector(
                                onTap:(){

                                

                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color: blue,
                                                          ),
                                                          child: Center(
                                                           child:  Text(
                                                            "Message",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              )*/

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.phone,size: 40,color: blue,),
                          Text(activeFarmerList[index]['contact'],style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                              GestureDetector(
                                onTap:(){

                                

                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color: blue,
                                                          ),
                                                          child: Center(
                                                           child:  Text(
                                                            "Call",
                                 style: TextStyle(color: white,fontFamily: "OpenSans"),
                                                           )
                                                          ),
                                                        ),
                              )

                        ],
                      ),
                      
                     

                         


                      ],)
                     ),
                   );


         })
       );


   }else{

  return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child:Center(
          child: Text("No connected farmers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: grey),),
        )
    );
     


   }




  }


  bool isAcceptedReq(int index){
    bool isAccepted = false;
    acceptedFarmersIndexes.forEach((element) {
      
      if(element == index){
        isAccepted = true;
      }

    });

    return isAccepted;
  }

    bool isSentReq(int index){
    bool isSent = false;
    sentRequestIndexes.forEach((element) {
      
      if(element == index){
        isSent = true;
      }

    });

    return isSent;
  }

 bool isSentingReqIndex(int index){
    bool isSentingIndex = false;
    sentingRequestIndexes.forEach((element) {
      
      if(element == index){
        isSentingIndex = true;
      }

    });

    return isSentingIndex;
  }

  bool isAcceptingReqIndex(int index){
    bool isacceptingIndex = false;
    acceptingFarmersIndexes.forEach((element) {
      
      if(element == index){
        isacceptingIndex = true;
      }

    });

    return isacceptingIndex;
  }


bool isSentingReq  = false;
bool isAcceptingReq = false;

  void _sentRequest(int id,int index) async{
    print(id);

    setState(() {
      isSentingReq = true;
    });

    var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.SEND_REQ_URL),
  body : { "collector_id" : id.toString(),
            "farmer_id" : "1"
   } );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
    setState(() {
      isSentingReq = false;
      sentingRequestIndexes.remove(index);
    });
  
print(body_);
  }
  else{
 print("something went wrong");
  setState(() {
      isSentingReq = false;
      sentingRequestIndexes.remove(index);
    });

    sentRequestIndexes.remove(index);

  }



  }finally {
  client.close();
}



  }


_acceptFarmerReq(int id, int index) async{



 print(id);

    setState(() {
      isAcceptingReq = true;
    });

    var client = http.Client();

try {
 
  var uriResponse = await client.post( Uri.parse(ApiUrl.ACCEPT_REQ_URL),
  body : { "collector_id" : "5",
            "farmer_id" : id.toString()
   } );

  var jsonString = uriResponse.body;
 
  var body_ = jsonDecode(jsonString);

  if(body_["success"]){
    setState(() {
      isAcceptingReq = false;
      acceptingFarmersIndexes.remove(index);
    });
  
print(body_);
  }
  else{
 print("something went wrong");
  setState(() {
      isAcceptingReq = false;
      acceptingFarmersIndexes.remove(index);
    });

    sentRequestIndexes.remove(index);

  }



  }finally {
  client.close();
}





}







}
