// Open the database and store the reference.
import 'dart:async';
import 'package:app/models/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Insert user in database
Future<String> insertUser(User user) async {
  final database = await openDatabase(
  join(await getDatabasesPath(), 'user.db'));

  //Currently overwrite the current user
  user.id = 1;

  // Insert the User into the correct table. You might also specify the
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
      isSharedWithFriends: maps[i]['isSharedWithFriends'],
      isAgreementAccepted: maps[i]['isAgreementAccepted'],
      startedSignedInStreakDatetime: maps[i]['startedSignedInStreakDatetime'],
      currentSignedInStreak: maps[i]['currentSignedInStreak'],
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
      isSharedWithFriends: maps[i]['isSharedWithFriends'],
    );
  });

  return UserList[0];

}


// Enable Sharing With Friends for the user
Future<User> enableIsSharedWithFriends() async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.rawQuery('UPDATE user SET isSharedWithFriends=1, points = points + 3 WHERE ID=1');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  var UserList =  List.generate(maps.length, (i) {
    return User(
      platform: maps[i]['platform'],
      points:  maps[i]['points'],
      isIapSkipWaterPoints:  maps[i]['isIapSkipWaterPoints'],
      isIapExtendRadius:  maps[i]['isIapExtendRadius'],
      isIapLocationSearch: maps[i]['isIapLocationSearch'],
      isIapInappGooglePreview: maps[i]['isIapInappGooglePreview'],
      isSharedWithFriends: maps[i]['isSharedWithFriends'],
    );
  });

  return UserList[0];

}
