import 'dart:io';

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

  static void sendData(String user, String title, File imgFile) async {
    var url = 'https://cleanstreets.herokuapp.com/newrequest';
    List<int> imageBytes = imgFile.readAsBytesSync();
    String base64Image = convert.base64Encode(imageBytes);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        <String, String>{
          'user': user,
          'title': title,
          'img': base64Image,
        },
      ),
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('success....!!!---');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future getOne(String id) async {
    var url = 'https://cleanstreets.herokuapp.com/' + email + '/' + id;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
