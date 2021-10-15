import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/colors.dart';

import 'package:http/http.dart' as http;





class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

var collectorList = [];

  @override
initState() {
  super.initState();
  loadData();
}

loadData() async{

 var client = http.Client();

try {
 
  var uriResponse = await client.get( Uri.parse('http://192.168.1.101:80/api/collectors') );

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
int selectedCollector = -1;

bool isLoading = true;


  @override
  Widget build(BuildContext context) {

  
  


    return Scaffold(
       body: isLoading ? Center(child: CircularProgressIndicator(color: Colors.purple,)) : getBody(),

       backgroundColor: white,
       
    );
  }

  getBody(){


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
                                  setState(() {
                                    selectedCollector = index;
                                  });
                                },
                                child: Container(
                                                          width:100,
                                                          height:30,
                                                          decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(20),
                                                           color:(selectedCollector == index) ? grey : blue,
                                                          ),
                                                          child: Center(
                                                           child: Text(
                                 (selectedCollector == index) ? "Cancel" : "Add",
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

 

}
