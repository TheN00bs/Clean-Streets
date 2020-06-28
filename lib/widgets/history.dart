import 'package:CleanStreets/widgets/request-list.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RequestList(),
          ),
        ),
      ],
    );
  }
}
