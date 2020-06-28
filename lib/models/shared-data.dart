import 'dart:io';

import 'package:CleanStreets/models/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;


class SharedData {
  static String name;
  static String email;
  static String profileUrl;
  static bool alreadyRequested = false;

  static String cameraImage;

  static List<Task> _tasks = [];

  static var selectedRequest;

  static int getCount() {
    return _tasks.length;
  }

  static List<Task> getListItems() {
    return _tasks;
  }

  static Future<List<Task>> getData() async {
    alreadyRequested = true;
    var url = 'https://cleanstreets.herokuapp.com/' + email;
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
    alreadyRequested = false;
    return _tasks;
  }

  static Future<Task> sendData(String user, String title, File imgFile) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
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
          'status': 'active',
          'latitude': latitude,
          'longitude': longitude
        },
      ),
    );

    if (response.statusCode == 200) {
      var res = convert.jsonDecode(response.body);
      Task temp = new Task(id: res['id'], title: res['title']);
      _tasks.add(temp);
      return temp;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<String> getOne(String id) async {
    var url = 'https://cleanstreets.herokuapp.com/' + email + '/' + id;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      //return convert.jsonDecode(response.body);
      selectedRequest = convert.jsonDecode(response.body);
      return 'success';
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static getLocationPermission() async {
    print("In");
    loc.Location location = new loc.Location();
    bool _locationEnabled = await location.serviceEnabled();
    if(!_locationEnabled){
      print("Asking Location");
      _locationEnabled = await location.requestService();

      if(!_locationEnabled){
        SystemNavigator.pop();
      }
    }
    loc.PermissionStatus _permissionGranted = await location.hasPermission();
    if(_permissionGranted == loc.PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();

      if(_permissionGranted == loc.PermissionStatus.denied){
        SystemNavigator.pop();
      }
    }

    /*GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    print(geolocationStatus);
    if (geolocationStatus == GeolocationStatus.denied) {
      try {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print(geolocationStatus);
        print(position);

      } catch (e) {
        SystemNavigator.pop();
      }
    }*/
  }
}
