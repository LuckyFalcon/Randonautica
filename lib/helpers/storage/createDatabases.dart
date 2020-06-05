// basically same as the io runner but with extra output
import 'dart:async';
//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

///Create Databases:
//unLoggedTrips
//LoggedTrips
//Attractors
//Communities
//Inbox
//Profile
//void createDatabase (int selectedNavigationIndex) async{
//  Future createDatabases() async {
//    // get the application documents directory
//    var dir = await getApplicationDocumentsDirectory();
//
//    // make sure it exists
//    await dir.create(recursive: true);
//
//    // build the database path
//    var dbPath = join(dir.path, 'unLoggedTrips.db');
//    var dbPath2 = join(dir.path, 'LoggedTrips.db');
//    var dbPath3 = join(dir.path, 'Attractors.db');
//    var dbPath4 = join(dir.path, 'Communities.db');
//    var dbPath5 = join(dir.path, 'Inbox.db');
//
//    // open the database
//    var db = await databaseFactoryIo.openDatabase(dbPath);
//    var db2 = await databaseFactoryIo.openDatabase(dbPath2);
//    var db3 = await databaseFactoryIo.openDatabase(dbPath3);
//    var db4 = await databaseFactoryIo.openDatabase(dbPath4);
//    var db5 = await databaseFactoryIo.openDatabase(dbPath5);
//  }
//}