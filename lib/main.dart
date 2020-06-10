import 'package:app/pages/Lab.dart';
import 'package:app/pages/MyList.dart';
import 'package:app/pages/TripFeed.dart';
import 'package:app/pages/start/Loading.dart';
import 'package:flutter/services.dart';

import 'components/BottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'helpers/AppLocalizations.dart';
import 'helpers/storage/createDatabases.dart';
import 'pages/Randonaut.dart';

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
          //  Walkthrough()
        Loading()
      //  HomePage(homePageTitle: 'Randonautica'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.homePageTitle}) : super(key: key);

  final String homePageTitle;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedNavigationIndex = 0;

  @override
  void initState() {
    super.initState();

    //Remove Status & Navigation bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    ///TODO move this to loading
    createDatabases();

  }

  void selectedNavigationIndexCallback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            IndexedStack(
              children: <Widget>[
                Randonaut(),
                TripFeed(),
                MyList(),
                Lab()
              // News(),
              // Walkthrough(),
              // MyCommunities(),
              // CreateAccount(),
              // Invite(),
              // Login(),
              // Walkthrough(),
              // Loading(),
              // Detail(),
              ],
              index: selectedNavigationIndex,
            ),
          BottomBar(this.selectedNavigationIndexCallback, selectedNavigationIndex)
          ],
        ),
      ),
    );
  }
}