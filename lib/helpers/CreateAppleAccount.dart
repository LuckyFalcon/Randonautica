import 'package:url_launcher/url_launcher.dart';

Future<void> CreateAppleAccount() async {

    String createAppleAccountUrl = "https://support.apple.com/HT204316";

    if (await canLaunch(createAppleAccountUrl)) {
      await launch(createAppleAccountUrl);
    } else {
      throw 'Could not create a Apple account';
    }
}
