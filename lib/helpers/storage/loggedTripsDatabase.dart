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
      location: maps[i]['location'],
      datetime: maps[i]['datetime'],

    );
  });
}