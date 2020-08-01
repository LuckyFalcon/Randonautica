import 'package:app/components/BottomBar.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/helpers/SignInStreak.dart';
import 'package:app/pages/Feed/TripFeed.dart';
import 'package:app/pages/Lab/Lab.dart';
import 'package:app/pages/List/TripList.dart';
import 'package:app/pages/Randonaut/Randonaut.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.homePageTitle}) : super(key: key);

  final String homePageTitle;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// TODO Check if this is legit: https://stackoverflow.com/questions/56639529/duplicate-class-com-google-common-util-concurrent-listenablefuture-found-in-modu
  int selectedNavigationIndex = 0;

  final GlobalKey<TripListState> _TripListKey = GlobalKey();

  @override
  void initState() {
    SignInStreak(context);
    super.initState();
  }

  void selectedNavigationIndexCallback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
    });
  }

  void updateStateCallback() {
    //Update list state
    _TripListKey.currentState.updateState();
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
          decoration: (selectedNavigationIndex == 3
              ? backgrounds.dark
              : backgrounds.normal),
          child: Column(children: <Widget>[
            TopBar(),
            IndexedStack(
              children: <Widget>[
                Randonaut(this.updateStateCallback),
                TripList(key: _TripListKey),
                TripFeed(),
                Lab(),
              ],
              index: selectedNavigationIndex,
            ),
            BottomBar(
                this.selectedNavigationIndexCallback, selectedNavigationIndex),
          ])),
    );
  }

}
