import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget{
  static const String id = "AboutUs";
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(

                children: [
                  const ListTile(
                    leading: Icon(Icons.account_circle, size: 50,),
                    title: Text("Saurabh Verma"),
                    subtitle: Text("saurabhshalu@gmail.com"),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(Icons.account_circle, size: 50,),
                    title: Text("Mahershi Bhavsar"),
                    subtitle: Text("mahershi1999@gmail.com"),
                  )
                ],
              ),
            )
          ],
        )
      );
  }

}