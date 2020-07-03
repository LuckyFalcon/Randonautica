
import 'package:app/helpers/storage/createDatabases.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<bool> setupDatabases() async {

  String unloggedTripsDB = 'unloggedTrips.db';
  String loggedTripsDB = 'loggedTrips.db';
  String newsDB = 'news.db';
  String feedDB = 'feed.db';
  String achievementsDB = 'achievements.db';
  String userDB = 'user.db';

  bool unloggedTripsDBExists;
  bool loggedTripsDBExists;
  bool newsDBExists;
  bool feedDBExists;
  bool achievementsDBExists;
  bool userDBExists;

  unloggedTripsDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), loggedTripsDB));
  loggedTripsDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), unloggedTripsDB));
  newsDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), newsDB));
  feedDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), feedDB));
  achievementsDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), achievementsDB));
  userDBExists = await databaseFactory.databaseExists(join(await getDatabasesPath(), userDB));

  if(unloggedTripsDBExists == false){
    await createUnloggedTripsDatabase();
  }
  if(loggedTripsDBExists == false){
    await createLoggedTripsDatabase();
  }
  if(newsDBExists == false){
    await createNewsDatabase();
  }
  if(feedDBExists == false){
    await createFeedDatabase();
  }
  if(achievementsDBExists == false){
    await createAchievementsDatabase();
  }
  if(userDBExists == false){
    await createUserDatabase();
  }

  ///Needs some more work
  return true;


}