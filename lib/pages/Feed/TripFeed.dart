import 'package:app/components/Feed/TripFeedEntry.dart';
import 'package:flutter/material.dart';

class TripFeed extends StatefulWidget {
  @override
  State<TripFeed> createState() => TripFeedState();
}

class TripFeedState extends State<TripFeed> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripFeedEntry();
  } //Functions
}


