import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  Shop({Key key}) : super(key: key);

  @override
  State<Shop> createState() => ShopState();
}

class ShopState extends State<Shop> {
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

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      resizeToAvoidBottomPadding: false,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: Center(
            child: (unloggedTripsloaded
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 44.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red))),
          )),
    );
  } //Funct

}
