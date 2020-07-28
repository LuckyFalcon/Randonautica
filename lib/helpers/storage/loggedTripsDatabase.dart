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
  // In this case, replace any previous data.
  await database.insert(
    'loggedTrips',
    loggedTrip.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  print('sucess');
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
      id: maps[i]['ID'],
      is_visited:  maps[i]['is_visited'],
      is_logged:  maps[i]['is_logged'],
      is_favorite:  maps[i]['is_favorite'],
      rng_type: maps[i]['rng_type'],
      point_type: maps[i]['point_type'],
      title:  maps[i]['title'].toString(),
      report: maps[i]['report'].toString(),
      what_3_words_address: maps[i]['what_3_words_address'].toString(),
      what_3_nearest_place: maps[i]['what_3_nearest_place'].toString(),
      what_3_words_country: maps[i]['what_3_words_country'].toString(),
      center: maps[i]['center'].toString(),
      latitude: maps[i]['latitude'].toString(),
      longitude: maps[i]['longitude'].toString(),
      location: maps[i]['location'].toString(),
      gid: maps[i]['gid'].toString(),
      tid: maps[i]['tid'].toString(),
      lid: maps[i]['lid'].toString(),
      type: maps[i]['type'].toString(),
      x: maps[i]['x'].toString(),
      y: maps[i]['y'].toString(),
      distance: maps[i]['distance'].toString(),
      initial_bearing: maps[i]['initial_bearing'].toString(),
      final_bearing: maps[i]['final_bearing'].toString(),
      side: maps[i]['side'].toString(),
      distance_err: maps[i]['distance_err'].toString(),
      radiusM: maps[i]['radiusM'].toString(),
      number_points: maps[i]['number_points'].toString(),
      mean: maps[i]['mean'].toString(),
      rarity: maps[i]['rarity'].toString(),
      power_old:maps[i]['power_old'].toString(),
      power: maps[i]['power'].toString(),
      z_score: maps[i]['z_score'].toString(),
      probability_single: maps[i]['probability_single'].toString(),
      integral_score: maps[i]['integral_score'].toString(),
      significance: maps[i]['significance'].toString(),
      probability: maps[i]['probability'].toString(),
      created: maps[i]['created'].toString(),
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