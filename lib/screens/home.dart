import 'dart:io';

import 'package:CleanStreets/widgets/request-list.dart';
import 'package:CleanStreets/widgets/request-tile.dart';

import '../models/shared-data.dart';
import 'package:CleanStreets/widgets/tasks-list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Streets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RequestList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
        tooltip: 'Pick Image',
      ),
    );
  }
}

/*
 '${Provider.of<TaskData>(context).taskCount} Task',



 decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),




_image == null
                ? Text('No image selected.')
                : Image.file(_image),


                ListView.builder(
              itemCount: x.length,
              itemBuilder: (BuildContext c, int i) {
                if(i.isOdd) return Divider();
                final index = i ~/ 2 + 1;
                return _buildRow(index);
              },
            ),

              Widget _buildRow(int idx) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('$idx'),
      ),
      title: Text(
        'Item $idx',
      ),

    );
  }

 */