import 'package:CleanStreets/cams/camera_preview.dart';
import 'package:CleanStreets/cams/camera_screen.dart';
import 'package:CleanStreets/models/shared-data.dart';
import 'package:CleanStreets/widgets/history.dart';
import 'package:CleanStreets/widgets/user-profile.dart';
import 'package:flutter/material.dart';

class NewHomeScreen extends StatefulWidget {
  static const String id = 'new_home_screen';
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  refresh() {
    setState(() {});
  }

  List<Widget> _tabs = [
    HistoryWidget(),
    Center(
      child: Text('No image Selected!'),
    ),
    UserProfileWidget(),
  ];
  //int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Streets'),
      ),
      body: SharedData.currentIndexPage == 1
          ? CameraPreviewPage(
              notifyParent: refresh,
            )
          : _tabs[SharedData.currentIndexPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text('Request Cleanup'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: SharedData.currentIndexPage,
        onTap: (index) {
          setState(() {
            SharedData.currentIndexPage = index;
          });
          if (index == 1) {
            SharedData.cameraImage = null;
            Navigator.pushNamed(context, CameraScreen.id).then(
              (value) {
                print(SharedData.cameraImage);
                setState(() {
                  SharedData.currentIndexPage = 1;
                });
              },
            );
          }
        },
      ),
    );
  }
}
