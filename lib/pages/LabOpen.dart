import 'dart:async';

import 'package:app/api/getAttractors.dart';
import 'package:app/components/Lab/ANUButton.dart';
import 'package:app/components/Lab/AnomalyButton.dart';
import 'package:app/components/Lab/AttractorButton.dart';
import 'package:app/components/Lab/CameraRNGButton.dart';
import 'package:app/components/Lab/ComScireButton.dart';
import 'package:app/components/Lab/VoidButton.dart';

import 'package:app/components/Bot/bot_webview.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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

  ///Attractor buttons
  bool pressAnomalyButton = false;
  bool pressAttractorButton = false;
  bool pressVoidButton = false;

  ///Entropy buttons
  bool pressANUButton = false;
  bool pressCameraRNGButton = false;
  bool pressComScireButton = false;

  double CAMERA_ZOOM = 16;
  CameraPosition initialCameraPosition;
  LatLng attractorPoint;

  //Map controller
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;

  //Markers
  Set<Marker> _markers = Set<Marker>();

  // for my drawn routes on the map (Polyline)
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

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

  Animation<double> animation;
  AnimationController controllerA;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  // For calling native iOS code
  static const platform = const MethodChannel('com.randonautica.app');

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      //updatePinOnMap();
    });
    // set custom marker pins
    //setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();


  }

  void callback(bool pressGoButton) {
    setState(() {
      this.pressGoButton = pressGoButton;
      onAddMarkerButtonPressed();
    });
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

  void callbackAnomalyButton(bool pressOpenMapsButton) {
    setState(() {
      this.pressAnomalyButton = true;
      this.pressAttractorButton = false;
      this.pressVoidButton = false;

    });
  }

  void callbackAttractorButton(bool pressOpenMapsButton) {
    setState(() {
      this.pressAnomalyButton = false;
      this.pressAttractorButton = true;
      this.pressVoidButton = false;
    });
  }

  void callbackVoidButton(bool pressOpenMapsButton) {
    setState(() {
      this.pressAnomalyButton = false;
      this.pressAttractorButton = false;
      this.pressVoidButton = true;
    });
  }

  void callbackANUButton(bool pressOpenMapsButton) {
    setState(() {
      this.pressANUButton = true;
      this.pressCameraRNGButton = false;
      this.pressComScireButton = false;
    });
  }

  void callbackCameraRNGButton(bool pressOpenMapsButton) {
    setState(() {
      this.pressANUButton = false;
      this.pressCameraRNGButton = true;
      this.pressComScireButton = false;
    });

    openCameraRNGAsync();
  }

  Future<void> openCameraRNGAsync() async {
    try {
      // Flutter->ios(swift) (used to load the TrueEntropy Camera RNG view controller)
      await platform.invokeMethod('goToTrueEntropy', 1000000 /* get real bytes needed somehow */);
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }

  void callbackComScireButton(bool pressOpenMapsButton) {
    setState(() {
      print('reached');
      this.pressANUButton = false;
      this.pressCameraRNGButton = false;
      this.pressComScireButton = true;
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
                        AnomalyButton(this.callbackAnomalyButton),
                        SizedBox(height: 10),
                        AttractorButton(this.callbackAttractorButton),
                        SizedBox(height: 10),
                        VoidButton(this.callbackVoidButton),
                        FlatButton(
                          child: Text('BOT', style: TextStyle(color: Colors.white, fontSize: 18)),
                          color: Color.fromARGB(255, 88, 136, 226),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BotWebView())
                            )
                          },
                        )
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
                        ANUButton(this.callbackANUButton),
                        SizedBox(height: 10),
                        CameraRNGButton(this.callbackCameraRNGButton),
                        SizedBox(height: 10),
                        ComScireButton(this.callbackComScireButton),
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


}
