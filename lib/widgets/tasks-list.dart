import 'package:CleanStreets/models/task-data.dart';
import 'package:CleanStreets/widgets/task-tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.getTasks[index];
            return TaskTile(
              id: task.id,
              title: task.title,
              callbackOnTap: () {
                taskData.getOnlineTask(task.id);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}

/*

TaskTile(
              title: task.title,
              callbackOnTap: () {
                taskData.getOnlineTask(task.id);
              },
            );
 */