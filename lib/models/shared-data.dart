import 'package:CleanStreets/models/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SharedData {
  static String name;
  static String email;
  static String profileUrl;

  static List<Task> _tasks = [];

  static Future<List<Task>> getData() async {
    var url = 'https://cleanstreets.herokuapp.com/' +
        email; //https://jsonplaceholder.typicode.com/todos
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      _tasks.clear();
      for (var x in jsonResponse) {
        Task temp = new Task(id: x['id'], title: x['title']);
        _tasks.add(temp);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return _tasks;
  }

  static Future getOne(String id) async {
    var url = 'https://cleanstreets.herokuapp.com/' +
        email +
        '/' +
        id; //https://jsonplaceholder.typicode.com/todos
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
