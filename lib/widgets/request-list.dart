import 'package:CleanStreets/models/Task.dart';
import 'package:CleanStreets/models/shared-data.dart';
import 'package:CleanStreets/widgets/request-tile.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() =>_RequestListState();


}

class _RequestListState extends State<RequestList> {
  List<Task> _tasks = [];
  @override
  initState() {
    super.initState();
    callGetData();
  }

  callGetData() async {
    var tasks = await SharedData.getData();
    setState(() {
      _tasks = tasks;
    });
  }

  List<Widget> getTaskList(List<Task> data) {
    List<RequestTile>  _tiles= [];
    for(Task da in data) {
      _tiles.add(RequestTile(id: da.id, title: da.title,),);
    }
    return _tiles;
  }

  @override
  Widget build(BuildContext context) {
    if(_tasks.length==0)
      return Center(child: Text("You haven't requested anything yet.", textAlign: TextAlign.center, style: TextStyle(
        fontSize: 25.0,
        color: Colors.white70,
      ),),);
    else
      return ListView(
        children: getTaskList(_tasks),
      );
  }
}
