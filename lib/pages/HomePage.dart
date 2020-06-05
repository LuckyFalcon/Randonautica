import 'package:app/components/BottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Randonaut.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  //App Title
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedNavigationIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

  }

  void callback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

  //Selected index for BottomBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            IndexedStack(
              children: <Widget>[
                Randonaut(),
                //MyCommunities(),
                // CreateAccount(),
                //     Invite(),
                // Login(),
                //    Walkthrough(),
                //    Loading(),
                // MyList(),
                //  Lab()
              ],
              index: selectedNavigationIndex, ///TODO make it work with bottombar.dart
            ),
            BottomBar(this.callback, selectedNavigationIndex)
          ],
        ),
      ),
    );
  }
}