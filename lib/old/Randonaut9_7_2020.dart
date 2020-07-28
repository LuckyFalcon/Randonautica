//import 'dart:async';
//import 'dart:ui' as ui;
//
//import 'package:app/components/Lab/AnomalyButton.dart';
//import 'package:app/components/Lab/AttractorButton.dart';
//import 'package:app/components/Lab/ButtonGoMainPage.dart';
//import 'package:app/components/Lab/VoidButton.dart';
//import 'package:app/components/Randonaut/ButtonGoMainPage.dart';
//import 'package:app/components/Randonaut/HelpButton.dart';
//import 'package:app/components/Randonaut/LoadingPoints.dart';
//import 'package:app/components/Randonaut/OpenMapsButton.dart';
//import 'package:app/components/Randonaut/PointsButtons.dart';
//import 'package:app/components/Randonaut/SetRandomness.dart';
//import 'package:app/components/Randonaut/SetRadius.dart';
//import 'package:app/components/Randonaut/SetWaterPoints.dart';
//import 'package:app/components/Randonaut/StartOverButton.dart';
//import 'package:app/helpers/AppLocalizations.dart';
//import 'package:app/helpers/FadeRoute.dart';
//import 'package:app/helpers/OpenGoogleMaps.dart';
//import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
//import 'package:app/models/Attractors.dart';
//import 'package:app/models/UnloggedTrip.dart';
//import 'package:app/models/map_pin_pill.dart';
//import 'package:app/models/pin_pill_info.dart';
//import 'package:app/utils/size_config.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
//
//const double CAMERA_TILT = 0;
//const double CAMERA_BEARING = 0;
//const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
//const LatLng DEST_LOCATION = LatLng(37.422, -122.084);
//
//class Randonaut extends StatefulWidget {
//  Function callback;
//  int index;
//
//  Randonaut(this.callback, this.index);
//
//  @override
//  State<Randonaut> createState() => RandonautState();
//}
//
//class RandonautState extends State<Randonaut> {
//  /// 0 = Point, 1 = Anomaly, 2 = Attractor, 3 = Void
//
//  ///Go Buttons
//  bool pressGoButtonMain = false;
//  bool pressGoButtonLab = false;
//
//  ///Button for setting state after generation
//  bool pointsSucesfullyGenerated = false;
//
//  ///Buttons for navigation
//  bool pressOpenMapsButton = false;
//  bool pressStartOverButton = false;
//
//  ///Attractor buttons
//  bool pressAnomalyButton = false;
//  bool pressAttractorButton = false;
//  bool pressVoidButton = false;
//
//  /// Attractor stuff neeeded
//  int selectedPoint = 0; //0 = Point, 1 = Anomaly, 2 = Attractor, 3 = Void
//  int radius = 3000; //Radius in meters. Miles or Kilometers * 1000, Standard radius is always 3000 meters
//  bool checkWater = false; //True = on, false = off. Standard checkWater is always false.
//
//  ///Attractor points
//  LatLng attractorCoordinates;
//
//  ///Camera settings
//  double CAMERA_ZOOM = 16;
//  CameraPosition initialCameraPosition;
//
//  ///Pin on map image
//  BitmapDescriptor pinLocationIcon;
//
//  ///Map controller
//  Completer<GoogleMapController> _controller = Completer();
//  GoogleMapController controller;
//
//  ///Markers
//  Set<Marker> _markers = Set<Marker>();
//
//  /// For my drawn routes on the map (Polyline)
//  Set<Polyline> _polylines = Set<Polyline>();
//  List<LatLng> polylineCoordinates = [];
//
//  /// For my custom marker pins
//  BitmapDescriptor sourceIcon;
//  BitmapDescriptor destinationIcon;
//
//  /// The user's initial location and current location
//  /// As it moves
//  LocationData currentLocation;
//
//  /// A reference to the destination location
//  LocationData destinationLocation;
//
//  /// Wrapper around the location API
//  Location location;
//
//  double pinPillPosition = -100;
//
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
//  void callbackGoButtonMainPage(bool pressGoButton) {
//    //controller.setMapStyle(MapStyles.DarkStyle);
//    setState(() {
//      onAddMarkerButtonPressed();
//    });
//  }
//
//  void setRadiusCallback(int setRadius) {
//    //controller.setMapStyle(MapStyles.DarkStyle);
//    setState(() {
//        radius = setRadius;
//    });
//  }
//
//  void setCheckWaterCallback(bool setCheckWater) {
//    //controller.setMapStyle(MapStyles.DarkStyle);
//    setState(() {
//      checkWater = setCheckWater;
//    });
//  }
//
//  void callbackGoButtonLab(bool pressGoLabButton) {
//    //controller.setMapStyle(MapStyles.DarkStyle);
//    pressGoButtonLab = true;
//    setState(() {
//      onAddMarkerButtonPressed();
//    });
//  }
//
//  void callbackOpenMaps(bool pressOpenMapsButton) {
//    setState(() {
//      this.pressOpenMapsButton = pressOpenMapsButton;
//      MapUtils.openMap(
//          attractorCoordinates.latitude, attractorCoordinates.longitude);
//    });
//  }
//
//  void callbackStartOver(bool pressStartOverButton) {
//    setState(() {
//      this.pressStartOverButton = pressOpenMapsButton;
//      pointsSucesfullyGenerated = false;
//      _markers = {};
//    });
//  }
//
//  void pointsGeneratedCallback(bool pointsSuccesfullyGenerated) {
//    this.pointsSucesfullyGenerated = pointsSuccesfullyGenerated;
//  }
//
//  void callbackSelectedPoint(int currentSelectedPoint) {
//    setState(() {
//      selectedPoint = currentSelectedPoint;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//
//    // create an instance of Location
//    location = new Location();
//    // polylinePoints = PolylinePoints();
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
//    initialCameraPosition = CameraPosition(
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
//
//    SizeConfig().init(context);
//    return Column(
//      children: <Widget>[
//        Container(
//          ///This is 70% of the Vertical / Height for this container in this class
//          height: SizeConfig.blockSizeVertical * 55,
//
//          ///This is 80% of the Horizontal / Width for this container in this class
//          width: SizeConfig.blockSizeHorizontal * 80,
//          child: Stack(
//            children: <Widget>[
//              Container(
//                ///This is 52% of the Vertical / Height for this container in this class
//                height: SizeConfig.blockSizeVertical * 52,
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.all(Radius.circular(45.0)),
//                  border: Border.all(width: 15, color: Colors.white),
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black.withOpacity(0.2),
//                      spreadRadius: 4,
//                      blurRadius: 10,
//                      offset: Offset(0, 6), // changes position of shadow
//                    ),
//                  ],
//                ),
//                child: ClipRRect(
//                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                  child: Stack(
//                    children: <Widget>[
//                      GoogleMap(
//                          mapToolbarEnabled: false,
//                          myLocationEnabled: true,
//                          compassEnabled: true,
//                          tiltGesturesEnabled: false,
//                          markers: _markers,
//                          polylines: _polylines,
//                          mapType: MapType.normal,
//                          initialCameraPosition: initialCameraPosition,
//                          onTap: (LatLng loc) {
//                            pinPillPosition = -100;
//                          },
//                          onMapCreated: (GoogleMapController controller) {
//                            //Change this to change styles
//                            // controller.setMapStyle(Utils.DarkStyle);
//                            _controller.complete(controller);
//                          }),
//                      MapPinPillComponent(
//                          pinPillPosition: pinPillPosition,
//                          currentlySelectedPin: currentlySelectedPin),
//                    ],
//                  ),
//                ),
//              ),
//              Align(
//                  alignment: Alignment.bottomCenter,
//                  child: (pointsSucesfullyGenerated
//                      ? SizedBox(height: 0)
//                      : (this.widget.index == 0
//                          ? ButtonGoMainPage(this.callbackGoButtonMainPage,
//                              pointsSucesfullyGenerated)
//                          : ButtonGoLab(this.callbackGoButtonLab,
//                              pointsSucesfullyGenerated))))
//            ],
//          ),
//        ),
//        SizedBox(height: SizeConfig.blockSizeVertical * 2),
////        Container(
////          height: SizeConfig.blockSizeVertical * 15,
////          width: SizeConfig.blockSizeHorizontal * 100,
////          child: (pointsSucesfullyGenerated
////              ? Row(
////                  mainAxisAlignment: MainAxisAlignment.center,
////                  children: [
////                    Row(
////                      children: <Widget>[
////                        Align(
////                          alignment: Alignment.topRight,
////                          child: Image(
////                            image:
////                                new AssetImage('assets/img/navigate_round.png'),
////                            alignment: Alignment.topCenter,
////                          ),
////                        ),
////                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
////                        Column(
////                          crossAxisAlignment: CrossAxisAlignment.start,
////                          children: <Widget>[
////                            Text(
////                              'Address of Point',
////                              textAlign: TextAlign.left,
////                              overflow: TextOverflow.ellipsis,
////                              style: TextStyle(
////                                  fontWeight: FontWeight.bold,
////                                  color: Colors.white),
////                            ),
////                            Text(
////                              'POINT TYPE',
////                              textAlign: TextAlign.left,
////                              overflow: TextOverflow.ellipsis,
////                              style: TextStyle(
////                                  fontWeight: FontWeight.bold,
////                                  color: Color(0xff5987E3)),
////                            ),
////                            Row(children: [
////                              //Buttons
////                              StartOverButton(
////                                  this.callbackStartOver, pressStartOverButton),
////                              SizedBox(
////                                  width: SizeConfig.blockSizeHorizontal * 5),
////                              OpenMapsButton(
////                                  this.callbackOpenMaps, pressOpenMapsButton),
////                            ]),
////                          ],
////                        ),
////                      ],
////                    ),
////                  ],
////                )
////              : Row(
////                  crossAxisAlignment: CrossAxisAlignment.center,
////                  mainAxisAlignment: MainAxisAlignment.center,
////                  children: [
////                    SetRadius(),
////                    (this.widget.index == 0
////                        ? SizedBox(width: SizeConfig.blockSizeHorizontal * 6.8)
////                        : SizedBox(width: SizeConfig.blockSizeHorizontal * 1)),
////                    //,
////                    (this.widget.index == 0
////                        ? HelpButton()
////                        : (pressGoButtonLab
////                            ? Column(
////                                children: [
////                                  AnomalyButton(this.callbackAnomalyButton),
////                                  SizedBox(height: 7),
////                                  AttractorButton(this.callbackAttractorButton),
////                                  SizedBox(height: 7),
////                                  VoidButton(this.callbackVoidButton),
////                                ],
////                              )
////                            : Column(
////                                children: [
////                                  AnomalyButton(this.callbackAnomalyButton),
////                                  SizedBox(height: 7),
////                                  AttractorButton(this.callbackAttractorButton),
////                                  SizedBox(height: 7),
////                                  VoidButton(this.callbackVoidButton),
////                                ],
////                              ))),
////                    (this.widget.index == 0
////                        ? SizedBox(width: SizeConfig.blockSizeHorizontal * 6.7)
////                        : SizedBox(width: SizeConfig.blockSizeHorizontal * 1)),
////                    SetWaterPoints(),
////                  ],
////                )),
////        )
//        Container(
//          height: SizeConfig.blockSizeVertical * 20,
//          width: SizeConfig.blockSizeHorizontal * 100,
//          child: (pointsSucesfullyGenerated
//              ? Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Row(
//                      children: <Widget>[
//                        Align(
//                          alignment: Alignment.topRight,
//                          child: Image(
//                            image:
//                                new AssetImage('assets/img/navigate_round.png'),
//                            alignment: Alignment.topCenter,
//                          ),
//                        ),
//                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              'Address of Point',
//                              textAlign: TextAlign.left,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.white),
//                            ),
//                            Text(
//                              'POINT TYPE',
//                              textAlign: TextAlign.left,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Color(0xff5987E3)),
//                            ),
//                            Row(children: [
//                              //Buttons
//                              StartOverButton(
//                                  this.callbackStartOver, pressStartOverButton),
//                              SizedBox(
//                                  width: SizeConfig.blockSizeHorizontal * 5),
//                              OpenMapsButton(
//                                  this.callbackOpenMaps, pressOpenMapsButton),
//                            ]),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ],
//                )
//              : Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    SizedBox(width: 20),
//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SetRadius(this.setRadiusCallback),
//                        SizedBox(height: 10),
//                        SetPower(),
//                      ],
//                    ),
//                    SizedBox(width: 20),
//                    HelpButton(),
//                    SizedBox(width: 30),
//                    Column(
//                      children: <Widget>[
//                        SetWaterPoints(this.setCheckWaterCallback),
//                        PointsButtons(this.callbackSelectedPoint)
//                      ],
//                    ),
//                  ],
//                )),
//        )
//      ],
//    );
//  }
//
//  void onAddMarkerButtonPressed() async {
//    Navigator.push(
//        context,
//        FadeRoute(
//            page: LoadingPoints(
//                callbackLoadingPoints, radius, currentLocation, selectedPoint, checkWater)));
//  }
//
//  void callbackLoadingPoints(Attractors attractors) async {
//    this.pointsSucesfullyGenerated = true;
//    attractorCoordinates = new LatLng(
//        attractors.center.point.latitude, attractors.center.point.longitude);
//
//    ///Todo add localidentifier as optional as it doesn't pick it up somehow
//    ///https://pub.dev/packages/geolocator
//    var location = await Geolocator().placemarkFromCoordinates(
//      attractors.center.point.latitude,
//      attractors.center.point.longitude,
//
//      ///Locale for Local GeoLocator
//      //  localeIdentifier: "fi_FI"
//    );
//
//    //Log trips
//    final fido = UnloggedTrip(
//      is_visited: 0,
//      is_logged: 0,
//      is_favorite: 0,
//      rng_type: 0,
//      point_type: 0,
//      title: null,
//      report: 0.toString(),
//      what_3_words_address: null,
//      what_3_nearest_place: null,
//      what_3_words_country: null,
//      center: attractors.gID.toString(),
//      latitude: attractors.gID.toString(),
//      longitude: attractors.gID.toString(),
//      location: location[0].administrativeArea.toString(),
//      gid: attractors.gID.toString(),
//      tid: attractors.gID.toString(),
//      lid: attractors.gID.toString(),
//      type: attractors.gID.toString(),
//      x: attractors.gID.toString(),
//      y: attractors.gID.toString(),
//      distance: attractors.gID.toString(),
//      initial_bearing: attractors.gID.toString(),
//      final_bearing: attractors.gID.toString(),
//      side: attractors.gID.toString(),
//      distance_err: attractors.gID.toString(),
//      radiusM: attractors.gID.toString(),
//      number_points: attractors.gID.toString(),
//      mean: attractors.gID.toString(),
//      rarity: attractors.gID.toString(),
//      power_old: attractors.gID.toString(),
//      power: attractors.gID.toString(),
//      z_score: attractors.gID.toString(),
//      probability_single: attractors.gID.toString(),
//      integral_score: attractors.gID.toString(),
//      significance: attractors.gID.toString(),
//      probability: attractors.gID.toString(),
//      created: DateTime.now().toIso8601String(),
//    );
//
//    await insertUnloggedTrip(fido);
//
//    setState(() {
//      controller.moveCamera(CameraUpdate.newLatLngZoom(
//          LatLng(attractorCoordinates.latitude, attractorCoordinates.longitude),
//          10));
//
//      //CAMERA_ZOOM = 1; //Change zoom
//      _markers.add(Marker(
//        // This marker id can be anything that uniquely identifies each marker.
//        markerId: MarkerId(attractorCoordinates.toString()),
//        position: attractorCoordinates,
//        infoWindow: InfoWindow(
//          title: 'Really cool place',
//          snippet: '5 Star Rating',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//      ));
//
//      this.widget.callback();
//    });
//
//
//  }
//
//  void setSourceAndDestinationIcons() async {
//    BitmapDescriptor.fromAssetImage(
//            ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
//        .then((onValue) {
//      sourceIcon = onValue;
//    });
//
//    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
//            'assets/destination_map_marker.png')
//        .then((onValue) {
//      destinationIcon = onValue;
//    });
//  }
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
//
//    CameraPosition cPosition = CameraPosition(
//      zoom: CAMERA_ZOOM,
//      tilt: CAMERA_TILT,
//      bearing: CAMERA_BEARING,
//      target: LatLng(currentLocation.latitude, currentLocation.longitude),
//    );
//    controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//  }
//
//  void showPinsOnMap() {
//    // get a LatLng for the source location
//    // from the LocationData currentLocation object
//    var pinPosition =
//        LatLng(currentLocation.latitude, currentLocation.longitude);
//    // get a LatLng out of the LocationData object
//    var destPosition =
//        LatLng(destinationLocation.latitude, destinationLocation.longitude);
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
//
//    // do this inside the setState() so Flutter gets notified
//    // that a widget update is due
//    setState(() {
//      // updated position
//      var pinPosition =
//          LatLng(currentLocation.latitude, currentLocation.longitude);
//
//      //  sourcePinInfo.location = pinPosition;
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
//}
