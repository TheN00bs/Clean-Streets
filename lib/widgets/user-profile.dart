import 'package:CleanStreets/models/shared-data.dart';
import 'package:CleanStreets/screens/login.dart';
import 'package:CleanStreets/tools/sign_in_module.dart';
import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.maxFinite,
              ),
              Card(
                // with Card
                child: Image.network(SharedData.profileUrl),
                elevation: 18.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  SharedData.name,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  SharedData.email,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Chip(
                  padding: EdgeInsets.all(10.0),
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                  label: Text(
                    'Total submissions: ' + SharedData.getCount().toString(),
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),
              ),
              OutlineButton(
                onPressed: () {
                  signOutGoogle().then((value) {
                    SharedData.currentIndexPage = 0;
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
