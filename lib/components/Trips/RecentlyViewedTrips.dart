import 'dart:io';

import 'package:app/models/LoggedTrip.dart';
import 'package:flutter/material.dart';

class RecentlyViewedTrips extends StatefulWidget {
  RecentlyViewedTrips(this._LoggedTripList);

  List<LoggedTrip> _LoggedTripList;

  State<StatefulWidget> createState() => new _RecentlyViewedTrips();
}

class _RecentlyViewedTrips extends State<RecentlyViewedTrips> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            (this.widget._LoggedTripList.length > 1
                ? Container(
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
                                image: FileImage(File(
                                  this.widget._LoggedTripList[1].imagelocation,
                                )),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 15),
                                  color: Colors.black.withOpacity(.6),
                                  spreadRadius: -9)
                            ]),
                      ),
                    ))
                : Container(width: 64, height: 64)),
            SizedBox(height: 10),

            (this.widget._LoggedTripList.length > 1
                ? Text(this.widget._LoggedTripList[1].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white))
                : SizedBox(height: 0))
          ],
        ),
        Column(
          children: <Widget>[
            (this.widget._LoggedTripList.length > 0
                ? Container(
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
                            image: FileImage(File(
                              this.widget._LoggedTripList[1].imagelocation,
                            )),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              offset: Offset(0, 15),
                              color: Colors.black.withOpacity(.6),
                              spreadRadius: -9)
                        ]),
                  ),
                ))
                : Container(width: 64, height: 64)),
            SizedBox(height: 10),

            (this.widget._LoggedTripList.length > 0
                ? Text(this.widget._LoggedTripList[0].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white))
                : SizedBox(height: 0))
          ],
        ),
        Column(
          children: <Widget>[
            (this.widget._LoggedTripList.length > 2
                ? Container(
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
                            image: FileImage(File(
                              this.widget._LoggedTripList[2].imagelocation,
                            )),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              offset: Offset(0, 15),
                              color: Colors.black.withOpacity(.6),
                              spreadRadius: -9)
                        ]),
                  ),
                ))
                : Container(width: 64, height: 64)),
            SizedBox(height: 10),
            (this.widget._LoggedTripList.length > 2
                ? Text(this.widget._LoggedTripList[2].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white))
                : SizedBox(height: 0))
          ],
        ),
      ],
    );
  }
}
