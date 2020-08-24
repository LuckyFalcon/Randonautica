import 'dart:io';

import 'package:app/api/syncTripReports.dart';
import 'package:app/components/SearchBar.dart';
import 'package:app/components/Trips/LoggedListItem.dart';
import 'package:app/components/Trips/NoTripsFound.dart';
import 'package:app/components/Trips/RecentlyViewedTrips.dart';
import 'package:app/components/Trips/UnloggedListItem.dart';
import 'package:app/helpers/FadeRoute.dart';
import '../../storage/loggedTripsDatabase.dart';
import '../../storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

  var AutoSizeTextTitleGroup = AutoSizeGroup();

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Store Unlogged & Logged Trips
  List<UnloggedTrip> unloggedTrips;
  List<LoggedTrip> _LoggedTripList;

  //UnloggedTrips & Logged trips are sucesfully retrieved from database
  bool unloggedTripsloaded = false;
  bool LoggedTripList = false;

  @override
  initState() {
    super.initState();

    initializeTripList();

  }

  initializeTripList() async {
    //Get list of unlogged trips
    Future<List<UnloggedTrip>> _futureOfList = RetrieveUnloggedTrips();
    _futureOfList.then((value) {
      unloggedTrips = value;
      setState(() {
        unloggedTripsloaded = true;
      });
    });

    //Get list of logged trips
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (unloggedTripsloaded && LoggedTripList
        ? (unloggedTrips.length > 0 || _LoggedTripList.length > 0
            ?
   // NoTripsFound()

    Container(
                height: SizeConfig.blockSizeVertical * 78, ///78 tied to Randonaut.dart
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                 //   SearchBar(),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    Expanded(
                      child: ListView(
                        addAutomaticKeepAlives: true,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          (_LoggedTripList.length > 2
                              ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('recently_reported_trips')
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      ImageIcon(
                                          AssetImage('assets/img/double_arrow.png'),
                                          size: 64.0,
                                          color: Colors.white)
                                    ],
                                  ))
                              : SizedBox(height: 0)),
                          (_LoggedTripList.length > 2 ? SizedBox(height: 10) : SizedBox(height: 0)),
                          (_LoggedTripList.length > 2
                              ? (RecentlyViewedTrips(_LoggedTripList))
                              : SizedBox(height: 0)),
                          (_LoggedTripList.length > 2 ? SizedBox(height: 25) : SizedBox(height: 0)),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 30),
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('your_trip_log'),
                                      group: AutoSizeTextTitleGroup,
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : Container(
                                    padding: EdgeInsets.only(left: 30, right: 30),
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
                                  addAutomaticKeepAlives: true,
                                  physics: ScrollPhysics(),
                                  itemCount: _LoggedTripList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return LoggedListItem(
                                        location:
                                            _LoggedTripList[index].location,
                                        datetime:
                                            _LoggedTripList[index].created,
                                        title: _LoggedTripList[index].title,
                                        imagelocation: _LoggedTripList[index]
                                            .imagelocation,
                                        text: _LoggedTripList[index].report,
                                    );
                                  }))
                              : Container(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('empty_logged_trip_list')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)))),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  margin:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
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
                          SizedBox(height: 40),
                          (unloggedTrips.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 30, right: 40),
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('unlogged_trips'),
                                      group: AutoSizeTextTitleGroup,
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : SizedBox(width: 10)),
                          SizedBox(height: 30),
                          ListView.builder(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              shrinkWrap: true,
                              addAutomaticKeepAlives: true,
                              physics: ScrollPhysics(),
                              itemCount: unloggedTrips.length,
                              itemBuilder: (BuildContext context, int index) {
                                print('created'+unloggedTrips[index].created);
                                return UnloggedListWidget(
                                  id: unloggedTrips[index].id,
                                  location: unloggedTrips[index].location,
                                  created: unloggedTrips[index].created,
                                  callback: updateState,
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


