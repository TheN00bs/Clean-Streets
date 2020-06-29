import 'dart:io';

import '../models/shared-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPreviewPage extends StatefulWidget {
  final Function() notifyParent;
  CameraPreviewPage({@required this.notifyParent});
  @override
  _CameraPreviewPageState createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  TextEditingController titleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (SharedData.cameraImage == null) {
      return Center(
        child: Text('No image Selected'),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: screenHeight / 2,
                minHeight: screenHeight / 2,
                minWidth: screenWidth,
                maxWidth: screenWidth),
            child: FittedBox(
              child: Image.file(
                File(SharedData.cameraImage),
              ),
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
                    await SharedData.sendData(
                      SharedData.email,
                      titleController.text,
                      File(SharedData.cameraImage),
                    );
                    setState(() {
                      SharedData.currentIndexPage = 0;
                    });
                    widget.notifyParent();
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
    );
  }

  // Future<ByteData> getBytesFromFile() async {
  //   Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
  //   return ByteData.view(bytes.buffer);
  // }
}
