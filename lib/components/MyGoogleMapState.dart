import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.422, -122.084);

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap(MyGoogleMapState currentState, {Key key}) : super(key: key);  // NEW CONSTRUCTOR

  @override
  State<MyGoogleMap> createState() => MyGoogleMapState();
}

class MyGoogleMapState extends State<MyGoogleMap> with AutomaticKeepAliveClientMixin {

  double CAMERA_ZOOM = 16;
  CameraPosition initialCameraPosition;

  //Map controller
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;

  //Markers
  Set<Marker> _markers = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();

  // the user's initial location and current location
  LocationData currentLocation;

  GoogleMap _map;
  @override
  void initState() {
    super.initState();
    print('initstatebbb444');
  }
  @override
  Widget build(BuildContext context) {
    print('initstatebbb');
    if (_map == null){

      initialCameraPosition = CameraPosition(
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING,
          target: SOURCE_LOCATION);
      if (currentLocation != null) {
        initialCameraPosition = CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING);
      }

      _map =  GoogleMap(
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            //Change this to change styles
            // controller.setMapStyle(Utils.DarkStyle);
            _controller.complete(controller);
          });
    }
    return  Container(
        height: 400,
        child:  _map
    );
  }
  @override
  bool get wantKeepAlive => true;


}