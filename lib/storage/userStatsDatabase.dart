// Open the database and store the reference.
import 'dart:async';
import 'package:app/models/User.dart';
import 'package:app/models/UserStats.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Insert user in database
Future<String> insertUserStats(UserStats userStats) async {
  final database = await openDatabase(
      join(await getDatabasesPath(), 'userStats.db'));

  //Currently overwrite the current user
  userStats.id = 1;

  // Insert the User into the correct table. You might also specify the
  // In this case, replace any previous data.
  await database.insert(
    'userstats',
    userStats.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<UserStats> RetrieveUserStats() async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'userStats.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('userstats');
  await db.rawQuery('SELECT * FROM userstats').then((value) =>
  {
    print(value)
  }
  );

  print('length:' + maps.length.toString());
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  var UserList =  List.generate(maps.length, (i) {
    return UserStats(
      id: maps[i]['ID'],
      anomalies: maps[i]['anomalies'],
      attractors:  maps[i]['attractors'],
      voids:  maps[i]['voids'],
      chains:  maps[i]['chains'],
      distance: maps[i]['distance'],
      loggedtrips: maps[i]['loggedtrips'],
      maximumpower: maps[i]['maximumpower'],
      sharewithfriends: maps[i]['sharewithfriends'],
      maximumstreak: maps[i]['maximumstreak'],
    );
  });
  print(UserList.length);
  return UserList[0];
}

// Insert point for user
Future<User> updatePointStats(selectedPoint) async {

  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'userStats.db'));

  //1 = Anomaly, 2 = Attractor, 3 = Void. Anomaly is selected as standard
  if(selectedPoint == 1){
    print('insertinganomaly');
    await db.rawQuery('UPDATE userstats SET anomalies = anomalies + 1');
  } else if(selectedPoint == 2){
    await db.rawQuery('UPDATE userstats SET attractors = attractors + 1');
  } else if(selectedPoint == 3){
    await db.rawQuery('UPDATE userstats SET voids = voids + 1');
  }

}