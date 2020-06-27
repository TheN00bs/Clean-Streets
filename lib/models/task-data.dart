import 'dart:collection';

import 'package:CleanStreets/models/Task.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(id: '160160107110', title: 'Saurabh Verma'),
    Task(id: '160160107005', title: 'Mahershi'),
  ];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get getTasks {
    return UnmodifiableListView(_tasks);
  }

/*
  void addTask(String newTaskTitle) {
    Task task = Task(text: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleIsDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
*/
  void getOnlineTask(String id) async {
    var url = 'https://cleanstreets.herokuapp.com/mahershi1999@gmail.com';//https://jsonplaceholder.typicode.com/todos
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      for(var x in jsonResponse) {
        Task temp = new Task(id: x['id'], title: x['user']);
        _tasks.add(temp);
        notifyListeners();
        print(x['title']);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}