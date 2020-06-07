import 'package:app/components/NoTripsFound.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/TripRow.dart';
import 'package:app/helpers/storage/TripsDatabase.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:flutter/material.dart';
import '../helpers/AppLocalizations.dart';
import 'MyListDetails.dart';

class MyList extends StatefulWidget {
  @override
  State<MyList> createState() => MyListState();
}

class MyListState extends State<MyList> {
  @override
  void initState() {
    super.initState();
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

  List recentlyViewdTrips = [

  ];

  @override
  Widget build(BuildContext context) {
    return (unloggedTrips.length > 0
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
                    Expanded(
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          TopBar(),
                          (recentlyViewdTrips.length > 0
                              ? Text(
                              AppLocalizations.of(context)
                                  .translate('recently_viewed_trips')
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))
                              : SizedBox(width: 10)),
                          (recentlyViewdTrips.length > 0
                              ? TripRow()
                              : SizedBox(width: 10)),
                          (loggedTrips.length > 0
                              ? Text(
                                  AppLocalizations.of(context)
                                      .translate('recently_viewed_trips')
                                      .toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white))
                              : SizedBox(width: 10)),
                          (loggedTrips.length > 0
                              ? TripRow()
                              : SizedBox(width: 10)),
                          (loggedTrips.length > 0
                              ? Text(
                                  AppLocalizations.of(context)
                                      .translate('your_trip_log')
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white))
                              : Text(
                                  AppLocalizations.of(context)
                                      .translate('your_trip_log')

                                      ///Set to empty
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white))),
                          (loggedTrips.length > 0
                              ? ListView.separated(
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
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new UserWidget(
                                      firstName: unloggedTrips[index]
                                          ['first_name'],
                                      lastName: unloggedTrips[index]
                                          ['last_name'],
                                      imageURL: unloggedTrips[index]
                                          ['image_url'],
                                    );
                                  })
                              : Text(
                                  AppLocalizations.of(context)
                                      .translate('empty_logged_trip_list')

                                      ///Set to empty
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          (unloggedTrips.length > 0
                              ? Text(
                                  AppLocalizations.of(context)
                                      .translate('unlogged_trips')
                                      .toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white))
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
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return new FutureBuilder<List<UnloggedTrip>>(
                                  future: RetrieveUnloggedTrips(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return listWidget(
                                        location: snapshot.data[0].location,
                                        dateTime: snapshot.data[0].dateTime,
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                );
                              })
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
  final String location;
  final String dateTime;

  const listWidget({Key key, this.location, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        dateTime,
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
                  builder: (context) =>
                      UnloggedTripDetails(location, dateTime)),
            );
          }),
    ]));
  }
}
