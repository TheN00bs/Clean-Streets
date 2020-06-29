import 'dart:async';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/shared-data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviewScreen extends StatefulWidget {
  static const String id = 'preview_screen';
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    LatLng _current = LatLng(
        double.parse(SharedData.selectedRequest['latitude']),
        double.parse(SharedData.selectedRequest['longitude']));
    MarkerId currentMarkerId = MarkerId("currentMarkerId");
    Marker current = Marker(position: _current, markerId: currentMarkerId);
    markers[currentMarkerId] = current;

    Uint8List bytes = convert.base64Decode(SharedData.selectedRequest['img']);
    var timestamp = new DateTime.fromMillisecondsSinceEpoch(
            SharedData.selectedRequest['timestamp'] * 1000)
        .toLocal();

    String formattedDate = DateFormat('dd-MM-yyyy, hh:mm a').format(timestamp);

    List<Widget> stackChilden = [
      ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: screenHeight,
            minHeight: screenHeight,
            minWidth: screenWidth,
            maxWidth: screenWidth),
        child: FittedBox(
          child: Image.memory(bytes),
          fit: BoxFit.cover,
        ),
      ),
      DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView(
                controller: scrollController,
                children: [
                  Chip(
                    label: Text(
                      'Current status: ' + SharedData.selectedRequest['status'],
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: screenHeight * 2 / 7,
                        minHeight: screenHeight * 2 / 7,
                        minWidth: screenWidth,
                        maxWidth: screenWidth),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(markers.values),
                      initialCameraPosition:
                          CameraPosition(target: _current, zoom: 15.0),
                    ),
                  ),
                  Chip(
                    label: Text(formattedDate),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(SharedData.selectedRequest['title']),
      ),
      body: Stack(children: stackChilden),
    );
  }
}

/*

DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  child: Text('Working!'),
                );
              },
            ),

*/

/*
SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenHeight * 2 / 7,
                  minHeight: screenHeight * 2 / 7,
                  minWidth: screenWidth,
                  maxWidth: screenWidth),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values),
                initialCameraPosition:
                    CameraPosition(target: _current, zoom: 15.0),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenHeight * 2 / 5,
                  minHeight: screenHeight * 2 / 5,
                  minWidth: screenWidth,
                  maxWidth: screenWidth),
              child: FittedBox(
                child: Image.memory(bytes),
                fit: BoxFit.cover,
              ),
            ),
            Text(SharedData.selectedRequest['status']),
          ],
        ),
      ),

*/
