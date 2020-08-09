import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<bool> createDatabases() async {

  await createUnloggedTripsDatabase();
  await createLoggedTripsDatabase();
  await createNewsDatabase();
  await createFeedDatabase();
  await createAchievementsDatabase();

}

void createUnloggedTripsDatabase() async {

  String unloggedTripsTable = 'unloggedTrips';
  String unloggedTripsDB = 'unloggedTrips.db';

  final String COL1 =   "is_visited";
  final String COL2 =   "is_logged";
  final String COL3 =   "is_favorite";
  final String COL4 =   "rng_type";
  final String COL5 =   "point_type";
  final String COL6 =   "title";
  final String COL7 =   "report";
  final String COL8 =   "what_3_words_address";
  final String COL9 =   "what_3_nearest_place";
  final String COL10 =   "what_3_words_country";
  final String COL11 =   "center";
  final String COL12 =   "latitude";
  final String COL13 =   "longitude";
  final String COL14 =   "location";
  final String COL15 =   "gid";
  final String COL16 =   "tid";
  final String COL17 =   "lid";
  final String COL18 =   "type";
  final String COL19 =   "x";
  final String COL20 =   "y";
  final String COL21 =   "distance";
  final String COL22 =   "initial_bearing";
  final String COL23 =   "final_bearing";
  final String COL24 =   "side";
  final String COL25 =   "distance_err";
  final String COL26 =   "radiusM";
  final String COL27 =   "number_points";
  final String COL28 =   "mean";
  final String COL29 =   "rarity";
  final String COL30 =   "power_old";
  final String COL31 =   "power";
  final String COL32 =   "z_score";
  final String COL33 =   "probability_single";
  final String COL34 =   "integral_score";
  final String COL35 =   "significance";
  final String COL36 =   "probability";
  final String COL37 =   "created";

  String createUnloggedTripsTable = "CREATE TABLE " + unloggedTripsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TINYINT, " +
      COL2 + " TINYINT, " +
      COL3 + " TINYINT, " +
      COL4 + " TINYINT, " +
      COL5 + " TINYINT, " +
      COL6 + " NVARCHAR(200), " +
      COL7 + " NVARCHAR(400), " +
      COL8 + " NVARCHAR(100),   " +
      COL9 +  " NVARCHAR(100),   " +
      COL10 +  " NVARCHAR(100),   " +
      COL11 +  " geography,   " +
      COL12 +  " FLOAT(53),   " +
      COL13 +  " FLOAT(53),   " +
      COL14 +  " NVARCHAR(100),   " +
      COL15 +  " FLOAT,   " +
      COL16 +  " FLOAT,   " +
      COL17 +  " FLOAT,   " +
      COL18 +  " FLOAT,   " +
      COL19 +  " FLOAT,   " +
      COL20 +  " FLOAT,   " +
      COL21 +  " FLOAT,   " +
      COL22 +  " FLOAT,   " +
      COL23 +  " FLOAT,   " +
      COL24 +  " FLOAT,   " +
      COL25 +  " FLOAT,   " +
      COL26 +  " FLOAT,   " +
      COL27 +  " FLOAT,   " +
      COL28 +  " FLOAT,   " +
      COL29 +  " FLOAT,   " +
      COL30 +  " FLOAT,   " +
      COL31 +  " FLOAT,   " +
      COL32 +  " FLOAT,   " +
      COL33 +  " FLOAT,   " +
      COL34 +  " FLOAT,   " +
      COL35 +  " FLOAT,   " +
      COL36 + " FLOAT, " +
      COL37 + " TEXT)";

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

  final String COL1 =   "is_visited";
  final String COL2 =   "is_logged";
  final String COL3 =   "is_favorite";
  final String COL4 =   "rng_type";
  final String COL5 =   "point_type";
  final String COL6 =   "title";
  final String COL7 =   "report";
  final String COL8 =   "what_3_words_address";
  final String COL9 =   "what_3_nearest_place";
  final String COL10 =   "what_3_words_country";
  final String COL11 =   "center";
  final String COL12 =   "latitude";
  final String COL13 =   "longitude";
  final String COL14 =   "location";
  final String COL15 =   "gid";
  final String COL16 =   "tid";
  final String COL17 =   "lid";
  final String COL18 =   "type";
  final String COL19 =   "x";
  final String COL20 =   "y";
  final String COL21 =   "distance";
  final String COL22 =   "initial_bearing";
  final String COL23 =   "final_bearing";
  final String COL24 =   "side";
  final String COL25 =   "distance_err";
  final String COL26 =   "radiusM";
  final String COL27 =   "number_points";
  final String COL28 =   "mean";
  final String COL29 =   "rarity";
  final String COL30 =   "power_old";
  final String COL31 =   "power";
  final String COL32 =   "z_score";
  final String COL33 =   "probability_single";
  final String COL34 =   "integral_score";
  final String COL35 =   "significance";
  final String COL36 =   "probability";
  final String COL37 =   "created";
  final String COL40 =   "imagelocation";
  final String COL41 =   "tag1";
  final String COL42 =   "tag2";
  final String COL43 =   "tag3";
  final String COL44 =   "tag4";
  final String COL45 =   "tag5";
  final String COL46 =   "tag6";
  final String COL47 =   "tag7";
  final String COL48 =   "tag8";
  final String COL49 =   "tag9";
  final String COL50 =   "tag10";
  final String COL51 =   "tag11";
  final String COL52 =   "tag12";
  final String COL53 =   "tag13";
  final String COL54 =   "tag14";
  final String COL55 =   "tag15";


  String createLoggedTripsTable = "CREATE TABLE " + loggedTripsTable  + " (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
      COL1 + " TINYINT, " +
      COL2 + " TINYINT, " +
      COL3 + " TINYINT, " +
      COL4 + " TINYINT, " +
      COL5 + " TINYINT, " +
      COL6 + " NVARCHAR(200), " +
      COL7 + " NVARCHAR(600), " +
      COL8 + " NVARCHAR(100),   " +
      COL9 +  " NVARCHAR(100),   " +
      COL10 +  " NVARCHAR(100),   " +
      COL11 +  " geography,   " +
      COL12 +  " FLOAT(53),   " +
      COL13 +  " FLOAT(53),   " +
      COL14 +  " NVARCHAR(100),   " +
      COL15 +  " FLOAT,   " +
      COL16 +  " FLOAT,   " +
      COL17 +  " FLOAT,   " +
      COL18 +  " FLOAT,   " +
      COL19 +  " FLOAT,   " +
      COL20 +  " FLOAT,   " +
      COL21 +  " FLOAT,   " +
      COL22 +  " FLOAT,   " +
      COL23 +  " FLOAT,   " +
      COL24 +  " FLOAT,   " +
      COL25 +  " FLOAT,   " +
      COL26 +  " FLOAT,   " +
      COL27 +  " FLOAT,   " +
      COL28 +  " FLOAT,   " +
      COL29 +  " FLOAT,   " +
      COL30 +  " FLOAT,   " +
      COL31 +  " FLOAT,   " +
      COL32 +  " FLOAT,   " +
      COL33 +  " FLOAT,   " +
      COL34 +  " FLOAT,   " +
      COL35 +  " FLOAT,   " +
      COL36 + " FLOAT, " +
      COL37 + " TEXT, " +
      COL40 + " NVARCHAR(100), " +
      COL41 + " NVARCHAR(100), " +
      COL42 + " NVARCHAR(100), " +
      COL43 + " NVARCHAR(100), " +
      COL44 + " NVARCHAR(100), " +
      COL45 + " NVARCHAR(100), " +
      COL46 + " NVARCHAR(100), " +
      COL47 + " NVARCHAR(100), " +
      COL48 + " NVARCHAR(100), " +
      COL49 + " NVARCHAR(100), " +
      COL50 + " NVARCHAR(100), " +
      COL51 + " NVARCHAR(100), " +
      COL52 + " NVARCHAR(100), " +
      COL53 + " NVARCHAR(100), " +
      COL54 + " NVARCHAR(100), " +
      COL55 + " NVARCHAR(100))";

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
void createUserDatabase() async {

  String userTable  = 'user';
  String userDB = 'user.db';

  final String COL0 =   "platform";
  final String COL1 =   "points";
  final String COL2 =   "isIapSkipWaterPoints";
  final String COL3 =   "isIapExtendRadius";
  final String COL4 =   "isIapLocationSearch"; //Image location
  final String COL5 =   "isIapInappGooglePreview";
  final String COL6 =   "isSharedWithFriends";
  final String COL7 =   "isAgreementAccepted";
  final String COL8 =   "startedSignedInStreakDatetime";
  final String COL9 =   "currentSignedInStreak";

  String createAchievementsTable = "CREATE TABLE " + userTable  + " (ID INTEGER PRIMARY KEY NOT NULL, " +
      COL0 + " INTEGER, " +
      COL1 + " INTEGER, " +
      COL2 + " INTEGER, " +
      COL3 + " INTEGER, " +
      COL4 + " INTEGER, " +
      COL5 + " INTEGER, " +
      COL6 + " INTEGER, " +
      COL7 + " INTEGER, " +
      COL8 + " TEXT, " +
      COL9 + " INTEGER)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), userDB),
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
void createUserStatsDatabase() async {

  String userStatsTable  = 'userstats';
  String userStatsDB = 'userStats.db';

  final String COL0 =   "anomalies";
  final String COL1 =   "attractors";
  final String COL2 =   "voids";
  final String COL3 =   "chains";
  final String COL4 =   "distance";
  final String COL5 =   "loggedtrips"; //Image location
  final String COL6 =   "maximumpower";
  final String COL7 =   "sharewithfriends";
  final String COL8 =   "maximumstreak";

  String createAchievementsTable = "CREATE TABLE " + userStatsTable  + " (ID INTEGER PRIMARY KEY NOT NULL, " +
      COL0 + " INTEGER, " +
      COL1 + " INTEGER, " +
      COL2 + " INTEGER, " +
      COL3 + " INTEGER, " +
      COL4 + " INTEGER, " +
      COL5 + " INTEGER, " +
      COL6 + " INTEGER, " +
      COL7 + " INTEGER, " +
      COL8 + " INTEGER)";

  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), userStatsDB),
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
