import 'package:app/pages/Start/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'helpers/AppLocalizations.dart';

void main() {
  runApp(Randonautica());
}

class Randonautica extends StatelessWidget {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    final materialTheme = new ThemeData(
      primarySwatch: Colors.purple,
      // textTheme: _buildTextTheme
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

    return ThemeProvider(
        themes: [
          AppTheme(
              id: "custom_theme", // Id(or name) of the theme(Has to be unique)
              data: ThemeData(  // Real theme data
                  primaryColor: Colors.black,
                  accentColor: Colors.red,
                  fontFamily: 'Interstate'
              ),
              description: 'Custom theme for Randonautica'
          ),// This is standard light theme (id is default_light_theme)
          AppTheme.dark(), // This is standard dark theme (id is default_dark_theme)

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
                    home:
                        //WarningScreens())
                        Loading()))
            //VisitScreen())
            //PremiumIntro())
            //Loading())

            ));
  }

  TextTheme _buildTextTheme(TextTheme base, Color color) {
    return base.copyWith(
      bodyText2: base.bodyText2.copyWith(
        fontSize: 16,
      ),
      bodyText1: base.bodyText1.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      button: base.button.copyWith(
        color: color,
      ),
      caption: base.caption.copyWith(
        color: color,
        fontSize: 14,
      ),
      headline5: base.headline5.copyWith(
        color: color,
        fontSize: 24,
      ),
      subtitle1: base.subtitle1.copyWith(
        color: color,
        fontSize: 18,
      ),
      headline6: base.headline6.copyWith(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
