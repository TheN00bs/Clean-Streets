import 'package:CleanStreets/models/shared-data.dart';
import 'package:CleanStreets/widgets/request-list.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HistoryWidget extends StatefulWidget {
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: SharedData.loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RequestList(
                notifyParentForLoad: refresh,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
