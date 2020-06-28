import 'package:CleanStreets/models/Task.dart';
import 'package:CleanStreets/models/task-data.dart';
import 'package:CleanStreets/widgets/task-tile.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {

  List<Widget> getTaskList(List<Task> data) {
    List<TaskTile>  _tiles= [];
    for(Task da in data) {
      _tiles.add(TaskTile(id: da.id, title: da.title,));
    }
    return _tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Text('WORK hard');
    /*
    List<Task> _tasks = taskData.getTasks;
    if(_tasks.length == 0)
      return Center(
        child: Text("You haven't requested anything yet.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white60,
          ),),
      );
    else
      return ListView(
        children: getTaskList(_tasks),
      );

     */
  }
}