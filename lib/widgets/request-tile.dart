import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  RequestTile({
    this.id,
    this.title,
    this.callbackOnTap
  });
  final String id;
  final String title;
  final Function callbackOnTap;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callbackOnTap,
      title: Text(
        title,
      ),
    );
  }
}
