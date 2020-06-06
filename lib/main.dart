import 'package:app/helpers/storage/TripsDatabase.dart';
import 'package:app/pages/Lab.dart';
import 'package:app/pages/News.dart';
import 'package:app/pages/MyList.dart';
import 'package:app/pages/MyListDetails.dart';
import 'package:app/pages/Profile.dart';
import 'package:app/pages/TripFeed.dart';
import 'package:app/pages/start/Loading.dart';
import 'package:app/pages/walkthrough/Walkthrough.dart';
import 'package:flutter/services.dart';

import 'components/BottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'helpers/AppLocalizations.dart';
import 'models/UnloggedTrip.dart';
import 'pages/Randonaut.dart';
import 'package:app/models/map_pin_pill.dart';
import 'package:app/models/pin_pill_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.422, -122.084);

void main() {

  runApp(Randonautica());
}


class Randonautica extends StatelessWidget {

  Brightness brightness = Brightness.light;
  @override
  Widget build(BuildContext context) {
    // This widget is the root of your application.
    final materialTheme = new ThemeData(
      primarySwatch: Colors.purple,
    );
    final materialDarkTheme = new ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.teal,
    );

    final cupertinoTheme = new CupertinoThemeData(
      brightness: brightness, // if null will use the system theme
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.purple,
        darkColor: Colors.cyan,
      ),
    );

    //Set platform manually
    /// It can be set to IOS to force cupertino transistions or be changed later, check the link for more info.
    /// https://stackoverflow.com/questions/51663793/how-to-use-cupertinopageroute-and-named-routes-in-flutter
    /// it can be either set to IOS/Android or neither and let it decide for itself which platform it is on.
    final initialPlatform = TargetPlatform.iOS; //TODO uncomment

    return PlatformProvider(

      //TODO Uncomment this to set the platform manually
      initialPlatform: initialPlatform,
       settings: PlatformSettingsData(
         platformStyle: PlatformStyleData(
           android: PlatformStyle.Cupertino,
         ),
       ),
      builder: (context) => PlatformApp(

        //Title
        title: 'Randonautica',

        //Theme Data
        android: (_) {
          return new MaterialAppData(
            theme: materialTheme,
            darkTheme: materialDarkTheme,

            themeMode: brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
          );

        },
        ios: (_) => new CupertinoAppData(
          theme: cupertinoTheme,
        ),

        //Localizations
        supportedLocales: [
          Locale('en', 'US'),
          Locale('jp', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],

        //Home Page
        home:
            ///ENABLE LOADING HERE
        // Walkthrough()
       // Loading()
        HomePage(title: 'Randonautica'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  //App Title
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedNavigationIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Create a Dog and add it to the dogs table.
    final fido = UnloggedTrip(
        location: 'Amsterdam',
        dateTime: DateTime.now().toIso8601String()
    );
   // storeUnloggedTrips();
  //  retrieveUnloggedTrips();
//    createDatabase();
//    insertUnloggedTrip(fido);
//    print(RetrieveUnloggedTrips().then((value) => print(value.length))); // Prints a list that include Fido.

  }

  void callback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

    //Selected index for BottomBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            IndexedStack(
              children: <Widget>[
                //News(),
                Walkthrough(),
                Randonaut(),

                TripFeed(),

                //MyCommunities(),
               // CreateAccount(),
           //     Invite(),
               // Login(),
            //    Walkthrough(),
            //    Loading(),
                MyList(),
            //  Detail(),
                Lab()
              ],
              index: selectedNavigationIndex,
            ),

          BottomBar(this.callback, selectedNavigationIndex)
          ],
        ),
      ),
    );
  }
}