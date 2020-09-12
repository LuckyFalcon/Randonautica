import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:fatumbot/helpers/FadeRoute.dart';
import 'package:fatumbot/pages/Walkthrough.dart';
import 'package:fatumbot/utils/BackgroundColor.dart' as backgrounds;
import 'package:fatumbot/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//  //Firebase authentication instance
//  final FirebaseAuth _auth = FirebaseAuth.instance;

//  //Google/iOS Application App Store URLs
//  var APP_STORE_URL = 'https://apps.apple.com/us/app/randonautica/id1493743521';
//  var PLAY_STORE_URL =
//      'https://play.google.com/store/apps/details?id=com.randonautica.app';

//  _versionCheck(context) async {
//    //Get Current installed version of app
//    final PackageInfo info = await PackageInfo.fromPlatform();
//    double currentVersion =
//        double.parse(info.version.trim().replaceAll(".", ""));
//
//    //Get Latest version info from firebase config
//    final RemoteConfig remoteConfig = await RemoteConfig.instance;
//
//    //Ask permission on Android for SDK above 23
//    if (Platform.isAndroid) {
//      var androidInfo = await DeviceInfoPlugin().androidInfo;
//      var sdkInt = androidInfo.version.sdkInt;
//      if (sdkInt >= 23) {
//        //Ask for permissions
//        var Permissions = await LocationPermissions()
//            .requestPermissions()
//            .then((value) => {print(value)});
//      }
//    }

  //Check for Internet Connection
//    bool result = await DataConnectionChecker().hasConnection;
//    if (result != true) {
//      noInternetConnectionDialog(context, _enableInternet);
//    }

//    UserStats userStats;
//    userStats = UserStats(
//      id: 0,
//      anomalies: 0,
//      attractors: 0,
//      voids: 0,
//      chains: 0,
//      distance: 0,
//      loggedtrips: 0,
//      sharewithfriends: 0,
//      maximumpower: 0,
//      maximumstreak: 0
//    );
//
//    insertUserStats(userStats);
//
//    try {
//      // Using default duration to force fetching from remote server.
//      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//      await remoteConfig.activateFetched();
//      remoteConfig.getString('force_update_current_version');
//      double newVersion = double.parse(remoteConfig
//          .getString('force_update_current_version')
//          .trim()
//          .replaceAll(".", ""));
//
//      //A new version is available in the Google/Apple Store
//      if (newVersion > currentVersion) {
//        _showVersionDialog(context);
//      } else {
//        ///No new version -> Get User -> Continue to App
//        await getCurrentUser()
//            .then((value) => {
//                  if (value != null)
//                    {}
//                  else
//                    {
//                      //Setup Databases
////                      setupDatabases().then(
////                          (value) => Future.delayed(Duration(seconds: 3), () {
////                                Navigator.pushAndRemoveUntil(
////                                    context,
////                                    FadeRoute(page: Login()),
////                                    ModalRoute.withName("/Login"));
////                              }))
//                    }
//                })
//            .catchError((onError) => Future.delayed(Duration(seconds: 3), () {
//                  print(onError);
////                  Navigator.pushAndRemoveUntil(context,
////                  //    FadeRoute(page: Login()), ModalRoute.withName("/Login"));
////                }));
//      }
//    } on FetchThrottledException catch (exception) {
//      // Fetch throttled.
//      print('fetchTrotttledException' + exception.toString());
//    } catch (exception) {
//      print('Unable to fetch remote config. Cached or default values will be '
//          'used');
//    }
  // }

//  _enableInternet() async {
//    //A delay so the user gets feedback from turning on their Internet connection
//    Future.delayed(const Duration(milliseconds: 2000), () {
//      _versionCheck(context);
//    });
//  }
//
//  _showVersionDialog(context) async {
//    await showDialog<String>(
//      context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        String title = "New Update Available";
//        String message =
//            "There is a newer version of app available please update it now.";
//        String btnLabel = "Update Now";
//        String btnLabelCancel = "Later";
//        return Platform.isIOS
//            ? new CupertinoAlertDialog(
//                title: Text(title),
//                content: Text(message),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text(btnLabel),
//                    onPressed: () => _launchURL(APP_STORE_URL),
//                  ),
//                  FlatButton(
//                    child: Text(btnLabelCancel),
//                    onPressed: () => Navigator.pop(context),
//                  ),
//                ],
//              )
//            : new AlertDialog(
//                title: Text(title),
//                content: Text(message),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text(btnLabel),
//                    onPressed: () => _launchURL(PLAY_STORE_URL),
//                  ),
//                  FlatButton(
//                    child: Text(btnLabelCancel),
//                    onPressed: () => Navigator.pop(context),
//                  ),
//                ],
//              );
//      },
//    );
//  }

//  _launchURL(String url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

//  getCurrentUser() async {
//    //Await SharedPreferences future object
//    final SharedPreferences prefs = await _prefs;
//
//    if (prefs.getBool("Account") == true) {
//      //Get current user
//      FirebaseUser _user = await _auth.onAuthStateChanged.first;
//
//      if (_user != null) {
  //Get token
//        return await _user.getIdToken().then((token) async => {
//              //Store Token in SharedPreferences
//              await prefs.setString("authToken", token.token),
//              await signBackendGoogle(token.token.toString())
//                  .then((statusCode) async {
//                print(statusCode);
//                //Status codes: 409 Account Already exists, 200 Account successfully created
//                if (statusCode == 200 || statusCode == 409) {
//                  //Get user from DB
//               //   User user = await RetrieveUser();
//                  //Set Global User
//              //    globals.currentUser = user;
//
//                  return 1;
//                } else {
//                  //An error occurred running the above logic
//                  throw Exception('Failed to get User');
//                }
//              })
//            });
//      } else {
//        //No current user
//        throw Exception('Failed to get User');
//      }
//    }
//  }

  @override
  void initState() {
    super.initState();
    doCheck(context);
  }

  void doCheck(context) async {
    //Await SharedPreferences future object
//    final SharedPreferences prefs = await _prefs;
//
//    //Get Token
//    bool seenTutorial = prefs.getBool("tutorial");

    //  if (seenTutorial != null) {
    //Go to homepage
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, FadeRoute(page: HomePage()),
          ModalRoute.withName("/HomePage"));
    });
//    } else {
//      //Go to walktrhough
//       await prefs.setBool("tutorial", true);
//       Future.delayed(Duration(seconds: 3), () {
//        Navigator.pushAndRemoveUntil(context, FadeRoute(page: Walkthrough()),
//            ModalRoute.withName("/Walkthrough"));
//      });
//    }
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
          decoration: backgrounds.dark,
          child: Center(
            child: Column(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 25),
                ImageIcon(
                  AssetImage('assets/img/Owl.png'),
                  color: Colors.white,
                  size: 128.0,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1),
                Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeHorizontal * 13,
                    child: AutoSizeText(
                        AppLocalizations.of(context).translate('title'),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeHorizontal * 18,
                    child: LoadingBouncingGrid.square(
                      borderColor: Colors.cyan,
                      borderSize: 3.0,
                      backgroundColor: Colors.cyanAccent,
                      duration: Duration(milliseconds: 500),
                    )),
                SizedBox(height: SizeConfig.blockSizeVertical * 18),
                Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeHorizontal * 13,
                    child: AutoSizeText(
                        AppLocalizations.of(context).translate('fatum_project'),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ])
            ]),
          )),
    );
  } //Functions

}