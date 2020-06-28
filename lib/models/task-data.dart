import 'dart:collection';

import 'package:CleanStreets/models/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class TaskData {
  static List<Task> _tasks = [];

  static UnmodifiableListView<Task> get getTasks {
    getOnlineTask('mahershi1999@gmail.com');
    return UnmodifiableListView(_tasks);
  }

  static void getOnlineTask(String id) async {
    var url = 'https://cleanstreets.herokuapp.com/' + id;//https://jsonplaceholder.typicode.com/todos
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = convert.jsonDecode(response.body);
      _tasks.clear();
      for(var x in jsonResponse) {
        Task temp = new Task(id: x['id'], title: x['title']);
        _tasks.add(temp);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}