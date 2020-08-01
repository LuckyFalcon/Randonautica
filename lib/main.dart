import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/pages/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:theme_provider/theme_provider.dart';

import 'helpers/AppLocalizations.dart';

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
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        themes: [
          AppTheme(
              id: "custom_theme", // Id(or name) of the theme(Has to be unique)
              data: ThemeData(
                  // Real theme data
                  primaryColor: Colors.black,
                  accentColor: Colors.red,
                  fontFamily: 'Interstate'),
              description: 'Custom theme for Randonautica'),
          // This is standard dark theme (id is default_dark_theme)
          AppTheme.dark(),
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
                        //Invite()))
                        //WarningScreens())
                        Loading()))
                        //VisitScreen())
                        //PremiumIntro())
                        //Loading())
            ));
  }
}
