import 'package:flutter/material.dart';

class UnloggedTrip {

  String location;

  String dateTime;

  UnloggedTrip({
    this.location,
    this.dateTime
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'datetime': dateTime,
    };
  }
}
