import 'dart:io';
import '../models/shared-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPreviewPage extends StatefulWidget {
  @override
  _CameraPreviewPageState createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  @override
  Widget build(BuildContext context) {
    if (SharedData.cameraImage == null) {
      return Center(
        child: Text('No image Selected'),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Image.file(
            File(SharedData.cameraImage),
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 60.0,
            color: Colors.black,
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('shared');
                  // getBytesFromFile().then((bytes){
                  //   Share.file('Share via', basename(widget.imgPath), bytes.buffer.asUint8List(),'image/path');
                  // });
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  // Future<ByteData> getBytesFromFile() async {
  //   Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
  //   return ByteData.view(bytes.buffer);
  // }
}
