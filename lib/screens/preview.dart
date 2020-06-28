import 'dart:typed_data';
import 'dart:convert' as convert;
import '../models/shared-data.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  static const String id = 'preview_screen';
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = convert.base64Decode(SharedData.selectedRequest['img']);
    return Scaffold(
      appBar: AppBar(
        title: Text(SharedData.selectedRequest['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.memory(bytes),
            Text(SharedData.selectedRequest['status']),
            Text('DELETE')
          ],
        ),
      ),
    );
  }
}
