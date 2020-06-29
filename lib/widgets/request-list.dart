import 'package:CleanStreets/models/Task.dart';
import 'package:CleanStreets/screens/preview.dart';
import '../models/shared-data.dart';
import 'package:CleanStreets/widgets/request-tile.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  final Function() notifyParentForLoad;
  RequestList({@required this.notifyParentForLoad});
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List<Task> _tasks = SharedData.getListItems();
  @override
  initState() {
    super.initState();
    callGetData();
  }

  callGetData() async {
    if (SharedData.alreadyRequested == false) {
      var tasks = await SharedData.getData();
      if (this.mounted) {
        setState(() {
          _tasks = tasks;
        });
      }
    }
  }

  List<Widget> getTaskList(List<Task> data) {
    List<Widget> _tiles = [];
    for (var i = data.length - 1; i >= 0; i -= 1) {
      _tiles.add(
        RequestTile(
          id: data[i].id,
          title: data[i].title,
          callbackOnTap: () async {
            setState(() {
              SharedData.loading = true;
            });
            widget.notifyParentForLoad();
            await SharedData.getOne(data[i].id);
            setState(() {
              SharedData.loading = false;
            });
            widget.notifyParentForLoad();
            Navigator.pushNamed(context, PreviewScreen.id);
          },
        ),
      );
      _tiles.add(Divider());
    }
    // for (Task da in data) {
    //   _tiles.add(
    //     RequestTile(
    //       id: da.id,
    //       title: da.title,
    //       callbackOnTap: () async {
    //         await SharedData.getOne(da.id);
    //         Navigator.pushNamed(context, PreviewScreen.id);
    //       },
    //     ),
    //   );
    //   _tiles.add(Divider());
    // }
    return _tiles;
  }

  @override
  Widget build(BuildContext context) {
    if (_tasks.length == 0)
      return Center(
        child: Text(
          "You haven't requested anything yet.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white70,
          ),
        ),
      );
    else
      return ListView(
        children: getTaskList(_tasks),
      );
  }
}
