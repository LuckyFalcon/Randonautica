// Open the database and store the reference.
import 'dart:async';

import 'package:app/models/UnloggedTrip.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase () async {
  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), 'trips.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE trips(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, location TEXT, datetime TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

// Define a function that inserts dogs into the database
Future<void> insertUnloggedTrip(UnloggedTrip unloggedTrip) async {
  final database = await openDatabase(
  join(await getDatabasesPath(), 'trips.db'));

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await database.insert(
    'trips',
    unloggedTrip.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<UnloggedTrip>> RetrieveUnloggedTrips() async {
  // Get a reference to the database.
  final Database db = await openDatabase(
      join(await getDatabasesPath(), 'trips.db'));

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('trips');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return UnloggedTrip(
      location: maps[i]['location'],
      dateTime: maps[i]['datetime'],

    );
  });
}

// Now, use the method above to retrieve all the dogs.

//Future storeUnloggedTrips(
//    //  DateTime dateTime, String location
//    ) async {
//  print('reach1');
//
//  // get the application documents directory
//  var dir = await getApplicationDocumentsDirectory();
//// make sure it exists
//  print('reach1');
//
//  //await dir.create(recursive: true);
//// build the database path
//  print('reach2');
//
//  var dbPath = join(dir.path, 'unLoggedTrips.db');
//  var db = await databaseFactoryIo.openDatabase(dbPath);
//
//  var store = intMapStoreFactory.store('unLoggedTrips');
//
//  var key = await store.add(db, {'Time': DateTime.now().toString(), 'Location': 'Amsterdam'});
//
//// Retrieve the record
//  var record = store.record(key);
//  var readMap = await record.get(db);
//
//  print('reach'+readMap.toString());
//}

//Future<UnloggedTrips> retrieveUnloggedTrips(
////    //  DateTime dateTime, String location
////    ) async {
////  // get the application documents directory
////  var dir = await getApplicationDocumentsDirectory();
////  var dbPath = join(dir.path, 'unLoggedTrips.db');
////  var db = await databaseFactoryIo.openDatabase(dbPath);
////
////
////  var store = intMapStoreFactory.store('unLoggedTrips');
////
////  var finder = Finder(
////      sortOrders: [SortOrder('Time')]);
////  var records = await store.find(db, finder: finder);
////
////  print('reachfind'+records.toString());
////  var map = UnloggedTrips(records);
////
////  return records[0];
//
//}


//Future storeUnloggedTrips2(
//  //  DateTime dateTime, String location
//    ) async {
//  print('reach1');
//
//  // get the application documents directory
//  var dir = await getApplicationDocumentsDirectory();
//// make sure it exists
//  print('reach1');
//
//  //await dir.create(recursive: true);
//// build the database path
//  print('reach2');
//
//  var dbPath = join(dir.path, 'unLoggedTrips.db');
//  var dbPath2 = join(dir.path, 'LoggedTrips.db');
//  var dbPath3 = join(dir.path, 'Attractors.db');
//  var dbPath4 = join(dir.path, 'Communities.db');
//  var dbPath5 = join(dir.path, 'Inbox.db');
//  print('reach3');
//
//  // open the database
//  var db = await databaseFactoryIo.openDatabase(dbPath);
//  var db2 = await databaseFactoryIo.openDatabase(dbPath2);
//  var db3 = await databaseFactoryIo.openDatabase(dbPath3);
//  var db4 = await databaseFactoryIo.openDatabase(dbPath4);
//  var db5 = await databaseFactoryIo.openDatabase(dbPath5);
//  print('reach');
//}

