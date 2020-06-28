import 'dart:io';

import 'package:CleanStreets/models/shared-data.dart';
import 'package:flutter/material.dart';

class NewRequestScreen extends StatefulWidget {
  static const String id = "new_request_screen";
  final File image;

  NewRequestScreen({Key key, @required this.image}) : super(key: key);

  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  @override
  NewRequestScreen get widget => super.widget;

  TextEditingController titleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenHeight / 2,
                  minHeight: screenHeight / 2,
                  minWidth: screenWidth,
                  maxWidth: screenWidth),
              child: FittedBox(
                child: Image.file(widget.image),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    onPressed: () async {
                      var response = await SharedData.sendData(
                          SharedData.email, titleController.text, widget.image);
                      print(response);
                      print('====7=7=7=7=7=7=777777777777');
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
