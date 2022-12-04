import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:milkapp/screens/home_page.dart';
import 'package:restart_app/restart_app.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
   BluetoothConnection? connection;

  List<_Message> messages = [];
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;


  bool get isConnected => connection != null && connection!.isConnected;  ///////////////

  bool isDisconnecting = false;

  List<double> parameterList = [];

  double calculatedWeight = 500;

  double calculatedFat = 70;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection!.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.center
            : MainAxisAlignment.center,
      );
    }).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.white,
        onPressed: (() {


        if(parameterList.length == 4){
          messages.clear();
          parameterList.add(calculatedFat);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(
          hc05Connected: false,
          isStart: false,
          parameterList: parameterList,)));
        }
       
        

      }),
      child: Icon(Icons.add,color: Colors.purple,size: 30,),
      ),
      appBar: AppBar(
        backgroundColor: isConnecting ? Colors.red : Colors.blue,
          title: (isConnecting
              ? Text('Connecting to ' + widget.server.name + '...')
              : isConnected
                  ? Text('Active ' + widget.server.name)
                  : Text('Chat log with ' + widget.server.name))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    GestureDetector(
                      onTap: isConnected ? () => _getDataFromSensors() : null,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                           color: Colors.purple,
                           borderRadius: BorderRadius.circular(5)
                        ),
                        child:const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child:  Center(child: Text("Get Data", style: TextStyle(color: Colors.white),)),
                        ),
                      ),//ClipOval(child: Image.asset('images/ledOn.png')),
                    ),

                  /*  GestureDetector(
                      onTap: isConnected ? () => _sendMessage('t') : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                           color: Colors.purple,
                           borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(child: Text("T", style: TextStyle(color: Colors.white),)),
                      ),//ClipOval(child: Image.asset('images/ledOn.png')),
                    ),


                    GestureDetector(
                      onTap: isConnected ? () => _sendMessage('v') : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                           color: Colors.purple,
                           borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(child: Text("V", style: TextStyle(color: Colors.white),)),
                      ),//ClipOval(child: Image.asset('images/ledOn.png')),
                    ),

                    GestureDetector(
                      onTap: isConnected ? () => _sendMessage('w') : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                           color: Colors.purple,
                           borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Center(child: Text("W", style: TextStyle(color: Colors.white),)),
                      ),//ClipOval(child: Image.asset('images/ledOn.png')),
                    ),  */




                    
                  ],
                ),
              
            ),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            /*
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Wait until connected...'
                            : isConnected
                                ? 'Type your message...'
                                : 'Chat got disconnected',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isConnected
                          ? () => _sendMessage(textEditingController.text)
                          : null),
                ),
              ],
            ) */
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    print("data received");
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {

      _Message receivedMessage =     _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          );

          if(parameterList.length >= 4){//remove past values from the list
            parameterList.clear();
          }

          if(parameterList.length == 3){
          print("parameter list");
          print(parameterList);
         String g =  calcGrade(parameterList[0], calculatedFat, 1.34);
          _sendMessage(g);
          }


          

         var par = [];
         par = receivedMessage.text.split(":");
         
        
        String var1 = par[1];
        parameterList.add(double.parse(var1.split("_")[1]));
       _Message _storedMessage;
       
        
         _storedMessage = _Message(1, "${par[0]}:${var1.split("_")[1]}");
      

        par.clear();

         if(messages.length >= 4){
          setState(() {
            messages.clear();
          });
         }

        messages.add(
          _storedMessage
        );


        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(utf8.encode(text + "\r\n") as Uint8List);
        await connection!.output.allSent;

       /* if(text == 'p') text = "PH";
        if(text == 't') text = "Temperature";
        if(text == 'v') text = "Volume";
        if(text == 'w') text = "Weight"; */

      /*  setState(() {
          messages.add(_Message(clientID, text));
        }); */

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
  
  _getDataFromSensors() {
    print("get data from sensors");
    _sendMessage('p');
    _sendMessage('t');
    _sendMessage('v');
    _sendMessage('w');
    print("sent sigmal");

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


}
