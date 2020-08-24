library Randonautica.backgrounds;

import 'package:flutter/cupertino.dart';
import 'package:theme_provider/theme_provider.dart';

class Background {


  BoxDecoration getBackground(BuildContext context) {
    var controller = ThemeProvider.controllerOf(context);
    controller.setTheme('dark_theme');
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 100],
            colors: [ controller.theme.data.primaryColor, controller.theme.data.accentColor]));
  }

}

BoxDecoration normal = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 100],
        colors: [Color(0xff5A87E4), Color(0xff36CCDB)]));

BoxDecoration dark = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 6.0],
        colors: [Color(0xff383B46), Color(0xff5786E1)]));

LinearGradient darkGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 6.0],
        colors: [Color(0xff383B46), Color(0xff5786E1)]);
