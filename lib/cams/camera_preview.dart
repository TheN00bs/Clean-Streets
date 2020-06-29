import 'dart:async';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';

import '../models/shared-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CameraPreviewPage extends StatefulWidget {
  final Function() notifyParent;
  CameraPreviewPage({@required this.notifyParent});
  @override
  _CameraPreviewPageState createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  TextEditingController titleController = new TextEditingController();
  Position position;

  getLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    getLocation();

    if (SharedData.cameraImage == null) {
      return Center(
        child: Text('No image Selected'),
      );
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: () => launchScrollSheet(context),
          tooltip: "Location Tag",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: screenHeight*2/5,
                    minHeight: screenHeight*2/5,
                    minWidth: screenWidth,
                    maxWidth: screenWidth),
                child: FittedBox(
                  child: Image.file(
                    File(SharedData.cameraImage),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: OutlineButton(
                      highlightedBorderColor: Colors.grey,
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () async {
                        await SharedData.sendData(
                          SharedData.email,
                          titleController.text,
                          File(SharedData.cameraImage),
                        );
                        setState(() {
                          SharedData.currentIndexPage = 0;
                        });
                        widget.notifyParent();
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  launchScrollSheet(context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    Completer<GoogleMapController> _controller = Completer();

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    LatLng _current = LatLng(position.latitude, position.longitude);
    MarkerId currentMarkerId = MarkerId("currentMarkerId");
    Marker current = Marker(position: _current, markerId: currentMarkerId);
    markers[currentMarkerId] = current;

    showModalBottomSheet(
        enableDrag: false,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: new Wrap(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 2 / 5,
                  minHeight: MediaQuery.of(context).size.height * 2 / 5,
                  minWidth: MediaQuery.of(context).size.width,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: Set<Marker>.of(markers.values),
                  initialCameraPosition:
                      CameraPosition(target: _current, zoom: 15.0),
                ),
              )
            ],
          ));
        });
  }

  // Future<ByteData> getBytesFromFile() async {
  //   Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
  //   return ByteData.view(bytes.buffer);
  // }
}
