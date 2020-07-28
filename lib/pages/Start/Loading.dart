import 'dart:io';

import 'package:app/api/signInBackend.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/FadingCircleLoading.dart';
import 'package:app/helpers/storage/setupDatabases.dart';
import 'package:app/helpers/storage/userDatabase.dart';
import 'package:app/models/User.dart';
import 'package:app/pages/Failed/FailedInternet.dart';
import 'package:app/pages/start/Login.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HomePage.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  GoogleSignInAccount _currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
  var PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.randonautica.app';

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt >= 23) {
        //Ask for permissions
        PermissionStatus permission =
            await LocationPermissions().requestPermissions();
      }
    }
    //Check for Internet Connection
    bool result = await DataConnectionChecker().hasConnection;
    if(result != true) {
      Navigator.pushAndRemoveUntil(
          context,
          FadeRoute(page: FailedToInternet()),
          ModalRoute.withName("/FailedToInternet"));
    }

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      } else {
        ///No new version -> Continue to App
        getCurrentUser()
            .then((value) => Future.delayed(Duration(seconds: 3), () {
                  if (value != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        FadeRoute(page: HomePage()),
                        ModalRoute.withName("/HomePage"));
                  } else {
                    print('value' + value.toString());
                    //Setup Databases
                    setupDatabases().then(
                        (value) => Future.delayed(Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  FadeRoute(page: Login()),
                                  ModalRoute.withName("/Login"));
                            }));
                  }
                }))
            .catchError((onError) => Future.delayed(Duration(seconds: 3), () {
                  Navigator.pushAndRemoveUntil(context,
                      FadeRoute(page: Login()), ModalRoute.withName("/Login"));
                }));
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future getCurrentUser() async {
    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;

    if (prefs.getBool("Account") == true) {
      //Get current user
      FirebaseUser _user = await FirebaseAuth.instance.currentUser();

      if (_user != null) {
        var token = await _user.getIdToken();
        await prefs.setString("authToken", token.token);
        await signBackendGoogle(token.token.toString())
            .then((statusCode) async {
          if (statusCode == 200 || statusCode == 409) {
            User user = await RetrieveUser();
            globals.currentUser = user;
          } else {
            print('somethingwentwrong');
            throw ("Login failed"); // error thrown on back-end signin failed
          }
        });
        return _user;
      }
    }
  }

  @override
  void initState() {
    //Remove Status & Navigation bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.yellow[200],
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: Center(
            child: Column(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 25),
                ImageIcon(
                  AssetImage('assets/img/Owl.png'),
                  color: Colors.white,
                  size: 128.0,
                ),
                SizedBox(height: 10),
                Text(AppLocalizations.of(context).translate('title'),
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                FadingCircleLoading(
                  color: Colors.white,
                  size: 75.0,
                )
              ])
            ]),
          )),
    );
  } //Functions
}
