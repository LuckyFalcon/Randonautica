import 'dart:async';

import 'package:app/api/getAttractors.dart';

import 'package:app/components/Randonaut/ButtonGoMainPage.dart';
import 'package:app/components/Randonaut/ButtonsRowMainPage.dart';
import 'package:app/components/Randonaut/OpenMapsButton.dart';
import 'package:app/components/Randonaut/StartOverButton.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/helpers/OpenGoogleMaps.dart';

import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/models/map_pin_pill.dart';
import 'package:app/models/pin_pill_info.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';


const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.422, -122.084);

class LabOpen extends StatefulWidget {
  @override
  State<LabOpen> createState() => LabOpenState();
}

class LabOpenState extends State<LabOpen> {
  ///Buttons
  bool pressGoButton = false;
  bool pressOpenMapsButton = false;
  bool pressStartOverButton = false;

  double CAMERA_ZOOM = 16;
  CameraPosition initialCameraPosition;
  ///Attractor points
  LatLng attractorPoint;

  BitmapDescriptor pinLocationIcon;

  //Map controller
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;

  //Markers
  Set<Marker> _markers = Set<Marker>();

  // for my drawn routes on the map (Polyline)
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

  // for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;

  // a reference to the destination location
  LocationData destinationLocation;

  // wrapper around the location API
  Location location;

  //Attractor stuff
  int hexsize;
  String gid;

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;

  Animation<double> animation;
  AnimationController controllerA;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();


  }

  void callback(bool pressGoButton) {
    setState(() {
      this.pressGoButton = pressGoButton;
      onAddMarkerButtonPressed();

      ///This is called when Go Button is pressed.
      print('test');


    });
  }

//
  void dialog(){
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.show();
    pr.update(
      progress: 50.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  void callbackOpenMaps(bool pressOpenMapsButton) {
    setState(() {
      this.pressOpenMapsButton = pressOpenMapsButton;
      MapUtils.openMap(attractorPoint.latitude, attractorPoint.longitude);

    });
  }

  void callbackStartOver(bool pressStartOverButton) {
    setState(() {
      this.pressStartOverButton = pressOpenMapsButton;



    });
  }

  @override
  Widget build(BuildContext context) {
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
    return Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 410,
                    width: 300,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(width: 15, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                ///CAST SHADOW ON BORDER
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: Offset(0, 6), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            child: Stack(
                              children: <Widget>[
                                GoogleMap(
                                    mapToolbarEnabled: false,
                                    myLocationEnabled: true,
                                    compassEnabled: true,
                                    tiltGesturesEnabled: false,
                                    markers: _markers,
                                    polylines: _polylines,
                                    mapType: MapType.normal,
                                    initialCameraPosition: initialCameraPosition,
                                    onTap: (LatLng loc) {
                                      pinPillPosition = -100;
                                    },
                                    onMapCreated: (GoogleMapController controller) {
                                      //Change this to change styles
                                      // controller.setMapStyle(Utils.DarkStyle);
                                      _controller.complete(controller);
                                    }),
                                MapPinPillComponent(
                                    pinPillPosition: pinPillPosition,
                                    currentlySelectedPin: currentlySelectedPin),
                              ],
                            ),
                          ),
                          height: 500,
                          width: 500,
                        ),
                        ButtonGoMainPage(this.callback, pressGoButton),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                (pressGoButton //TODO MOVE TO ButtonGoMainPage
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: new AssetImage('assets/img/navigate_round.png'),
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address of Point',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'POINT TYPE',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(children: [
                          //Buttons
                          ButtonsRowMainPage('see_route'),
                          OpenMapsButton(this.callbackOpenMaps, pressOpenMapsButton),
                        ]),
                        Row(children: [
                          //Buttons
                          StartOverButton(this.callbackStartOver, pressStartOverButton),
                        ]),
                      ],
                    ),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ButtonsRowMainPage('anomaly'),
                        SizedBox(height: 7),
                        ButtonsRowMainPage('attractor'),
                        SizedBox(height: 7),
                        ButtonsRowMainPage('void'),
                      ],
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          Text(
                            'Radius',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          Text(
                            '20',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white
                            ),
                          ),
                          Text(
                            'MILES',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ButtonsRowMainPage('1_point'),
                        SizedBox(height: 10),
                        ButtonsRowMainPage('2_point'),
                        SizedBox(height: 10),
                        ButtonsRowMainPage('3_point'),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          );
  }

  void onAddMarkerButtonPressed() {


  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destination_map_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void setInitialLocation() async {

    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });

    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
    LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
    LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = destinationPinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    // setPolylines();
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation


    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
      LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

  addPulsatingEffect(LatLng userLatlng, int radius) {

    int colorOutline = Colors.red.red;
    int colorInner = 0x22FF0000;

    final int finalColorOutline = colorOutline;
    final int finalColorInner = colorInner;
//    var controller =
//        AnimationController(duration: const Duration(seconds: 2), vsync: this);
//    lastPulseAnimator = valueAnimate(getDisplayPulseRadius(radius, map), RandonautFragment.pulseDuration, new ValueAnimator.AnimatorUpdateListener() {
//    @Override
//    public void onAnimationUpdate(ValueAnimator animation) {
//    if (RandonautFragment.lastUserCircle != null)
//    RandonautFragment.lastUserCircle.setRadius((Float) animation.getAnimatedValue());
//    else {
//    RandonautFragment.lastUserCircle = map.addCircle(new CircleOptions()
//        .center(userLatlng)
//        .radius(getDisplayPulseRadius((Float) animation.getAnimatedValue(), map))
//        .strokeColor(finalColorOutline));
//    //.fillColor(Color.BLUE));
//    RandonautFragment.lastUserCircle.setFillColor(adjustAlpha(finalColorInner, 1 - animation.getAnimatedFraction()));
//
//
//    }
//    }
//    });

  }

  adjustAlpha(int color, var factor) {
    int alpha = (Color.getAlphaFromOpacity(color * factor)).round();
    int red = Colors.red.red;
    int green = Colors.green.green;
    int blue = Colors.blue.blue;
    return Color.fromARGB(alpha, red, green, blue);
  }




}