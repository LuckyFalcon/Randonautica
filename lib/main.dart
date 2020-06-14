import 'package:app/pages/Feed/TripFeed.dart';
import 'package:app/pages/Lab.dart';
import 'package:app/pages/List/TripList.dart';
import 'package:app/utils/size_config.dart';
import 'components/ListSearchBar.dart';
import 'components/TopBar.dart';
import 'package:app/pages/start/Loading.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'components/BottomBar.dart';
import 'helpers/AppLocalizations.dart';
import 'pages/Randonaut.dart';
import 'utils/BackgroundColor.dart' as backgrounds;

void main() {
  runApp(Randonautica());
}

class Randonautica extends StatelessWidget {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
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
    final initialPlatform = TargetPlatform.iOS;

    return PlatformProvider(
      //Uncomment this to set the platform manually
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
          home: Loading()),
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

  /// TODO Check if this is legit: https://stackoverflow.com/questions/56639529/duplicate-class-com-google-common-util-concurrent-listenablefuture-found-in-modu
  int selectedNavigationIndex = 0;

  final GlobalKey<TripListState> _TripListKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void selectedNavigationIndexCallback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

  void updateListStateCallback() {
    _TripListKey.currentState.updateState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          decoration: (selectedNavigationIndex == 3
              ? backgrounds.dark
              : backgrounds.normal),
          child: Column(children: <Widget>[
            TopBar(),
            IndexedStack(
              children: <Widget>[
                Randonaut(this.updateListStateCallback),
                TripFeed(),
                TripList(key: _TripListKey),
                Lab(),
              ],
              index: selectedNavigationIndex,
            ),
            BottomBar(
                this.selectedNavigationIndexCallback, selectedNavigationIndex),
          ])),
    );
  }
}
