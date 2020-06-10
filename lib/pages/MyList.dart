import 'dart:io';
import 'dart:math';

import 'package:app/components/ListSearchBar.dart';
import 'package:app/components/NoTripsFound.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/TripRow.dart';
import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/Post.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import '../helpers/AppLocalizations.dart';
import 'MyListDetails.dart';
import 'TripDetails.dart';

class MyList extends StatefulWidget {
  MyList({Key key}) : super(key: key);

  @override
  State<MyList> createState() => MyListState();
}

class MyListState extends State<MyList> {
  List<UnloggedTrip> _list;
  List<LoggedTrip> _LoggedTripList;

  var test;

  @override
  initState() {
    super.initState();

    Future<List<UnloggedTrip>> _futureOfList = RetrieveUnloggedTrips();
    _futureOfList.then((value) {
      _list = value;
      print(_list[0].datetime);
    });
    Future<List<LoggedTrip>> _futureOfLoggedList = RetrieveLoggedTrips();
    _futureOfLoggedList.then((value) {
      _LoggedTripList = value;
      print('logged:' + _LoggedTripList[0].datetime);
    });
  }

  List unloggedTrips = [
    {
      "first_name": "FLUTTER",
      "last_name": "AWESOME",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
  ];

  List loggedTrips = [];

  List favoriteTrips = [
    {
      "first_name": "FLUTTER",
      "last_name": "AWESOME",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
  ];

  List recentlyViewdTrips = [];

  final SearchBarController<Post> _searchBarController = SearchBarController();

  bool isReplay = false;

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts
          .add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return (_list.length > 0
        ? Scaffold(
            resizeToAvoidBottomPadding: false,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 100],
                      colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
              child: new Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TopBar(),
                    Expanded(
                      child: SizedBox(
                        child: SearchBar<Post>(
                          searchBarPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                          headerPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                          listPadding:
                          EdgeInsets.symmetric(horizontal: 10),
                          onSearch: _getALlPosts,
                          searchBarController: _searchBarController,
                          cancellationWidget: Text("Cancel"),
                          hintText: "SEARCH",
                          indexedScaledTileBuilder: (int index) =>
                              ScaledTile.count(1, index.isEven ? 2 : 1),
                          onCancelled: () {
                            print("Cancelled triggered");
                          },
                          searchBarStyle: SearchBarStyle(
                            backgroundColor: Colors.white,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          onItemFound: (Post post, int index) {
                            return ListTile(
                              title: Text(post.title),
                              isThreeLine: true,
                              subtitle: Text(post.body),
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => TripDetails(
                                            '123', 'amstel')));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
//                          (recentlyViewdTrips.length > 0
//                              ? Text(
//                                  AppLocalizations.of(context)
//                                      .translate('recently_viewed_trips')
//                                      .toUpperCase(),
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      fontSize: 16, color: Colors.white))
//                              : SizedBox(width: 10)),
//                          (recentlyViewdTrips.length > 0
//                              ? TripRow()
//                              : SizedBox(width: 10)),
//                          (_LoggedTripList.length > 0
//                              ? Text(
//                                  AppLocalizations.of(context)
//                                      .translate('recently_viewed_trips')
//                                      .toUpperCase(),
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      fontSize: 16, color: Colors.white))
//                              : SizedBox(width: 10)),
//                          (_LoggedTripList.length > 0
//                              ? TripRow()
//                              : SizedBox(width: 10)),
                          (_LoggedTripList.length > 0
                              ? Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('your_trip_log')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                              : Text(
                                  AppLocalizations.of(context)
                                      .translate('your_trip_log')

                                      ///Set to empty
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white))),
                          (_LoggedTripList.length > 0
                              ? (ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Colors.white,
                                      height: 20,
                                      thickness: 2,
                                      indent: 20,
                                      endIndent: 20,
                                    );
                                  },
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
                                        image: _LoggedTripList[index]
                                            .imagelocation);
                                  }))
                              : Text(
                                  AppLocalizations.of(context)
                                      .translate('empty_logged_trip_list')

                                      ///Set to empty
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          (_LoggedTripList.length > 0
                              ? Divider(
                                  color: Colors.white,
                                  height: 20,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
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
                          ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.white,
                                  height: 20,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                );
                              },
                              physics: ScrollPhysics(),
                              itemCount: _LoggedTripList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return listWidget(
                                  gid: _LoggedTripList[index].gid,
                                  location: _LoggedTripList[index].location,
                                  datetime: _LoggedTripList[index].datetime,
                                  latitude: _LoggedTripList[index].latitude,
                                  longitude: _LoggedTripList[index].longitude,
                                  radius: _LoggedTripList[index].radius,
                                  type: _LoggedTripList[index].type,
                                  power: _LoggedTripList[index].power,
                                  zScore: _LoggedTripList[index].zScore,
                                  pseudo: _LoggedTripList[index].pseudo,
                                );
                                return new FutureBuilder<List<UnloggedTrip>>(
                                  future: RetrieveUnloggedTrips(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return listWidget(
                                        gid: snapshot.data[index].gid,
                                        location: snapshot.data[index].location,
                                        datetime: snapshot.data[index].datetime,
                                        latitude: snapshot.data[index].latitude,
                                        longitude:
                                            snapshot.data[index].longitude,
                                        radius: snapshot.data[index].radius,
                                        type: snapshot.data[index].type,
                                        power: snapshot.data[index].power,
                                        zScore: snapshot.data[index].zScore,
                                        pseudo: snapshot.data[index].pseudo,
                                        report: snapshot.data[index].report,
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                );
                              }),
                          Divider(
                            color: Colors.white,
                            height: 20,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
        : NoTripsFound());
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
              MaterialPageRoute(
                  builder: (context) => UnloggedTripDetails(
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
  String image;

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
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: FractionalOffset.centerLeft,
        child: Row(children: [
          image == null
              ? Text(
                  image,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              : Image.file(File(image), width: 96, height: 96),
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      height: 120,
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Day',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Day',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Day',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Begining of the desciprtion of the trip, description. I love u Steve',
                              style: TextStyle(
                                color: Colors.white,
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
                                    MaterialPageRoute(
                                        builder: (context) => TripDetails(
                                              //    this.gid,
                                              this.location,
                                              this.datetime,
//                                                          this.latitude,
//                                                          this.longitude,
//                                                          this.radius,
//                                                          this.type,
//                                                          this.power,
//                                                          this.zScore,
//                                                          this.pseudo,
//                                                          this.report,
                                            )),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ]));
  }
}
