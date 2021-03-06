import 'package:CleanStreets/cams/camera_screen.dart';
import 'package:CleanStreets/screens/about.dart';
import 'package:CleanStreets/screens/login.dart';
import 'package:CleanStreets/screens/newhome.dart';
import 'package:CleanStreets/screens/newrequest.dart';
import 'package:CleanStreets/screens/preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        AboutUs.id: (context) => AboutUs(),
        LoginScreen.id: (context) => LoginScreen(),
        PreviewScreen.id: (context) => PreviewScreen(),
        NewHomeScreen.id: (context) => NewHomeScreen(),
        CameraScreen.id: (context) => CameraScreen(),
        NewRequestScreen.id: (context) => NewRequestScreen(
              image: null,
            ),
      },
    );
  }
}
