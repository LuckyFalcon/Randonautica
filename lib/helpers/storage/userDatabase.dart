// Open the database and store the reference.
import 'dart:async';

import 'package:app/models/UnloggedTrip.dart';
import 'package:app/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Define a function that inserts dogs into the database
Future<String> insertUser(User user) async {
  final database = await openDatabase(
  join(await getDatabasesPath(), 'user.db'));

  user.id = 1;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await database.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<User> RetrieveUser() async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('user');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  var UserList =  List.generate(maps.length, (i) {
    return User(
      platform: maps[i]['platform'],
      points:  maps[i]['points'],
      isIapSkipWaterPoints:  maps[i]['isIapSkipWaterPoints'],
      isIapExtendRadius:  maps[i]['isIapExtendRadius'],
      isIapLocationSearch: maps[i]['isIapLocationSearch'],
      isIapInappGooglePreview: maps[i]['isIapInappGooglePreview'],
    );
  });

  return UserList[0];
}


// Enable Skip Water Points for the user
Future<User> enableIsIapSkipWaterPoints() async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.rawQuery('UPDATE user SET isIapSkipWaterPoints=1 WHERE ID=1');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  var UserList =  List.generate(maps.length, (i) {
    return User(
      platform: maps[i]['platform'],
      points:  maps[i]['points'],
      isIapSkipWaterPoints:  maps[i]['isIapSkipWaterPoints'],
      isIapExtendRadius:  maps[i]['isIapExtendRadius'],
      isIapLocationSearch: maps[i]['isIapLocationSearch'],
      isIapInappGooglePreview: maps[i]['isIapInappGooglePreview'],
    );
  });

  return UserList[0];

}


// A method that retrieves all the dogs from the dogs table.
void DeleteUnloggedTrip(int id) async {

  String Table = 'unloggedTrips';

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'unloggedTrips.db'));

  // Delete row from database
  String dbQuery = ('''
          DELETE FROM $Table
          WHERE ID = $id;
          ''');

  // Execute the query
  return db.execute(dbQuery);
}
