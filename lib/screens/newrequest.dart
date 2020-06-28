import 'dart:io';

import 'package:flutter/material.dart';

class NewRequestScreen extends StatefulWidget{
  static const String id = "new_request_screen";
  File image;

  NewRequestScreen({Key key, @required this.image}) : super(key: key);

  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen>{

  @override
  NewRequestScreen get widget => super.widget;

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenHeight/2,
            minHeight: screenHeight/2
          ),
          child: FittedBox(
              child: Image.file(widget.image),
              fit: BoxFit.contain,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
              margin: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              )
          ),
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: OutlineButton(
              child: Text("Confirm", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      )
    );
  }
}