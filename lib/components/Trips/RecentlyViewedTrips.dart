import 'dart:io';

import 'package:app/helpers/AppLocalizations.dart';
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
            (this.widget._LoggedTripList.length > 1 ?
            Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 15),
                          color: Colors.black.withOpacity(.6),
                          spreadRadius: -9)
                    ]),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        ///image here
                      ],
                    ),
                  ),
                  onPressed: () {},
                  color: Colors.white,
                ))
                : Container(
                width: 64,
                height: 64)),
            (this.widget._LoggedTripList.length > 1 ?
            Text(
                this.widget._LoggedTripList[1].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white))
                : SizedBox(height: 0))
          ],
        ),
        Column(
          children: <Widget>[
            (this.widget._LoggedTripList.length > 0 ?
            Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 15),
                          color: Colors.black.withOpacity(.6),
                          spreadRadius: -9)
                    ]),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        this.widget._LoggedTripList[0].imagelocation == null
                            ? Text(
                          this.widget._LoggedTripList[0].imagelocation,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                            : Image.file(File(this.widget._LoggedTripList[0].imagelocation), width: 96, height: 96),
                      ],
                    ),
                  ),
                  onPressed: () {},
                  color: Colors.white,
                ))
                : Container(
                width: 64,
                height: 64)),
            (this.widget._LoggedTripList.length > 0 ?
            Text(
                this.widget._LoggedTripList[0].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white))
                : SizedBox(height: 0))
          ],
        ),
        Column(
            children: <Widget>[
        (this.widget._LoggedTripList.length > 2 ?
        Container(
        width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      offset: Offset(0, 15),
                      color: Colors.black.withOpacity(.6),
                      spreadRadius: -9)
                ]),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: EdgeInsets.zero,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    this.widget._LoggedTripList[0].imagelocation == null
                        ? Text(
                      this.widget._LoggedTripList[0].imagelocation,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                        : Image.file(File(this.widget._LoggedTripList[0].imagelocation), width: 96, height: 96),
                  ],
                ),
              ),
              onPressed: () {},
              color: Colors.white,
            ))
            : Container(
            width: 64,
            height: 64)),
        (this.widget._LoggedTripList.length > 2 ?
        Text(
            this.widget._LoggedTripList[2].title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white))
        : SizedBox(height: 0))
      ],
    )],
    );
  }
}
