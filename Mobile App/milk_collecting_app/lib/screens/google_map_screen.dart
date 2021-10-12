import 'package:flutter/material.dart';
import 'package:milk_collecting_app/screens/colors.dart';





class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {

  int selectedCollector = -1;
  


    return Scaffold(
       body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         padding:EdgeInsets.symmetric(
          horizontal:15,
         ),
         
         child: ListView.builder(
           itemCount: 10,
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
                          Text("Chandrasekara cma",style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           

                               Row(
                        children: [

                          Icon(Icons.place,size: 40,color: blue,),
                          Text("Anuradhapura",style:TextStyle(color:white,fontFamily: "OpenSans")),
                          

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
                                Text("Grade A - 100 |",style:TextStyle(fontWeight: FontWeight.bold)),
                                Text("Grade B - 90 |",style:TextStyle(fontWeight: FontWeight.bold)),
                                Text("Grade C - 80 |",style:TextStyle(fontWeight: FontWeight.bold)),
                                Text("Grade D - 70",style:TextStyle(fontWeight: FontWeight.bold))
                         ],
                         )



                      ],)
                     ),
                   );


         })
       ),
       backgroundColor: white,
       
    );
  }

 

}
