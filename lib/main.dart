import 'package:CleanStreets/screens/home.dart';
import 'package:CleanStreets/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/task-data.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
        },
      ),
    );


  }
}

/*


      MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
 */