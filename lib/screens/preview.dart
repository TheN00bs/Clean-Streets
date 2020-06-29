import 'dart:async';
import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/shared-data.dart';
import 'package:flutter/material.dart';

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

    LatLng _current = LatLng(double.parse(SharedData.selectedRequest['latitude']), double.parse(SharedData.selectedRequest['longitude']));
    MarkerId currentMarkerId = MarkerId("currentMarkerId");
    Marker current = Marker(position: _current, markerId: currentMarkerId);
    markers[currentMarkerId] = current;

    Uint8List bytes = convert.base64Decode(SharedData.selectedRequest['img']);
    return Scaffold(
      appBar: AppBar(
        title: Text(SharedData.selectedRequest['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: screenHeight*2/5,
                    minHeight: screenHeight*2/5,
                    minWidth: screenWidth,
                    maxWidth: screenWidth),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition: CameraPosition(
                    target: _current,
                    zoom: 15.0
                  ),
                ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenHeight*2/5,
                  minHeight: screenHeight*2/5,
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
    );
  }
}
