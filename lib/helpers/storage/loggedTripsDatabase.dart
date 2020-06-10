// Open the database and store the reference.
import 'dart:async';

import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Define a function that inserts dogs into the database
Future<void> insertLoggedTrip(LoggedTrip loggedTrip) async {
  final database = await openDatabase(
      join(await getDatabasesPath(), 'loggedTrips.db'));

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await database.insert(
    'loggedTrips',
    loggedTrip.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<LoggedTrip>> RetrieveLoggedTrips() async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'loggedTrips.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('loggedTrips');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return LoggedTrip(
      gid: maps[i]['gid'],
      location: maps[i]['location'],
      datetime: maps[i]['datetime'],
      latitude: maps[i]['latitude'],
      longitude: maps[i]['longitude'],
      radius: maps[i]['radius'],
      type: maps[i]['type'].toString(),
      power: maps[i]['power'],
      zScore: maps[i]['zScore'],
      pseudo: maps[i]['pseudo'].toString(),
      favorite: maps[i]['favorite'].toString(),
      reportedtime: maps[i]['reportedtime'],
      title: maps[i]['title'],
      text: maps[i]['text'],
      imagelocation: maps[i]['imagelocation'],
      tag1: maps[i]['tag1'],
      tag2: maps[i]['tag2'],
      tag3: maps[i]['tag3'],
      tag4: maps[i]['tag4'],
      tag5: maps[i]['tag5'],
      tag6: maps[i]['tag6'],
      tag7: maps[i]['tag7'],
      tag8: maps[i]['tag8'],
      tag9: maps[i]['tag10'],
      tag10: maps[i]['tag11'],
      tag11: maps[i]['tag12'],
      tag12: maps[i]['tag13'],
      tag13: maps[i]['tag14'],
      tag14: maps[i]['tag15'],
    );
  });
}