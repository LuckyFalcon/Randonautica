
import 'package:app/components/BottomBar.dart';
import 'package:app/pages/Feed/TripFeed.dart';
import 'package:app/pages/Lab.dart';
import 'package:app/pages/List/TripList.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/pages/Randonaut.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.homePageTitle}) : super(key: key);

  final String homePageTitle;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// TODO Check if this is legit: https://stackoverflow.com/questions/56639529/duplicate-class-com-google-common-util-concurrent-listenablefuture-found-in-modu
  int selectedNavigationIndex = 0;
  int selectedNavigation = 0;

  final GlobalKey<TripListState> _TripListKey = GlobalKey();

  List<Widget> pageList = List<Widget>();

  bool openlab = false;

  @override
  void initState() {
    super.initState();
  }


  void selectedNavigationIndexCallback(int selectedNavigationIndex) {
    setState(() {
      this.selectedNavigationIndex = selectedNavigationIndex;
      if(selectedNavigationIndex == 3 && openlab == true){  //Check if lab is open
        selectedNavigation = 0;
      } else {
        selectedNavigation = selectedNavigationIndex;
      }
    });
  }

  void updateStateCallback() {
    _TripListKey.currentState.updateState();

    setState(() {

    });
  }

  void openLabCallback(bool labOpen) {
    setState(() {
      openlab = true;
      this.selectedNavigation = 0;
    });
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
              ? BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 5.0],
                  colors: [Color(0xff383B46), Color(0xff5786E1)]))
              : backgrounds.normal),
          child: Column(children: <Widget>[
            TopBar(),
            IndexedStack(
              children: <Widget>[
                Randonaut(this.updateStateCallback, selectedNavigationIndex),
                TripList(key: _TripListKey),
                TripFeed(),
                Lab(this.openLabCallback),
              ],
              index: selectedNavigation,
            ),
            BottomBar(
                this.selectedNavigationIndexCallback, selectedNavigationIndex),
          ])),
    );
  }
}