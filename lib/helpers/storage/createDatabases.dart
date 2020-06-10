import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabases() async {

  await createUnloggedTripsDatabase();
  await createLoggedTripsDatabase();
  await createNewsDatabase();
  await createFeedDatabase();
  await createAchievementsDatabase();

}

void createUnloggedTripsDatabase() async {

  String unloggedTripsTable = 'unloggedTrips';
  String unloggedTripsDB = 'unloggedTrips.db';

  final String COL1 =   "GID";
  final String COL2 =   "location";
  final String COL3 =   "datetime";
  final String COL4 =   "latitude";
  final String COL5 =   "longitude";
  final String COL6 =   "radius";
  final String COL7 =   "type";
  final String COL8 =   "power";
  final String COL9 =   "z_score";
  final String COL10 =  "pseudo";
  final String COL11 =  "report";

  String createUnloggedTripsTable = "CREATE TABLE " + unloggedTripsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TEXT, " +
      COL2 + " TEXT, " +
      COL3 + " TEXT, " +
      COL4 + " TEXT, " +
      COL5 + " TEXT, " +
      COL6 + " FLOAT, " +
      COL7 + " FLOAT, " +
      COL8 + " FLOAT,   " +
      COL9 +  " FLOAT,   " +
      COL10 +  " BIT,   " +
      COL11 + " BIT)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), unloggedTripsDB),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          createUnloggedTripsTable
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

}
void createLoggedTripsDatabase() async {

  String loggedTripsTable  = 'loggedTrips';
  String loggedTripsDB = 'loggedTrips.db';

  final String COL1 =   "GID";
  final String COL2 =   "location";
  final String COL3 =   "datetime";
  final String COL4 =   "latitude";
  final String COL5 =   "longitude";
  final String COL6 =   "radius";
  final String COL7 =   "type";
  final String COL8 =   "power";
  final String COL9 =   "z_score";
  final String COL10 =  "pseudo";
  final String COL11 =  "favorite";
  final String COL12 =   "reportedtime";
  final String COL13 =   "title";
  final String COL14 =   "text";
  final String COL15 =   "imagelocation";
  final String COL16 =   "tag1";
  final String COL17 =   "tag2";
  final String COL18 =   "tag3";
  final String COL19 =   "tag4";
  final String COL20 =   "tag5";
  final String COL21 =   "tag6";
  final String COL22 =   "tag7";
  final String COL23 =   "tag8";
  final String COL24 =   "tag9";
  final String COL25 =   "tag10";
  final String COL26 =   "tag11";
  final String COL27 =   "tag12";
  final String COL28 =   "tag13";
  final String COL29 =   "tag14";
  final String COL30 =   "tag15";


  String createLoggedTripsTable = "CREATE TABLE " + loggedTripsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TEXT, " +
      COL2 + " TEXT, " +
      COL3 + " TEXT, " +
      COL4 + " TEXT, " +
      COL5 + " TEXT, " +
      COL6 + " FLOAT, " +
      COL7 + " FLOAT, " +
      COL8 + " FLOAT, " +
      COL9 +  " FLOAT, " +
      COL10 +  " BIT, " +
      COL11 +  " BIT, " +
      COL12 + " TEXT, " +
      COL13 + " TEXT, " +
      COL14 + " TEXT, " +
      COL15 + " TEXT, " +
      COL16 + " TEXT, " +
      COL17 + " TEXT, " +
      COL18 + " TEXT, " +
      COL19 + " TEXT, " +
      COL20 + " TEXT, " +
      COL21 + " TEXT, " +
      COL22 + " TEXT, " +
      COL23 + " TEXT, " +
      COL24 + " TEXT, " +
      COL25 + " TEXT, " +
      COL26 + " TEXT, " +
      COL27 + " TEXT, " +
      COL28 + " TEXT, " +
      COL29 + " TEXT, " +
      COL30 + " TEXT)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), loggedTripsDB),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          createLoggedTripsTable
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

}
void createNewsDatabase() async {

  String newsTable  = 'news';
  String newsDB = 'news.db';

  final String COL1 =   "title";
  final String COL2 =   "description";
  final String COL3 =   "previewdescription";
  final String COL4 =   "image"; //Image location
  final String COL5 =   "datetime";
  final String COL6 =   "read";

  String createNewsTable = "CREATE TABLE " + newsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TEXT, " +
      COL2 + " TEXT, " +
      COL3 + " TEXT, " +
      COL4 + " TEXT, " +
      COL5 + " TEXT, " +
      COL6 + " BIT)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), newsDB),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          createNewsTable
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

}
void createFeedDatabase() async {

  String feedTable  = 'feed';
  String feedDB = 'feed.db';

  final String COL1 =   "title";
  final String COL2 =   "description";
  final String COL3 =   "previewdescription";
  final String COL4 =   "image"; //Image location
  final String COL5 =   "datetime";
  final String COL6 =   "favorite";

  String createFeedTable = "CREATE TABLE " + feedTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TEXT, " +
      COL2 + " TEXT, " +
      COL3 + " TEXT, " +
      COL4 + " TEXT, " +
      COL5 + " TEXT, " +
      COL6 + " BIT)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), feedDB),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          createFeedTable
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

}
void createAchievementsDatabase() async {

  String achievementsTable  = 'achievements';
  String achievementsDB = 'achievements.db';

  final String COL0 =   "badgeid";
  final String COL1 =   "title";
  final String COL2 =   "description";
  final String COL3 =   "previewdescription";
  final String COL4 =   "image"; //Image location
  final String COL5 =   "datetime";
  final String COL6 =   "active";

  String createAchievementsTable = "CREATE TABLE " + achievementsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL0 + " INTEGER, " +
      COL1 + " TEXT, " +
      COL2 + " TEXT, " +
      COL3 + " TEXT, " +
      COL4 + " TEXT, " +
      COL5 + " TEXT, " +
      COL6 + " BIT)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), achievementsDB),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          createAchievementsTable
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

}