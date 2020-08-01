import 'dart:async';

import 'package:app/api/signInStreak.dart';
import 'package:app/components/Randonaut/ButtonGoMainPage.dart';
import 'package:app/components/Randonaut/HelpButton.dart';
import 'package:app/components/Randonaut/OpenMapsButton.dart';
import 'package:app/components/Randonaut/PointsButtons.dart';
import 'package:app/components/Randonaut/SetRadius.dart';
import 'package:app/components/Randonaut/SetRandomness.dart';
import 'package:app/components/Randonaut/SetWaterPoints.dart';
import 'package:app/components/Randonaut/ShareLocationButton.dart';
import 'package:app/components/Randonaut/StartOverButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/OpenGoogleMaps.dart';
import 'package:app/models/Attractors.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/models/pin_pill_info.dart';
import 'package:app/pages/Token/TokenInfo.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/target_position.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../storage/unloggedTripsDatabase.dart';

import 'LoadingPoints.dart';

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
  /*
    Random point = 1 token
    Quantum random point = 2 token
    Anomaly/Attractor/Void = 3 token
    Amplification bias = 5 token
  */
  final int RandomPointCost = 1;
  final int QuantumPointCost = 2;
  final int AmplificationBiasPointCost = 5;

  ///Go Buttons
  bool pressGoButtonMain = false;
  bool pressGoButtonLab = false;

  ///Button for setting state after generation
  bool pointsSucesfullyGenerated = false;

  ///Buttons for navigation
  bool pressOpenMapsButton = false;
  bool pressStartOverButton = false;

  /// Attractor stuff neeeded
  int selectedPoint =
      1; //1 = Anomaly, 2 = Attractor, 3 = Void. Anomaly is selected as standard
  int selectedRandomness =
      1; //1 = Random, 2 = Quantum, 3 = Bias. Random is selected as standard
  int radius =
      3000; //Radius in meters. Miles or Kilometers * 1000, Standard radius is always 3000 meters
  bool checkWater =
      false; //True = on, false = off. Standard checkWater is always false.

  ///Attractor points
  LatLng attractorCoordinates;

  ///Tutorial targets list
  List<TargetFocus> targets = List();

  ///Camera settings
  double CAMERA_ZOOM = 16;
  CameraPosition initialCameraPosition;

  ///Pin on map image
  BitmapDescriptor pinLocationIcon;

  ///Map controller
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;

  ///Markers
  Set<Marker> _markers = Set<Marker>();

  ///Markers
  Set<Circle> _circles = Set<Circle>();

  /// For my drawn routes on the map (Polyline)
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

  /// For my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  /// The user's initial location and current location
  /// As it moves
  LocationData currentLocation;

  /// A reference to the destination location
  LocationData destinationLocation;

  /// Wrapper around the location API
  Location location;

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

  void callbackGoButtonMainPage(bool pressGoButton) {
    //controller.setMapStyle(MapStyles.DarkStyle);
    setState(() {
      onAddMarkerButtonPressed();
    });
  }

  void callbackhelp() {
    //controller.setMapStyle(MapStyles.DarkStyle);
    setState(() {
      showTutorial();
    });
  }

  void setRadiusCallback(int setRadius) {
    //controller.setMapStyle(MapStyles.DarkStyle);
    setState(() {
      radius = setRadius;
    });
  }

  void setCheckWaterCallback(bool setCheckWater) {
    //controller.setMapStyle(MapStyles.DarkStyle);
    setState(() {
      checkWater = setCheckWater;
    });
  }

  void callbackOpenMaps(bool pressOpenMapsButton) {
    setState(() {
      this.pressOpenMapsButton = pressOpenMapsButton;
      MapUtils.openMap(
          attractorCoordinates.latitude, attractorCoordinates.longitude);
    });
  }

  void callbackStartOver(bool pressStartOverButton) {
    setState(() {
      this.pressStartOverButton = pressOpenMapsButton;
      pointsSucesfullyGenerated = false;
      _markers = {};
      _polylines = {};
    });
  }

  void callbackShareLocation(bool pressStartOverButton) {
    //Render share function
    final RenderBox box = context.findRenderObject();

    final String shareSubject =
        AppLocalizations.of(context).translate('share_subject');

    setState(() {
      String googleUrl = "https://www.google.com/maps/place/" +
          attractorCoordinates.latitude.toString() +
          "+" +
          attractorCoordinates.longitude.toString() +
          "/@" +
          attractorCoordinates.latitude.toString() +
          "+" +
          attractorCoordinates.longitude.toString() +
          ",14z&zoom=14&mapmode=standard";
      Share.share(
        googleUrl,
        subject: shareSubject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      ).whenComplete(() => {print('successcomplete')});
    });
  }

  void pointsGeneratedCallback(bool pointsSuccesfullyGenerated) {
    this.pointsSucesfullyGenerated = pointsSuccesfullyGenerated;
  }

  void callbackSelectedPoint(int currentSelectedPoint) {
    setState(() {
      selectedPoint = currentSelectedPoint;
    });
  }

  void callbackselectedRandomness(int currentSelectedRandomness) {
    setState(() {
      selectedRandomness = currentSelectedRandomness;
      print(selectedRandomness);
    });
  }

  void initTargets() {
    targets.add(TargetFocus(
      identify: "Owl Tokens",
      targetPosition: TargetPosition(
          Size(SizeConfig.blockSizeHorizontal * 23,
              SizeConfig.blockSizeVertical * 5),
          Offset(SizeConfig.blockSizeHorizontal * 6,
              SizeConfig.blockSizeVertical * 2)),
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Owl Tokens",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Your Owl Tokens, you can use these to generate points!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      targetPosition: TargetPosition(
          Size(SizeConfig.blockSizeHorizontal * 10,
              SizeConfig.blockSizeVertical * 5),
          Offset(SizeConfig.blockSizeHorizontal * 85,
              SizeConfig.blockSizeVertical * 2)),
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Shop",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Get yourself some upgrades in the store!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      targetPosition: TargetPosition(
          Size(SizeConfig.blockSizeHorizontal * 30,
              SizeConfig.blockSizeVertical * 10),
          Offset(SizeConfig.blockSizeHorizontal * 36,
              SizeConfig.blockSizeVertical * 54)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Go",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Press the GO button to start your search!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 4",
      targetPosition: TargetPosition(
          Size(SizeConfig.blockSizeHorizontal * 23,
              SizeConfig.blockSizeVertical * 10),
          Offset(SizeConfig.blockSizeHorizontal * 12,
              SizeConfig.blockSizeVertical * 65)),
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Set Your Radius",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Press left to decrease your radius or right to increase your radius",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
//    targets.add(TargetFocus(
//      identify: "Target 5",
//      keyTarget: keyButton2,
//      contents: [
//        ContentTarget(
//            align: AlignContent.top,
//            child: Container(
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(bottom: 20.0),
//                    child: Text(
//                      "Multiples contents",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold,
//                          fontSize: 20.0),
//                    ),
//                  ),
//                  Text(
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ],
//              ),
//            )),
//        ContentTarget(
//            align: AlignContent.bottom,
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(bottom: 20.0),
//                  child: Text(
//                    "Multiples contents",
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20.0),
//                  ),
//                ),
//                Container(
//                  child: Text(
//                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ),
//              ],
//            ))
//      ],
//      shape: ShapeLightFocus.Circle,
//    ));
  }

  void showTutorial() {
    //findingPointFailedDialog(context);
    //gpsDisabledDialog(context);
  // notEnoughTokensDialog(context);
    randonauticaStreakDialog(context, globals.currentUser.currentSignedInStreak);
    signInStreak();
//    TutorialCoachMark(context,
//        targets: targets,
//        colorShadow: Colors.blue,
//        textSkip: "SKIP",
//        paddingFocus: 10,
//        opacityShadow: 0.8, finish: () {
//      print("finish");
//    }, clickTarget: (target) {
//      print(target);
//    }, clickSkip: () {
//      print("skip");
//    })
//      ..show();
  }

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    // set the initial location
    setInitialLocation();

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

    //Initialize targets for Coach Mark (Tutorial)
    initTargets();

    return Column(
      children: <Widget>[
        Container(
          ///This is 70% of the Vertical / Height for this container in this class
          height: (pointsSucesfullyGenerated
              ? SizeConfig.blockSizeVertical * 60
              : SizeConfig.blockSizeVertical * 53),

          ///This is 80% of the Horizontal / Width for this container in this class
          width: SizeConfig.blockSizeHorizontal * 80,
          child: Stack(
            children: <Widget>[
              Container(
                height: (pointsSucesfullyGenerated
                    ? SizeConfig.blockSizeVertical * 57
                    : SizeConfig.blockSizeVertical * 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45.0)),
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
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                          circles: _circles,
                          onMapCreated: (GoogleMapController controller) {
                            //Change this to change styles
                            // controller.setMapStyle(Utils.DarkStyle);
                            _controller.complete(controller);
                          }),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: (pointsSucesfullyGenerated
                      ? SizedBox(height: 0)
                      : ButtonGoMainPage(this.callbackGoButtonMainPage,
                          pointsSucesfullyGenerated)))
            ],
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        Container(
          height: (pointsSucesfullyGenerated
              ? SizeConfig.blockSizeVertical * 14.5
              : SizeConfig.blockSizeVertical * 21.5),
          width: SizeConfig.blockSizeHorizontal * 100,
          child: (pointsSucesfullyGenerated
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Image(
                            image:
                                new AssetImage('assets/img/navigate_round.png'),
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
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
                            Row(
                              children: [
                                //Buttons
                                StartOverButton(this.callbackStartOver,
                                    pressStartOverButton),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 5),
                                OpenMapsButton(
                                    this.callbackOpenMaps, pressOpenMapsButton),
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Row(
                              children: [
                                //Buttons
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 15),
                                ShareLocationButton(
                                    this.callbackOpenMaps, pressOpenMapsButton),
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
                    SizedBox(width: 0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SetRadius(this.setRadiusCallback),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        SetRandomness(this.callbackselectedRandomness),
                      ],
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: HelpButton(this.callbackhelp),
                          ),
                          Container(
                              height: SizeConfig.blockSizeVertical * 10,
                              child: Column(
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 32,
                                    icon: ImageIcon(
                                      AssetImage('assets/img/Owl_Token.png'),
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(60.0),
                                                topRight: const Radius.circular(
                                                    60.0)),
                                          ),
                                          useRootNavigator: false,
                                          context: context,
                                          builder: (context) => Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    90,
                                                decoration: new BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [
                                                          0,
                                                          5.0
                                                        ],
                                                        colors: [
                                                          Color(0xff383B46),
                                                          Color(0xff5786E1)
                                                        ]),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        new BorderRadius.only(
                                                            topLeft: const Radius
                                                                .circular(60.0),
                                                            topRight: const Radius
                                                                    .circular(
                                                                60.0))),
                                                child: Container(
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      90,
                                                  child: TokenInfo(),
                                                ),
                                              ));
                                    },
                                  ),
                                  Container(
                                      child: AutoSizeText(
                                          globals.currentUser.points.toString(),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          maxFontSize: 23,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))),
                                ],
                              )),
                        ]),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                    Column(
                      children: <Widget>[
                        SetWaterPoints(this.setCheckWaterCallback),
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        PointsButtons(this.callbackSelectedPoint)
                      ],
                    ),
                  ],
                )),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
      ],
    );
  }

  void onAddMarkerButtonPressed() async {
    bool hasAccess = false;

    //Verifiy if the point selected is the following and whether the user has enough points
    switch (selectedRandomness.toString()) {
      case '1':
        if ((globals.currentUser.points >= RandomPointCost)) {
          hasAccess = true;
        }
        break;
      case '2':
        if (globals.currentUser.points >= QuantumPointCost) {
          hasAccess = true;
        }
        break;
      case '3':
        if (globals.currentUser.points >= AmplificationBiasPointCost) {
          hasAccess = true;
        }
        break;
    }

    if (hasAccess) {
      Navigator.push(
          context,
          FadeRoute(
              page: LoadingPoints(
                  callbackLoadingPoints,
                  radius,
                  currentLocation,
                  selectedPoint,
                  selectedRandomness,
                  checkWater)));
    } else {
      setBuyDialog(context);
    }
  }

  findingPointFailedDialogRetryCallback(){
    print('reached');
    Navigator.of(context).pop();

  }



  void callbackLoadingPoints(Attractors attractors) async {
    if(attractors == null){
      await findingPointFailedDialog(context, this.findingPointFailedDialogRetryCallback);
    }

    //Remove points locally
    //Verifiy if the point selected is the following and whether the user has enough points
    switch (selectedRandomness.toString()) {
      case '1':
        print('shouldremove1');
        if (globals.currentUser.points >= RandomPointCost) {
          globals.currentUser.points =
              globals.currentUser.points - RandomPointCost;
        }
        break;
      case '2':
        if (globals.currentUser.points >= QuantumPointCost) {
          globals.currentUser.points =
              globals.currentUser.points - QuantumPointCost;
        }
        break;
      case '3':
        if (globals.currentUser.points >= AmplificationBiasPointCost) {
          globals.currentUser.points =
              globals.currentUser.points - AmplificationBiasPointCost;
        }
        break;
    }

    //Set sucessfully generated
    this.pointsSucesfullyGenerated = true;

    //Store attractor coordinates
    attractorCoordinates = new LatLng(
        attractors.center.point.latitude, attractors.center.point.longitude);

    //Generate a unique marker id
    final attractorPointMarkerId = MarkerId('3333');

    //Generate a unique circle id
    final attractorPointCircleId = CircleId('3333');

    ///Todo add localidentifier as optional as it doesn't pick it up somehow
    ///https://pub.dev/packages/geolocator
    var location = await Geolocator().placemarkFromCoordinates(
      attractors.center.point.latitude,
      attractors.center.point.longitude,

      ///Locale for Local GeoLocator
      //  localeIdentifier: "fi_FI"
    );

    //Log trips
    final unloggedTrip = UnloggedTrip(
      is_visited: 0,
      is_logged: 0,
      is_favorite: 0,
      rng_type: 0,
      point_type: 0,
      title: null,
      report: 0.toString(),
      what_3_words_address: null,
      what_3_nearest_place: null,
      what_3_words_country: null,
      center: attractors.gID.toString(),
      latitude: attractors.gID.toString(),
      longitude: attractors.gID.toString(),
      location: location[0].administrativeArea.toString(),
      gid: attractors.gID.toString(),
      tid: attractors.gID.toString(),
      lid: attractors.gID.toString(),
      type: attractors.gID.toString(),
      x: attractors.gID.toString(),
      y: attractors.gID.toString(),
      distance: attractors.gID.toString(),
      initial_bearing: attractors.gID.toString(),
      final_bearing: attractors.gID.toString(),
      side: attractors.gID.toString(),
      distance_err: attractors.gID.toString(),
      radiusM: attractors.gID.toString(),
      number_points: attractors.gID.toString(),
      mean: attractors.gID.toString(),
      rarity: attractors.gID.toString(),
      power_old: attractors.gID.toString(),
      power: attractors.gID.toString(),
      z_score: attractors.gID.toString(),
      probability_single: attractors.gID.toString(),
      integral_score: attractors.gID.toString(),
      significance: attractors.gID.toString(),
      probability: attractors.gID.toString(),
      created: DateTime.now().toIso8601String(),
    );

    //Insert trip into db
    await insertUnloggedTrip(unloggedTrip);

    List<LatLng> PolylinePoints = new List<LatLng>();
    PolylinePoints.add(
        LatLng(currentLocation.latitude, currentLocation.longitude));
    PolylinePoints.add(
        LatLng(attractorCoordinates.latitude, attractorCoordinates.longitude));

    setState(() {
      //Camera ZOOM on map
      CAMERA_ZOOM = 13;

      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: attractorPointMarkerId,
        position: attractorCoordinates,
        infoWindow: InfoWindow(
          title: (attractors.type == 1 ? "Attractor" : "Void"),
          snippet: "Radius: " + attractors.radiusM.toStringAsFixed(0),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      _polylines.add(Polyline(
          polylineId: PolylineId('3333'),
          visible: true,
          //latlng is List<LatLng>
          points: PolylinePoints,
          color: Colors.blue,
          width: 3));
    });

    //Move camera to set ZOOM level
    controller.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(attractorCoordinates.latitude, attractorCoordinates.longitude),
        CAMERA_ZOOM));

    //Custom delay needed for opening the marker window
    await Future.delayed(Duration(milliseconds: 10));

    //Open Info window on marker
    controller.showMarkerInfoWindow(attractorPointMarkerId);

    //Update TripList state with callback to main
    this.widget.callback();
  }

  Future<bool>enableGPS() async {
    return await gpsDisabledDialog(context);
  }

  void setInitialLocation() async {


    bool isServiceEnabled = await location.serviceEnabled();

    print('enabled' + isServiceEnabled.toString());

    if(!isServiceEnabled){
      await enableGPS();
    }

    currentLocation = await location.getLocation();


    //polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged().listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();

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

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation

    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (!(attractorCoordinates == null)) {
      print('reachedatt');
      double distanceInMeters = await Geolocator().distanceBetween(
          attractorCoordinates.latitude,
          attractorCoordinates.longitude,
          currentLocation.latitude,
          currentLocation.longitude);

      print(distanceInMeters);
      if (distanceInMeters <= 30) {
        print('attractorreached');
      }
    }

    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      //  sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
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
    });
  }
}