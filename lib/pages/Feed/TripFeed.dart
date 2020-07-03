import 'package:app/components/Feed/TripFeedEntry.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/Trips/TripRow.dart';

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

  @override
  Widget build(BuildContext context) {
    return (acceptedAgreement
        ? Center(
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
                      return new SizedBox(height: 10); ///Return child widgets here
                    }),
              ],
            ),
          ),
        ],
      ),
    )
        : TripFeedEntry());
    //ListSearchBar();
  } //Functions
}


