import 'dart:io';

import 'package:app/api/syncTripReports.dart';
import 'package:app/components/SearchBar.dart';
import 'package:app/components/Trips/NoTripsFound.dart';
import 'package:app/components/Trips/RecentlyViewedTrips.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/storage/loggedTripsDatabase.dart';
import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/AppLocalizations.dart';
import 'LoggedTripDetails.dart';
import 'UnloggedTripDetails.dart';

class TripList extends StatefulWidget {
  TripList({Key key}) : super(key: key);

  @override
  State<TripList> createState() => TripListState();
}

class TripListState extends State<TripList> {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<UnloggedTrip> unloggedTrips;
  List<LoggedTrip> _LoggedTripList;

  List taglist = [];

  bool unloggedTripsSynced = false;
  bool unloggedTripsloaded = false;
  bool LoggedTripList = false;

  ScrollController _scrollViewController;

  @override
  initState() {
    super.initState();

    initializeTripList();

  }

  initializeTripList() async {

    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;

    if(prefs.getBool("SyncedReports") != true){
      await syncTripReports();
        setState(() {
          prefs.setBool("SyncedReports", true);
          unloggedTripsSynced = true;
        });
    } else {
      unloggedTripsSynced = true;
    }

    Future<List<UnloggedTrip>> _futureOfList = RetrieveUnloggedTrips();
    _futureOfList.then((value) {
      unloggedTrips = value;
      setState(() {
        unloggedTripsloaded = true;
      });
    });
    Future<List<LoggedTrip>> _futureOfLoggedList = RetrieveLoggedTrips();
    _futureOfLoggedList.then((value) {
      if (value != null) {
        _LoggedTripList = value;
        setState(() {
          LoggedTripList = true;
        });
      }
    });
  }

  updateState() {
    setState(() {
      Future<List<UnloggedTrip>> _futureOfList = RetrieveUnloggedTrips();
      _futureOfList.then((value) {
        unloggedTrips = value;
      });
      Future<List<LoggedTrip>> _futureOfLoggedList = RetrieveLoggedTrips();
      _futureOfLoggedList.then((value) {
        if (value != null) {
          _LoggedTripList = value;
        }
      });
    });
  }

  void callback(bool labButtonPress) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (unloggedTripsloaded && LoggedTripList && unloggedTripsSynced
        ? (unloggedTrips.length > 0 || _LoggedTripList.length > 0
            ? Container(
                height: SizeConfig.blockSizeVertical * 78, ///78 tied to Randonaut.dart
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
          //          SizedBox(height: SizeConfig.blockSizeVertical * 1),
             //       SearchBar(),
                    Expanded(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
   //                       SizedBox(height: SizeConfig.blockSizeVertical * 3),
//                          (_LoggedTripList.length > 2
//                              ? Container(
//                                  padding: EdgeInsets.only(left: 20),
//                                  child: Text(
//                                      AppLocalizations.of(context)
//                                          .translate('recently_reported_trips')
//                                          .toUpperCase(),
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.bold)))
//                              : SizedBox(height: 0)),
//                          (_LoggedTripList.length > 2 ? SizedBox(height: 10) : SizedBox(height: 0)),
//                          (_LoggedTripList.length > 2
//                              ? (RecentlyViewedTrips(_LoggedTripList))
//                              : SizedBox(height: 0)),
//                          (_LoggedTripList.length > 2 ? SizedBox(height: 25) : SizedBox(height: 0)),
////                          (_LoggedTripList.length > 0
////                              ? Container(
////                              padding: EdgeInsets.only(left: 20),
////                              child: Text(
////                                  AppLocalizations.of(context)
////                                      .translate('favorite_trips')
////                                      .toUpperCase(),
////                                  textAlign: TextAlign.center,
////                                  style: TextStyle(
////                                      fontSize: 14,
////                                      color: Colors.white,
////                                      fontWeight: FontWeight.bold)))
////                              : Container(
////                              padding: EdgeInsets.only(left: 20),
////                              child: Text(
////                                  AppLocalizations.of(context)
////                                      .translate('your_trip_log')
////                                      .toUpperCase(),
////                                  textAlign: TextAlign.start,
////                                  style: TextStyle(
////                                      fontSize: 28,
////                                      color: Colors.white,
////                                      fontWeight: FontWeight.bold)))),
////                          SizedBox(height: 10),
////                          (_LoggedTripList.length > 0
////                              ? (TripRow())
////                              : Container(
////                              padding: EdgeInsets.only(left: 40),
////                              child: Text(
////                                  AppLocalizations.of(context)
////                                      .translate('empty_logged_trip_list')
////                                      .toUpperCase(),
////                                  style: TextStyle(
////                                      fontSize: 14, color: Colors.white)))),
////                          SizedBox(height: 25),
//                          (_LoggedTripList.length > 0
//                              ? Container(
//                                  padding: EdgeInsets.only(left: 30),
//                                  child: Text(
//                                      AppLocalizations.of(context)
//                                          .translate('your_trip_log'),
//                                      style: TextStyle(
//                                          fontSize: 40,
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.bold)))
//                              : Container(
//                                  padding: EdgeInsets.only(left: 40),
//                                  child: Text(
//                                      AppLocalizations.of(context)
//                                          .translate('your_trip_log')
//                                          .toUpperCase(),
//                                      textAlign: TextAlign.start,
//                                      style: TextStyle(
//                                          fontSize: 40,
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.bold)))),
//                          SizedBox(height: 25),
//                          (_LoggedTripList.length > 0
//                              ? (ListView.builder(
//                                  padding: EdgeInsets.only(left: 30, right: 30),
//                                  shrinkWrap: true,
//                                  physics: ScrollPhysics(),
//                                  itemCount: _LoggedTripList.length,
//                                  itemBuilder:
//                                      (BuildContext context, int index) {
//                                    return loggedListWidget(
//                                        location:
//                                            _LoggedTripList[index].location,
//                                        datetime:
//                                            _LoggedTripList[index].created,
//                                        title: _LoggedTripList[index].title,
//                                        imagelocation: _LoggedTripList[index]
//                                            .imagelocation,
//                                        text: _LoggedTripList[index].report,
//
//                                    );
//                                  }))
//                              : Container(
//                                  padding: EdgeInsets.only(left: 20),
//                                  child: Text(
//                                      AppLocalizations.of(context)
//                                          .translate('empty_logged_trip_list')
//                                          .toUpperCase(),
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)))),
//                          (_LoggedTripList.length > 0
//                              ? Container(
//                                  margin:
//                                      EdgeInsets.only(left: 30.0, right: 30.0),
//                                  width: 20,
//                                  decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(15),
//                                  ),
//                                  child: Divider(
//                                    color: Colors.white,
//                                    height: 2,
//                                  ),
//                                )
//                              : SizedBox(width: 10)),
                          SizedBox(height: 40),
                          (unloggedTrips.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 30, right: 40),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('unlogged_trips'),
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : SizedBox(width: 10)),
                          SizedBox(height: 30),
                          ListView.builder(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: unloggedTrips.length,
                              itemBuilder: (BuildContext context, int index) {
                                print('created'+unloggedTrips[index].created);
                                return unloggedListWidget(
                                  id: unloggedTrips[index].id,
                                  location: unloggedTrips[index].location,
                                  created: unloggedTrips[index].created,
                                );
                              }),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 2,
                                  ),
                                )
                              : SizedBox(width: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : NoTripsFound())
        : CircularProgressIndicator(
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
  } //Functions
}

class unloggedListWidget extends StatelessWidget {
  final dateFormatter = DateFormat('yyyy/MM/dd, hh:mm a');

  Function callback;
  int id;
  String location;
  String created;

  unloggedListWidget(
      {Key key,
      this.callback,
      this.id,
      this.location,
      this.created,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Divider(
          color: Colors.white,
          height: 2,
        ),
      ),
      Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Text(
                dateFormatter.format(DateTime.parse(created)),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                location,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          Expanded(
              flex: 0,
              child:  IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
//                    logUnloggedTrip(
//                      this.location,
//                      this.created,
//
//
//                    );
                    Navigator.push(
                      context,
                      FadeRoute(
                          page: UnloggedTripDetails(
                            this.callback,
                            this.id,
                            this.location,
                            this.created,
                          )),
                    );
                  }),
            ),

      ]))
    ]);
  }
}

class loggedListWidget extends StatelessWidget {
  String gid;
  String location;
  String datetime;
  String latitude;
  String longitude;
  String radius;
  String type;
  String power;
  String zScore;
  String pseudo;
  String report;
  String title;
  String imagelocation;
  String text;
  List tagList;

  loggedListWidget(
      {Key key,
      this.gid,
      this.location,
      this.datetime,
      this.latitude,
      this.longitude,
      this.radius,
      this.type,
      this.power,
      this.zScore,
      this.pseudo,
      this.report,
      this.title,
      this.imagelocation,
      this.text,
      this.tagList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Container(
        alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 10),
              imagelocation == null
                  ? Text(
                      imagelocation,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  : Container(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      height: SizeConfig.blockSizeVertical * 10,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: FileImage(File(imagelocation)),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    offset: Offset(0, 15),
                                    color: Colors.black.withOpacity(.6),
                                    spreadRadius: -9)
                              ]),
                        ),
                      )),
              SizedBox(width: 10),
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          width: SizeConfig.blockSizeHorizontal * 54,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      this.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Tuesday',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  this.location,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 9,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true,
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            text: this.text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 24.0,
                                          semanticLabel:
                                              'Text to announce in accessibility modes',
                                        ),
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            FadeRoute(
                                                page: LoggedTripDetails(
                                                    this.location,
                                                    this.datetime,
                                                    this.title,
                                                    this.imagelocation,
                                                    this.text,
                                                    this.tagList)),
                                          );
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
            SizedBox(height: 5),
          ],
        ));
  }
}
