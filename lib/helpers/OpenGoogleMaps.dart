import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static Future<void> openMap(double latitude, double longitude) async {
    if (Platform.isIOS) { //iOS open maps
      String googleUrl = "https://www.google.com/maps/place/" +
          latitude.toString() + "+" + longitude.toString() + "/@" +
          latitude.toString() + "+" + longitude.toString() +
          ",14z&zoom=14&mapmode=standard";
      googleUrl = googleUrl.replaceAll("https://", "comgooglemaps://");

      if (await canLaunch(googleUrl)) {
        String coords = latitude.toString() + "," + longitude.toString();
        await launch(
            "comgooglemaps://?q=${coords}&center=${coords}&zoom=14&mapmode=standard");
      } else {
        // Fall back to Apple Maps
        String coords = latitude.toString() + "," + longitude.toString();
        await launch("http://maps.apple.com/?daddr=" + coords);
      }
    } else { //Android open maps
      String googleUrl = "https://www.google.com/maps/place/" +
          latitude.toString() + "+" + longitude.toString() + "/@" +
          latitude.toString() + "+" + longitude.toString() +
          ",14z&zoom=14&mapmode=standard";

      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}