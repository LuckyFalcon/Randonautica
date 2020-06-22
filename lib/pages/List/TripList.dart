import 'dart:io';

import 'package:app/components/SearchBar.dart';
import 'package:app/components/Trips/NoTripsFound.dart';
import 'package:app/components/Trips/RecentlyViewedTrips.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';
import 'LoggedTripDetails.dart';
import 'UnloggedTripDetails.dart';

class TripList extends StatefulWidget {
  TripList({Key key}) : super(key: key);

  @override
  State<TripList> createState() => TripListState();
}

class TripListState extends State<TripList> {
  List<UnloggedTrip> unloggedTrips;
  List<LoggedTrip> _LoggedTripList;

  //List<LoggedTrip> _LoggedTripList;
  //List<LoggedTrip> _LoggedTripList;

  List taglist = [];

  bool unloggedTripsloaded = false;
  bool LoggedTripList = false;

  ScrollController _scrollViewController;

  @override
  initState() {
    super.initState();

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
    return (unloggedTripsloaded && LoggedTripList
        ? (unloggedTrips.length > 0 || _LoggedTripList.length > 0
            ? Container(
                height: SizeConfig.blockSizeVertical * 70,
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    SearchBar(),
                    Expanded(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 3),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('recently_reported_trips')
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('recently_reported_trips')
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          SizedBox(height: 10),
                          (_LoggedTripList.length > 0
                              ? (RecentlyViewedTrips(_LoggedTripList))
                              : Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('empty_logged_trip_list')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)))),
                          SizedBox(height: 25),
//                          (_LoggedTripList.length > 0
//                              ? Container(
//                              padding: EdgeInsets.only(left: 20),
//                              child: Text(
//                                  AppLocalizations.of(context)
//                                      .translate('favorite_trips')
//                                      .toUpperCase(),
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      fontSize: 14,
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold)))
//                              : Container(
//                              padding: EdgeInsets.only(left: 20),
//                              child: Text(
//                                  AppLocalizations.of(context)
//                                      .translate('your_trip_log')
//                                      .toUpperCase(),
//                                  textAlign: TextAlign.start,
//                                  style: TextStyle(
//                                      fontSize: 28,
//                                      color: Colors.white,
//                                      fontWeight: FontWeight.bold)))),
//                          SizedBox(height: 10),
//                          (_LoggedTripList.length > 0
//                              ? (TripRow())
//                              : Container(
//                              padding: EdgeInsets.only(left: 40),
//                              child: Text(
//                                  AppLocalizations.of(context)
//                                      .translate('empty_logged_trip_list')
//                                      .toUpperCase(),
//                                  style: TextStyle(
//                                      fontSize: 14, color: Colors.white)))),
//                          SizedBox(height: 25),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('your_trip_log'),
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : Container(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('your_trip_log')
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))),
                          SizedBox(height: 25),
                          (_LoggedTripList.length > 0
                              ? (ListView.builder(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: _LoggedTripList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return loggedListWidget(
                                        gid: _LoggedTripList[index].gid,
                                        location:
                                            _LoggedTripList[index].location,
                                        datetime:
                                            _LoggedTripList[index].datetime,
                                        latitude:
                                            _LoggedTripList[index].latitude,
                                        longitude:
                                            _LoggedTripList[index].longitude,
                                        radius: _LoggedTripList[index].radius,
                                        type: _LoggedTripList[index].type,
                                        power: _LoggedTripList[index].power,
                                        zScore: _LoggedTripList[index].zScore,
                                        pseudo: _LoggedTripList[index].pseudo,
                                        title: _LoggedTripList[index].title,
                                        imagelocation: _LoggedTripList[index]
                                            .imagelocation,
                                        text: _LoggedTripList[index].text,
                                        tagList: [
                                          _LoggedTripList[index].tag1,
                                          _LoggedTripList[index].tag2,
                                          _LoggedTripList[index].tag3,
                                          _LoggedTripList[index].tag4,
                                          _LoggedTripList[index].tag5,
                                          _LoggedTripList[index].tag6,
                                          _LoggedTripList[index].tag7,
                                          _LoggedTripList[index].tag8,
                                          _LoggedTripList[index].tag9,
                                          _LoggedTripList[index].tag10,
                                          _LoggedTripList[index].tag11,
                                          _LoggedTripList[index].tag12,
                                          _LoggedTripList[index].tag13,
                                          _LoggedTripList[index].tag14,
                                          _LoggedTripList[index].tag15
                                        ]);
                                  }))
                              : Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('empty_logged_trip_list')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)))),
                          (_LoggedTripList.length > 0
                              ? Divider(
                                  color: Colors.white,
                                  height: 20,
                                  thickness: 5,
                                  indent: 35,
                                  endIndent: 30,
                                )
                              : SizedBox(width: 10)),
                          SizedBox(height: 40),
                          (unloggedTrips.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('unlogged_trips')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : SizedBox(width: 10)),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: unloggedTrips.length,
                              itemBuilder: (BuildContext context, int index) {
                                return listWidget(
                                  id: unloggedTrips[index].id,
                                  gid: unloggedTrips[index].gid,
                                  location: unloggedTrips[index].location,
                                  datetime: unloggedTrips[index].datetime,
                                  latitude: unloggedTrips[index].latitude,
                                  longitude: unloggedTrips[index].longitude,
                                  radius: unloggedTrips[index].radius,
                                  type: unloggedTrips[index].type,
                                  power: unloggedTrips[index].power,
                                  zScore: unloggedTrips[index].zScore,
                                  pseudo: unloggedTrips[index].pseudo,
                                );
                              }),
//                          (unloggedTrips.length > 0
//                              ? Divider(
//                                  color: Colors.white,
//                                  height: 20,
//                                  thickness: 2,
//                                  indent: 20,
//                                  endIndent: 20,
//                                )
//                              : SizedBox(width: 10)),
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

class UserWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageURL;

  const UserWidget({Key key, this.firstName, this.lastName, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListTile(
        leading: new FadeInImage(
          placeholder: new AssetImage('assets/me.jpg'),
          image: new NetworkImage(imageURL),
        ),
        title: new Text("First Name : " + firstName),
        subtitle: new Text("Last Name : " + lastName),
      ),
    );
  }
}

class listWidget extends StatelessWidget {
  Function callback;
  int id;
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

  listWidget(
      {Key key,
      this.callback,
      this.id,
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
      this.report})
      : super(key: key);

//  const listWidget({Key key, this.location, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        datetime,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text(
        location,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            Navigator.push(
              context,
              FadeRoute(
                  page: UnloggedTripDetails(
                this.callback,
                this.id,
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
              )),
            );
          }),
    ]));
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
                height: 5,
              ),
            ),
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
                      width: 80,
                      height: 80,
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
                          width: SizeConfig.blockSizeHorizontal * 56,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Trip title',
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
                                  'Location',
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
                                      child:
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true,
                                          text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              text: 'Begining of the desciprtion of the trip, description.description descriptiondescriptiondescription',
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
            ])
          ],
        ));
  }
}
