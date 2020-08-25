import 'dart:async';
import 'dart:math';

import 'package:app/api/saveTrip.dart';
import 'package:app/api/visitTrip.dart';
import 'package:app/components/Randonaut/ButtonGoMainPage.dart';
import 'package:app/components/Randonaut/FinishTripButton.dart';
import 'package:app/components/Randonaut/HelpButton.dart';
import 'package:app/components/Randonaut/OpenMapsButton.dart';
import 'package:app/components/Randonaut/PointsButtons.dart';
import 'package:app/components/Randonaut/SaveLocationButton.dart';
import 'package:app/components/Randonaut/SetRadius.dart';
import 'package:app/components/Randonaut/SetRandomness.dart';
import 'package:app/components/Randonaut/SetWaterPoints.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/OpenGoogleMaps.dart';
import 'package:app/models/Attractors.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/models/pin_pill_info.dart';
import 'package:app/pages/Token/TokenInfo.dart';
import 'package:app/utils/MapStyles.dart' as Utils;
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
import 'Loading/LoadingPoints.dart';
import 'Loading/WarningScreens.dart';

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
  final int randomPointCost = 1;
  final int quantumPointCost = 2;
  final int amplificationBiasPointCost = 5;

  ///Storing points from API
  Attractors currentAttractors;

  ///Button for setting state after generation
  bool pointsSucesfullyGenerated = false;

  ///Buttons for navigation
  bool pressOpenMapsButton = false;
  bool pressStartOverButton = false;
  bool pressShareLocationButton = false;

  ///1 = Anomaly, 2 = Attractor, 3 = Void. Anomaly is selected as standard
  int selectedPoint = 1;

  ///1 = Random, 2 = Quantum, 3 = Bias. Random is selected as standard
  int selectedRandomness = 1;

  ///Radius in meters. Miles or Kilometers * 1000, Standard radius is always 3000 meters
  int radius = 3000;

  ///True = on, false = off. Standard checkWater is always false.
  bool checkWater = false;

  ///Attractor points
  LatLng attractorCoordinates;

  ///Point retrieved from API used as a reference. Attractor/Void
  String retrievedPointType;

  ///Reached point
  bool reachedPoint = false;

  ///When saving point set to true to block user input
  bool savingPoint = false;

  ///Camera settings
  double CAMERA_ZOOM = 16;
  CameraPosition initialCameraPosition;

  ///Pin on map image
  BitmapDescriptor pinLocationIcon;

  ///Map controller
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;

  ///Location retrieved from local geolocator used as a reference
  var geoLocatorlocation;

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

  ///Location listener
  StreamSubscription<LocationData> locationSubscription;

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

  ///Tutorial targets list
  List<TargetFocus> targets = List();

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    // set the initial location
    setInitialLocation();

    // set marker image
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/img/Markers/marker.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set camera position
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

    //Initialize targets for Coach Mark (Tutorial)
    initTargets();

    //Initialize SizeConfig
    SizeConfig().init(context);

    return Column(
      children: <Widget>[
        Container(
          ///This is 60% of the Vertical / Height for this container in this class
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
                  border: Border.all(
                      width: SizeConfig.blockSizeHorizontal * 3.5,
                      color: Colors.white),
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
                            controller.setMapStyle(Utils.MapStyles.NightSTyle);
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
                            child: Material(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(90.0),
                                    topRight: Radius.circular(90.0),
                                    bottomLeft: Radius.circular(90.0),
                                    bottomRight: Radius.circular(90.0),
                                  ),
                                ),
                                child: Container(
                                    height: 64,
                                    width: 64,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                      ),
                                      child: Image(
                                        height: 128,
                                        width: 128,
                                        image: new AssetImage(
                                            'assets/img/navigate.png'),
                                        alignment: Alignment.topCenter,
                                      ),
                                    )))),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              height: SizeConfig.blockSizeHorizontal * 5,
                              child: AutoSizeText(
                                (geoLocatorlocation[0]
                                            .administrativeArea
                                            .toString() !=
                                        ''
                                    ? geoLocatorlocation[0].administrativeArea
                                    : geoLocatorlocation[0].country.toString()),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            AutoSizeText(
                              retrievedPointType,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Row(
                              children: [
                                OpenMapsButton(
                                    this.callbackOpenMaps, pressOpenMapsButton),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2),
                                (savingPoint
                                    ? SaveLocationButton(
                                        this.callbackSaveLocation, savingPoint)
                                    : SaveLocationButton(
                                        this.callbackSaveLocation,
                                        savingPoint)),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 5),
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            FinishTripButton(
                                this.callbackFinishTrip, pressStartOverButton),
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
                        SetRandomness(this.callbackSelectedRandomness),
                      ],
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                    Container(
                        height: SizeConfig.blockSizeVertical * 100,
                        child: Column(children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                          Container(
                            child: HelpButton(this.callbackHelp),
                          ),
                          SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
                          IconButton(
                            icon: new Image.asset('assets/img/Owl_Token.png'),
                            onPressed: () {
                              Navigator.push(
                                  context, FadeRoute(page: TokenInfo()));
                            },
                          ),
                          Container(
                              child: AutoSizeText(
                                  (globals.currentUser.points != -333 ? globals.currentUser.points.toString() : '∞'),
                                  maxLines: 1,
                                  minFontSize: 12,
                                  maxFontSize: 23,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: ''))),
                        ])),
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

  void callbackGoButtonMainPage(bool pressGoButton) {
    setState(() {
      onAddMarkerButtonPressed();
    });
  }

  void callbackHelp() {
    setState(() {
      showTutorial();
    });
  }

  void setRadiusCallback(int setRadius) {
    setState(() {
      radius = setRadius;
    });
  }

  void setCheckWaterCallback(bool setCheckWater) {
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

  void callbackFinishTrip(bool pressFinishTripButton) {
    setState(() {
      this.pressStartOverButton = pressOpenMapsButton;
      pointsSucesfullyGenerated = false;
      reachedPoint = false;
      attractorCoordinates = null;
      _markers = {};
      _polylines = {};
      currentAttractors = null;
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

  void callbackSaveLocation(bool saveLocation) async {
    if (savingPoint == false) {
      setState(() {
        savingPoint = true;
      });
      UnloggedTrip unloggedTrip;
      await saveTrip(currentAttractors.gID.toString()).then((value) async => {
            if (value == 200)
              {
                //Log trips
                unloggedTrip = UnloggedTrip(
                  is_visited: 0,
                  is_logged: 0,
                  is_favorite: 0,
                  rng_type: selectedRandomness,
                  point_type: selectedPoint,
                  title: null,
                  report: 0.toString(),
                  what_3_words_address: null,
                  what_3_nearest_place: null,
                  what_3_words_country: null,
                  center: currentAttractors.gID.toString(),
                  latitude: currentAttractors.gID.toString(),
                  longitude: currentAttractors.gID.toString(),
                  location:
                      (geoLocatorlocation[0].administrativeArea.toString() != ''
                          ? geoLocatorlocation[0].administrativeArea
                          : geoLocatorlocation[0].country.toString()),
                  gid: currentAttractors.gID.toString(),
                  tid: currentAttractors.gID.toString(),
                  lid: currentAttractors.gID.toString(),
                  type: currentAttractors.gID.toString(),
                  x: currentAttractors.gID.toString(),
                  y: currentAttractors.gID.toString(),
                  distance: currentAttractors.gID.toString(),
                  initial_bearing: currentAttractors.gID.toString(),
                  final_bearing: currentAttractors.gID.toString(),
                  side: currentAttractors.gID.toString(),
                  distance_err: currentAttractors.gID.toString(),
                  radiusM: currentAttractors.gID.toString(),
                  number_points: currentAttractors.gID.toString(),
                  mean: currentAttractors.gID.toString(),
                  rarity: currentAttractors.gID.toString(),
                  power_old: currentAttractors.gID.toString(),
                  power: currentAttractors.gID.toString(),
                  z_score: currentAttractors.gID.toString(),
                  probability_single: currentAttractors.gID.toString(),
                  integral_score: currentAttractors.gID.toString(),
                  significance: currentAttractors.gID.toString(),
                  probability: currentAttractors.gID.toString(),
                  created: DateTime.now().toIso8601String(),
                ),

                //Insert trip into db
                await insertUnloggedTrip(unloggedTrip)
              }
          });
    }
  }

  void pointsGeneratedCallback(bool pointsSuccesfullyGenerated) {
    this.pointsSucesfullyGenerated = pointsSuccesfullyGenerated;
  }

  void callbackSelectedPoint(int currentSelectedPoint) {
    setState(() {
      selectedPoint = currentSelectedPoint;
    });
  }

  void callbackSelectedRandomness(int currentSelectedRandomness) {
    setState(() {
      selectedRandomness = currentSelectedRandomness;
      print(selectedRandomness);
    });
  }

  void onAddMarkerButtonPressed() async {
    bool hasAccess = false;

    //Verifiy if the point selected is the following and whether the user has enough points
    //Infnite point users are noted as having -333 points
    switch (selectedRandomness.toString()) {
      case '1':
        if (globals.currentUser.points >= randomPointCost || globals.currentUser.points == -333) {
          hasAccess = true;
        }
        break;
      case '2':
        if (globals.currentUser.points >= quantumPointCost || globals.currentUser.points == -333) {
          hasAccess = true;
        }
        break;
      case '3':
        if (globals.currentUser.points >= amplificationBiasPointCost || globals.currentUser.points == -333) {
          hasAccess = true;
        }
        break;
    }

    //User doesn't have enough points to continue
    if (!hasAccess) {
      return notEnoughTokensDialog(context);
    }

    //Check if the current location is not empty
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      //Choose randomly between loading screens
      int RandomNumber = new Random().nextInt(2);
      if (RandomNumber == 1) {
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
        Navigator.push(
            context,
            FadeRoute(
                page: WarningScreens(
                    callbackLoadingPoints,
                    radius,
                    currentLocation,
                    selectedPoint,
                    selectedRandomness,
                    checkWater)));
      }
    } else {
      //Otherwise re-enable location
      setInitialLocation();
    }
  }

  void findingPointFailedDialogRetryCallback() {
    Navigator.of(context).pop();
    onAddMarkerButtonPressed();
  }

  void callbackLoadingPoints(Attractors attractors) async {
    if (attractors == null) {
      //Error occurred
      return await findingPointFailedDialog(
          context, this.findingPointFailedDialogRetryCallback);
    }
    //Remove points locally
    //Verifiy if the point selected is the following and whether the user has enough points
    //Infnite point users are noted as having -333 points
    switch (selectedRandomness.toString()) {
      case '1':
        if (globals.currentUser.points >= randomPointCost && globals.currentUser.points != -333) {
          globals.currentUser.points =
              globals.currentUser.points - randomPointCost;
        }
        break;
      case '2':
        if (globals.currentUser.points >= quantumPointCost && globals.currentUser.points != -333) {
          globals.currentUser.points =
              globals.currentUser.points - quantumPointCost;
        }
        break;
      case '3':
        if (globals.currentUser.points >= amplificationBiasPointCost && globals.currentUser.points != -333) {
          globals.currentUser.points =
              globals.currentUser.points - amplificationBiasPointCost;
        }
        break;
    }

    //Set sucessfully generated
    this.pointsSucesfullyGenerated = true;

    currentAttractors = attractors;

    //Store attractor coordinates
    attractorCoordinates = new LatLng(
        attractors.center.point.latitude, attractors.center.point.longitude);

    //Generate a unique marker id
    final attractorPointMarkerId = MarkerId(Random().nextInt(1337).toString());

    try {
      await Future.delayed(const Duration(milliseconds: 500), () async {
        geoLocatorlocation = await Geolocator().placemarkFromCoordinates(
          attractors.center.point.latitude,
          attractors.center.point.longitude,
        );
      });
    } catch (error) {
      geoLocatorlocation = '';
    }

    retrievedPointType = (attractors.type == 1 ? "Attractor" : "Void");

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
        icon: pinLocationIcon,
      ));

      _polylines.add(Polyline(
          polylineId: PolylineId('3333'),
          visible: true,
          //latlng is List<LatLng>
          points: PolylinePoints,
          color: Color(0xff3AC7DC),
          width: 2));
    });

    try {
      //Move camera to set ZOOM level
      await controller.moveCamera(CameraUpdate.newLatLngZoom(
          LatLng(attractorCoordinates.latitude, attractorCoordinates.longitude),
          CAMERA_ZOOM));
    } catch (error) {}

    //Custom delay needed for opening the marker window
    await Future.delayed(Duration(milliseconds: 1000));

    //Open Info window on marker
    controller.showMarkerInfoWindow(attractorPointMarkerId);

    //Update TripList state with callback to main
    this.widget.callback();
  }

  Future<bool> enableGPS() async {
    await location.requestService();
    setInitialLocation();
  }

  void setInitialLocation() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (isServiceEnabled) {
      currentLocation = await location.getLocation();

      //polylinePoints = PolylinePoints();
      // subscribe to changes in the user's location
      // by "listening" to the location's onLocationChanged event
      locationSubscription =
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
    } else {
      await gpsDisabledDialog(context, enableGPS);
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation

    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (!(attractorCoordinates == null)) {
      try {
        double distanceInMeters = await Geolocator().distanceBetween(
            attractorCoordinates.latitude,
            attractorCoordinates.longitude,
            currentLocation.latitude,
            currentLocation.longitude);

        if (distanceInMeters <= 30) {
          if (reachedPoint == false) {
            reachedPoint = true;
            pointReached(context);
            //update trip on backend and set to visited
            await visitTrip(currentAttractors.gID.toString());
          }
        }
      } catch (error) {
        print(error);
      }
    }

    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
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
    //gpsDisabledDialog(context, callbackSelectedPoint);
    //loginFailedDailog(context, enableGPS);
    //noInternetConnectionDialog(context, enableGPS);
    //  notEnoughTokensDialog(context);
//    randonauticaStreakDialog(
//        context, globals.currentUser.currentSignedInStreak);
    //signInStreak();
    TutorialCoachMark(context,
        targets: targets,
        colorShadow: Colors.blue,
        textSkip: "SKIP",
        paddingFocus: 10,
        opacityShadow: 0.8, finish: () {
      print("finish");
    }, clickTarget: (target) {
      print(target);
    }, clickSkip: () {
      print("skip");
    })
      ..show();
  }
}
