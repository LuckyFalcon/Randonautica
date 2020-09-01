import 'dart:async';

import 'package:app/components/BottomBar.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/TopBarV2.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/helpers/SignInStreak.dart';
import 'package:app/pages/Randonaut/Randonaut.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.homePageTitle}) : super(key: key);

  final String homePageTitle;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// TODO Check if this is legit: https://stackoverflow.com/questions/56639529/duplicate-class-com-google-common-util-concurrent-listenablefuture-found-in-modu
  int selectedNavigationIndex = 0;

  //final GlobalKey<TripListState> _TripListKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Timer timer;

  @override
  void initState() {
    //SignInStreak(context);

    super.initState();
   // updateToken();
  }

  void selectedNavigationIndexCallback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

  void updateStateCallback() {
    //Update list state
  //  _TripListKey.currentState.updateState();
  }

  void updateToken() async {

    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();

    if (_user != null) {

      //Get token
      var token = await _user.getIdToken(refresh: true);

      print(token.token);
      //Store Token in SharedPreferences
      await prefs.setString("authToken", token.token);

    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          decoration: backgrounds.dark,
          child: Column(children: <Widget>[
           // TopBarV2(),
            Randonaut(),

//            BottomBar(
//                this.selectedNavigationIndexCallback, selectedNavigationIndex),
          ])),
    );
  }
}
