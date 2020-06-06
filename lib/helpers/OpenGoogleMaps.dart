import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    print("test");

    String googleUrl = "https://www.google.com/maps/place/" + latitude.toString() + "+" + longitude.toString() + "/@" + latitude.toString() + "+" + longitude.toString() + ",14z&zoom=14&mapmode=standard";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}