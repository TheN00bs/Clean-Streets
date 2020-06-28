import 'package:CleanStreets/screens/home.dart';
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
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PreviewScreen.id: (context) => PreviewScreen(),
        NewHomeScreen.id: (context) => NewHomeScreen(),
        NewRequestScreen.id: (context) => NewRequestScreen(
              image: null,
            ),
      },
    );
  }
}
