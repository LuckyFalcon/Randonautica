import 'package:url_launcher/url_launcher.dart';

Future<void> CreateGoogleAccount() async {

    String createGoogleAccountUrl = "https://accounts.google.com/signup?hl=en";

    if (await canLaunch(createGoogleAccountUrl)) {
      await launch(createGoogleAccountUrl);
    } else {
      throw 'Could not create a google account';
    }
}
