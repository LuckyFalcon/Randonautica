import 'package:app/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import 'helpers/AppLocalizations.dart';
import 'pages/Loading.dart';

void main() {
  //Ensure initilization
  WidgetsFlutterBinding.ensureInitialized();

  //Allow Potrait up mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new Randonautica());
  });
}

class Randonautica extends StatelessWidget {
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        themes: [
          AppTheme(
              id: "default_theme", // Id(or name) of the theme(Has to be unique)
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                brightness: _brightness,
           //     fontFamily: 'Interstate',
                primaryColor: Color(0xff5A87E4),
                accentColor:  Color(0xff36CCDB),
              ),
              description: 'Randonautica Theme'),
          // This is standard dark theme (id is default_dark_theme)
          AppTheme(
              id: "dark_theme", // Id(or name) of the theme(Has to be unique)
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                brightness: _brightness,
              //  fontFamily: 'Interstate',
                primaryColor: Color(0xff383B46),
                accentColor:  Color(0xff5786E1),
              ),
              description: 'Randonautica Theme'),
        ],
        child: ThemeConsumer(
            child: Builder(
                builder: (themeContext) => MaterialApp(
                    //Title
                    title: 'Randonautica',
                    //Theme Data
                    theme: ThemeProvider.controllerOf(themeContext).theme.data,
                    //Localizations
                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('ja', ''),
                      Locale('es', ''),
                      Locale('zh', '')
                    ],
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    //Home Page
                    home: Loading()))));
  }
}
