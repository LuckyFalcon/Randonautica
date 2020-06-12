import 'package:app/components/TopBar.dart';
import 'file:///E:/Randonautica/randonautica/lib/components/Feed/TripFeedEntry.dart';
import 'file:///E:/Randonautica/randonautica/lib/components/Trips/TripRow.dart';
import 'package:flutter/material.dart';
import '../../helpers/AppLocalizations.dart';

class TripFeed extends StatefulWidget {
  @override
  State<TripFeed> createState() => TripFeedState();
}

class TripFeedState extends State<TripFeed> {
  bool acceptedAgreement = false;

  @override
  void initState() {
    super.initState();
  }

  ///Fill this list with SQL lite db query
  List trips = [
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
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
      "image_url":
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"
    },
    {
      "first_name": "ABC",
      "last_name": "XYZ",
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

  @override
  Widget build(BuildContext context) {
    return
       Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context)
                              .translate('recently_viewed_trips')
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      TripRow(),
                      Text(
                          AppLocalizations.of(context)
                              .translate('your_trip_log')
                              .toUpperCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 28, color: Colors.white)),
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
                            return new UserWidget(
                              firstName: trips[index]['first_name'],
                              lastName: trips[index]['last_name'],
                              imageURL: trips[index]['image_url'],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
      );
//      : TripFeedEntry());


//    return (acceptedAgreement
//        ? Center(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Expanded(
//            child: ListView(
//              physics: ScrollPhysics(),
//              shrinkWrap: true,
//              padding: const EdgeInsets.all(8),
//              children: <Widget>[
//                Text(
//                    AppLocalizations.of(context)
//                        .translate('recently_viewed_trips')
//                        .toUpperCase(),
//                    textAlign: TextAlign.center,
//                    style: TextStyle(fontSize: 16, color: Colors.white)),
//                TripRow(),
//                Text(
//                    AppLocalizations.of(context)
//                        .translate('your_trip_log')
//                        .toUpperCase(),
//                    textAlign: TextAlign.start,
//                    style: TextStyle(fontSize: 28, color: Colors.white)),
//                ListView.separated(
//                    shrinkWrap: true,
//                    separatorBuilder: (context, index) {
//                      return Divider(
//                        color: Colors.white,
//                        height: 20,
//                        thickness: 2,
//                        indent: 20,
//                        endIndent: 20,
//                      );
//                    },
//                    physics: ScrollPhysics(),
//                    itemCount: 2,
//                    itemBuilder: (BuildContext context, int index) {
//                      return new UserWidget(
//                        firstName: trips[index]['first_name'],
//                        lastName: trips[index]['last_name'],
//                        imageURL: trips[index]['image_url'],
//                      );
//                    }),
//              ],
//            ),
//          ),
//        ],
//      ),
//    )
//        : TripFeedEntry());
    //ListSearchBar();
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
