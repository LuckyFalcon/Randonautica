import 'package:app/components/LabButton.dart';
import 'package:app/components/TripFeedEntryButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

import 'TopBar.dart';

class TripFeedEntry extends StatelessWidget {

  bool labButtonPress = false;

  void callback(bool labButtonPress) {
      this.labButtonPress = labButtonPress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody:true,
      backgroundColor: Colors.yellow[200],
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: Center(
            child: Column(
                children: <Widget> [
                  TopBar(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        ImageIcon(
                          AssetImage('assets/img/Owl.png'),
                          color: Colors.white,
                          size: 128.0,
                        ),
                        SizedBox(height: 10),
                        Text(
                            AppLocalizations.of(context)
                                .translate('trip_entry_title'),
                            style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 300.0,
                          height: 100.0,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('trip_entry_description'),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        SizedBox(height: 20),
                        TripFeedEntryButton()
                      ])
                ]
            ),
          )),
    );
  } //Functions
}
