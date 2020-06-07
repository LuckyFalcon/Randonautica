import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class BadgeRow extends StatefulWidget {
  State<StatefulWidget> createState() => new _BadgeRow();
}

class _BadgeRow extends State<BadgeRow> {

  ///Query badges here from Db
 ///Hello func

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
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
                )),
            Text(
                AppLocalizations.of(context)
                    .translate('trip_title')
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
        Column(
          children: <Widget>[
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
                )),
            Text(
                AppLocalizations.of(context)
                    .translate('trip_title')
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
        Column(
          children: <Widget>[
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
                )),
            Text(
                AppLocalizations.of(context)
                    .translate('trip_title')
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        )
      ],
    );
  }
}
