import 'package:app/components/Trips/NoTripsFoundButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

import '../TopBar.dart';

class NoTripsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 50),
          ImageIcon(
            AssetImage('assets/img/Owl.png'),
            color: Colors.white,
            size: 128.0,
          ),
          SizedBox(height: 10),
          Text(AppLocalizations.of(context).translate('empty_trip_title'),
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            width: 300.0,
            height: 100.0,
            child: Text(
                AppLocalizations.of(context).translate('empty_trip_list'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          SizedBox(height: 20),
          //NoTripsFoundButton()
        ])
      ]),
    );
  } //Functions
}
