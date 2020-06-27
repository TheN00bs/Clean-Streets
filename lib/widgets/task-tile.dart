import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
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

/*
class TaskT extends StatelessWidget {

  final String id;
  TaskT({this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(id),
    );
  }

}

 */