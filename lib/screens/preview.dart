import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Streets'),
      ),
      body: Column(
        children: <Widget>[
          Text('title'),
          Image.asset('/images/clean_streets.png'),
          Text('Status'),
          Text('DELETE')
        ],
      ),
    );
  }
}
