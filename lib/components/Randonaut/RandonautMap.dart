///This file was used to get the RandonautMap part in here.
///However it was easier to get it to be on the page so there's no callback h

//import 'dart:async';
//import 'dart:convert';
//
//import 'dart:math';
//import 'package:achievement_view/achievement_view.dart';
//import 'package:app/models/map_pin_pill.dart';
//import 'package:app/models/pin_pill_info.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geolocator/geolocator.dart' as geo;
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';



//import 'package:location/location.dart';
//import 'package:http/http.dart' as http;
//
//
//
//const double CAMERA_ZOOM = 16;
//const double CAMERA_TILT = 0;
//const double CAMERA_BEARING = 0;
//const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
//const LatLng DEST_LOCATION = LatLng(37.422, -122.084);
//
//class RandonautMap extends StatefulWidget {
//
//  RandonautMapState myAppState=new RandonautMapState();
//
//  @override
//  State<RandonautMap> createState() => RandonautMapState();
//
//  void onAddMarkerButtonPressed() {
//    myAppState._onAddMarkerButtonPressed();
//  }
//
//}
//
//class RandonautMapState extends State<RandonautMap> {
//  LatLng pinPosition = LatLng(37.422, -122.084);
//
//  BitmapDescriptor pinLocationIcon;
//
//  //Map controller
//  Completer<GoogleMapController> _controller = Completer();
//
//  //Markers
//  Set<Marker> _markers = Set<Marker>();
//
//  // for my drawn routes on the map (Polyline)
//  Set<Polyline> _polylines = Set<Polyline>();
//  List<LatLng> polylineCoordinates = [];
//  PolylinePoints polylinePoints;
//
//  // for my custom marker pins
//  BitmapDescriptor sourceIcon;
//  BitmapDescriptor destinationIcon;
//
//  // the user's initial location and current location
//  // as it moves
//  LocationData currentLocation;
//
//  // a reference to the destination location
//  LocationData destinationLocation;
//
//  // wrapper around the location API
//  Location location;
//
//  //Attractor stuff
//  int hexsize;
//  String gid;
//
//  double pinPillPosition = -100;
//  PinInformation currentlySelectedPin = PinInformation(
//      pinPath: '',
//      avatarPath: '',
//      location: LatLng(0, 0),
//      locationName: '',
//      labelColor: Colors.grey);
//  PinInformation sourcePinInfo;
//  PinInformation destinationPinInfo;
//
//  Animation<double> animation;
//  AnimationController controllerA;
//
//  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//  MarkerId selectedMarker;
//  int _markerIdCounter = 1;
//
//  static final LatLng center = const LatLng(37.422, -122.084);
//
//  @override
//  void initState() {
//    super.initState();
//
//    // create an instance of Location
//    location = new Location();
//    polylinePoints = PolylinePoints();
//
//    // subscribe to changes in the user's location
//    // by "listening" to the location's onLocationChanged event
//    location.onLocationChanged().listen((LocationData cLoc) {
//      // cLoc contains the lat and long of the
//      // current user's position in real time,
//      // so we're holding on to it
//      currentLocation = cLoc;
//      updatePinOnMap();
//    });
//    // set custom marker pins
//    setSourceAndDestinationIcons();
//    // set the initial location
//    setInitialLocation();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    CameraPosition initialCameraPosition = CameraPosition(
//        zoom: CAMERA_ZOOM,
//        tilt: CAMERA_TILT,
//        bearing: CAMERA_BEARING,
//        target: SOURCE_LOCATION);
//    if (currentLocation != null) {
//      initialCameraPosition = CameraPosition(
//          target: LatLng(currentLocation.latitude, currentLocation.longitude),
//          zoom: CAMERA_ZOOM,
//          tilt: CAMERA_TILT,
//          bearing: CAMERA_BEARING);
//    }
//    return  Container(
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(30.0)),
//        border: Border.all(width: 15, color: Colors.white),
//        boxShadow: [
//          BoxShadow(
//            ///CAST SHADOW ON BORDER
//            color: Colors.black.withOpacity(0.2),
//            spreadRadius: 4,
//            blurRadius: 10,
//            offset: Offset(0, 6), // changes position of shadow
//          ),
//        ],
//      ),
//      child: ClipRRect(
//        borderRadius: BorderRadius.all(Radius.circular(15.0)),
//        child: Stack(
//          children: <Widget>[
//            GoogleMap(
//                myLocationEnabled: true,
//                compassEnabled: true,
//                tiltGesturesEnabled: false,
//                markers: _markers,
//                polylines: _polylines,
//                mapType: MapType.normal,
//                initialCameraPosition: initialCameraPosition,
//                onTap: (LatLng loc) {
//                  pinPillPosition = -100;
//                },
//
//                onMapCreated: (GoogleMapController controller) {
//                  //Change this to change styles
//                  // controller.setMapStyle(Utils.DarkStyle);
//                  _controller.complete(controller);
//                  //     this.widget.callback(_onAddMarkerButtonPressed());
//                  // my map has completed being created;
//                  //     _onAddMarkerButtonPressed();
//                  // i'm ready to show the pins on the map
//                  // showPinsOnMap();
//                }),
//            MapPinPillComponent(
//                pinPillPosition: pinPillPosition,
//                currentlySelectedPin: currentlySelectedPin),
//          ],
//        ),
//      ),
//      height: 500,
//      width: 500,
//    );
//  }
//
//  void _onAddMarkerButtonPressed() {
//    print("test");
////    setState(() {
//      _markers.add(Marker(
//        // This marker id can be anything that uniquely identifies each marker.
//        markerId: MarkerId(center.toString()),
//        position: LatLng(center.latitude, center.longitude),
//        infoWindow: InfoWindow(
//          title: 'Really cool place',
//          snippet: '5 Star Rating',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//      ));
////    });
//    var future = storeUnloggedTrips();
//    future.then((value) {
//      setState(() {
//        var future = fetchAttractors(
//            3000, centercoordinates.latitude, centercoordinates.longitude);
//        future.then((value) {
//          final LatLng attractorCoordinates = new LatLng(
//              value.points[0].center.point.latitude,
//              value.points[0].center.point.longitude);
//
//          //CAMERA_ZOOM = 1; //Change zoom
//          _markers.add(Marker(
//            // This marker id can be anything that uniquely identifies each marker.
//            markerId: MarkerId(attractorCoordinates.toString()),
//            position: attractorCoordinates,
//            infoWindow: InfoWindow(
//              title: 'Really cool place',
//              snippet: '5 Star Rating',
//            ),
//            icon: BitmapDescriptor.defaultMarker,
//          ));
//        });
//      });
//    });
//  }
//
//  void setSourceAndDestinationIcons() async {
//    BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
//        .then((onValue) {
//      sourceIcon = onValue;
//    });
//
//    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
//        'assets/destination_map_marker.png')
//        .then((onValue) {
//      destinationIcon = onValue;
//    });
//  }
//
//  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
//    final Marker tappedMarker = markers[markerId];
//    if (tappedMarker != null) {
//      await showDialog<void>(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//                actions: <Widget>[
//                  FlatButton(
//                    child: const Text('OK'),
//                    onPressed: () => Navigator.of(context).pop(),
//                  )
//                ],
//                content: Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 66),
//                    child: Column(
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Text('Old position: ${tappedMarker.position}'),
//                        Text('New position: $newPosition'),
//                      ],
//                    )));
//          });
//    }
//  }
//
//
//
//  void setInitialLocation() async {
//    // set the initial location by pulling the user's
//    // current location from the location's getLocation()
//    currentLocation = await location.getLocation();
//
//    // hard-coded destination for this example
//    destinationLocation = LocationData.fromMap({
//      "latitude": DEST_LOCATION.latitude,
//      "longitude": DEST_LOCATION.longitude
//    });
//  }
//
//  void _onMarkerTapped(MarkerId markerId) {
//    final Marker tappedMarker = markers[markerId];
//    if (tappedMarker != null) {
//      setState(() {
//        if (markers.containsKey(selectedMarker)) {
//          final Marker resetOld = markers[selectedMarker]
//              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
//          markers[selectedMarker] = resetOld;
//        }
//        selectedMarker = markerId;
//        final Marker newMarker = tappedMarker.copyWith(
//          iconParam: BitmapDescriptor.defaultMarkerWithHue(
//            BitmapDescriptor.hueGreen,
//          ),
//        );
//        markers[markerId] = newMarker;
//      });
//    }
//  }
//
//  void showPinsOnMap() {
//    // get a LatLng for the source location
//    // from the LocationData currentLocation object
//    var pinPosition =
//    LatLng(currentLocation.latitude, currentLocation.longitude);
//    // get a LatLng out of the LocationData object
//    var destPosition =
//    LatLng(destinationLocation.latitude, destinationLocation.longitude);
//
//    sourcePinInfo = PinInformation(
//        locationName: "Start Location",
//        location: SOURCE_LOCATION,
//        pinPath: "assets/driving_pin.png",
//        avatarPath: "assets/friend1.jpg",
//        labelColor: Colors.blueAccent);
//
//    destinationPinInfo = PinInformation(
//        locationName: "End Location",
//        location: DEST_LOCATION,
//        pinPath: "assets/destination_map_marker.png",
//        avatarPath: "assets/friend2.jpg",
//        labelColor: Colors.purple);
//
//    // add the initial source location pin
//    _markers.add(Marker(
//        markerId: MarkerId('sourcePin'),
//        position: pinPosition,
//        onTap: () {
//          setState(() {
//            currentlySelectedPin = sourcePinInfo;
//            pinPillPosition = 0;
//          });
//        },
//        icon: sourceIcon));
//    // destination pin
//    _markers.add(Marker(
//        markerId: MarkerId('destPin'),
//        position: destPosition,
//        onTap: () {
//          setState(() {
//            currentlySelectedPin = destinationPinInfo;
//            pinPillPosition = 0;
//          });
//        },
//        icon: destinationIcon));
//    // set the route lines on the map from source to destination
//    // for more info follow this tutorial
//    // setPolylines();
//  }
//
//  void updatePinOnMap() async {
//    // create a new CameraPosition instance
//    // every time the location changes, so the camera
//    // follows the pin as it moves with an animation
//    CameraPosition cPosition = CameraPosition(
//      zoom: CAMERA_ZOOM,
//      tilt: CAMERA_TILT,
//      bearing: CAMERA_BEARING,
//      target: LatLng(currentLocation.latitude, currentLocation.longitude),
//    );
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//    // do this inside the setState() so Flutter gets notified
//    // that a widget update is due
//    setState(() {
//      // updated position
//      var pinPosition =
//      LatLng(currentLocation.latitude, currentLocation.longitude);
//
//      sourcePinInfo.location = pinPosition;
//
//      // the trick is to remove the marker (by id)
//      // and add it again at the updated location
//      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
//      _markers.add(Marker(
//          markerId: MarkerId('sourcePin'),
//          onTap: () {
//            setState(() {
//              currentlySelectedPin = sourcePinInfo;
//              pinPillPosition = 0;
//            });
//          },
//          position: pinPosition, // updated position
//          icon: sourceIcon));
//    });
//  }
//
//
//}
//
