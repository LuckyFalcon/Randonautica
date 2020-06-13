import 'dart:async';

import 'file:///E:/Randonautica/randonautica/lib/components/Randonaut/LoadingPoints.dart';
import 'package:app/components/Randonaut/ButtonGoMainPage.dart';
import 'package:app/components/Randonaut/HelpButton.dart';
import 'package:app/components/Randonaut/OpenMapsButton.dart';
import 'package:app/components/Randonaut/SetRadius.dart';
import 'package:app/components/Randonaut/SetWaterPoints.dart';
import 'package:app/components/Randonaut/StartOverButton.dart';

import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/OpenGoogleMaps.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/Attractors.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/models/map_pin_pill.dart';
import 'package:app/models/pin_pill_info.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.422, -122.084);

class Randonaut extends StatefulWidget {
  Function callback;

  Randonaut(this.callback);

  @override
  State<Randonaut> createState() => RandonautState();
}

class RandonautState extends State<Randonaut> {
  ///Buttons
  bool pointsSucesfullyGenerated = false;
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
//  PolylinePoints polylinePoints;

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
   // polylinePoints = PolylinePoints();

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
      pointsSucesfullyGenerated = false;
      _markers = {};
    });
  }

  void callbackLoadingPoints(Attractors attractors) async {
    this.pointsSucesfullyGenerated = true;
    final LatLng attractorCoordinates = new LatLng(
        attractors.points[0].center.point.latitude,
        attractors.points[0].center.point.longitude);

    ///Todo add localidentifier as optional as it doesn't pick it up somehow
    ///https://pub.dev/packages/geolocator
    var location = await Geolocator().placemarkFromCoordinates(
        attractors.points[0].center.point.latitude,
        attractors.points[0].center.point.longitude,
        localeIdentifier: "fi_FI"

        ///Locale for Local GeoLocator
        );

    //Log trips
    final fido = UnloggedTrip(
      gid: attractors.points[0].gID.toString(),
      location: location[0].administrativeArea.toString(),
      datetime: DateTime.now().toIso8601String(),
      latitude: attractorCoordinates.latitude.toString(),
      longitude: attractorCoordinates.longitude.toString(),
      radius: attractors.points[0].radiusM.toString(),
      type: attractors.points[0].type.toString(),
      power: attractors.points[0].radiusM.toString(),
      zScore: attractors.points[0].zScore.toString(),
      pseudo: 0.toString(),
      report: 0.toString(),
    );
    await insertUnloggedTrip(fido);
    setState(() {
      controller.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(attractorCoordinates.latitude, attractorCoordinates.longitude),
          10));

      //CAMERA_ZOOM = 1; //Change zoom
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(attractorCoordinates.toString()),
        position: attractorCoordinates,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      this.widget.callback();
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

    SizeConfig().init(context);

    return Column(
      children: <Widget>[
        Container(
          height: SizeConfig.blockSizeVertical * 60,

          ///This is 70% of the Vertical / Height for this container in this class
          width: SizeConfig.blockSizeHorizontal * 80,

          ///This is 80% of the Horizontal / Width for this container in this class
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical * 58,
                ///This is 70% of the Vertical / Height for this container in this class
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(width: 15, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                (pointsSucesfullyGenerated ? SizedBox(height: 0) : ButtonGoMainPage(this.callback, pointsSucesfullyGenerated))
              )
            ],
          ),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 17,
          width: SizeConfig.blockSizeHorizontal * 100,
          child: (pointsSucesfullyGenerated
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: <Widget>[
                            Image(
                              image: new AssetImage(
                                  'assets/img/navigate_round.png'),
                              color: null,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Address of Point',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  'POINT TYPE',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff5987E3)),
                                ),
                                Row(children: [
                                  //Buttons
                                  StartOverButton(this.callbackStartOver, pressStartOverButton),
                                  SizedBox(width: 20),
                                  OpenMapsButton(this.callbackOpenMaps,
                                      pressOpenMapsButton),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SetRadius(),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                    HelpButton(),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                    SetWaterPoints(),
                  ],
                )),
        ),
      ],
    );
  }

  void onAddMarkerButtonPressed() async {
     Navigator.push(context, FadeRoute(page: LoadingPoints(callbackLoadingPoints, 3000, currentLocation)));
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

      //  sourcePinInfo.location = pinPosition;

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


