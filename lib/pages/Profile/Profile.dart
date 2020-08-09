import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FlipCard.dart';
import 'package:app/models/UserStats.dart';
import 'package:app/storage/userStatsDatabase.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  //Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  //Store UserStats
  UserStats userStats;

  //UserStats loaded from the database
  bool userStatsloaded = false;

  @override
  initState() {
    super.initState();

    initializeUserStats();

  }

  initializeUserStats() async {
    //Get list of logged trips
    Future<UserStats> _futureOfLoggedList = RetrieveUserStats();
    _futureOfLoggedList.then((value) {
      if (value != null) {
        userStats = value;
        print('userStats' + userStats.anomalies.toString());
        setState(() {
          userStatsloaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          decoration: backgrounds.normal,
          child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: Align(
              alignment: Alignment.center,
              child: Container(
                height: SizeConfig.blockSizeVertical * 80,
                width: SizeConfig.blockSizeHorizontal * 80,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: SizeConfig.blockSizeVertical * 80,
                        width: SizeConfig.blockSizeHorizontal * 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                offset: Offset(0, 15),
                                color: Colors.black.withOpacity(.6),
                                spreadRadius: -9)
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(45.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ImageIcon(
                                      AssetImage(
                                          'assets/img/Profile/Settings.png'),
                                      size: 30.0,
                                      color: Color(0xff6284C3)),
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/img/Profile/Down_Arrow.png'),
                                    iconSize: 30,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ImageIcon(
                                      AssetImage(
                                          'assets/img/Profile/Change.png'),
                                      size: 30.0,
                                      color: Color(0xff6284C3)),
                                ],
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 0.5),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Container(
                                  height: SizeConfig.blockSizeVertical * 22,
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ImageIcon(
                                              AssetImage(
                                                  'assets/img/Profile/Postcard.png'),
                                              size: 120.0,
                                              color: Color(0xff6284C3))),
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 18,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Stack(children: <Widget>[
                                              Container(
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      16,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      30,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30.0)),
                                                      border: Border.all(
                                                          width: 3,
                                                          color: Color(
                                                              0xff6284C3)),
                                                    ),
                                                  )),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: ImageIcon(
                                                      AssetImage(
                                                          'assets/img/Profile/Profile.png'),
                                                      size: 120.0,
                                                      color:
                                                          Color(0xff6284C3))),
                                            ]),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 4,
                                                    width: SizeConfig.blockSizeHorizontal * 35,
                                                    child: AutoSizeText(
                                                        'Kerry Blanchard',
                                                        maxLines: 2,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                            Color(0xff6081E2))) ),
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 4,
                                                    width: SizeConfig.blockSizeHorizontal * 35,
                                                    child: AutoSizeText(
                                                        '@kerryblanchard',
                                                        maxLines: 2,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                            Color(0xff6081E2))) ),
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 4,
                                                    width: SizeConfig.blockSizeHorizontal * 35,
                                                    child: AutoSizeText(
                                                        'BOSTON, MA',
                                                        maxLines: 2,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                            Color(0xff6081E2))) ),
                                                Container(
                                                    height: SizeConfig.blockSizeVertical * 4,
                                                    width: SizeConfig.blockSizeHorizontal * 35,
                                                  child:

                                               AutoSizeText(
                                                    'Randonaut Since May 2020',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xff6081E2))) ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                height: SizeConfig.blockSizeVertical * 3,
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: AutoSizeText(
                                    AppLocalizations.of(context)
                                        .translate('stamps')
                                        .toUpperCase(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xff6081E2))),
                              ),
                              Container(
                                  height: SizeConfig.blockSizeVertical * 38,
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      10,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                              child: Image(
                                                image: new AssetImage(
                                                    'assets/img/Stamps/Stamp_1.png'),
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                          ]),
                                    ],
                                  )),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 60,
                                  child: IconButton(
                                icon: new Image.asset(
                                    'assets/img/Profile/Arrow_Line.png'),
                                onPressed: () {
                                  cardKey.currentState.toggleCard();
                                },
                              ))),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            back: Align(
              alignment: Alignment.center,
              child: Container(
                height: SizeConfig.blockSizeVertical * 80,
                width: SizeConfig.blockSizeHorizontal * 80,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: SizeConfig.blockSizeVertical * 80,
                        width: SizeConfig.blockSizeHorizontal * 80,

                        ///This is 70% of the Vertical / Height for this container in this class
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                offset: Offset(0, 15),
                                color: Colors.black.withOpacity(.6),
                                spreadRadius: -9)
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(45.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                    size: 24.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                  Icon(
                                    Icons.audiotrack,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  Icon(
                                    Icons.beach_access,
                                    color: Colors.blue,
                                    size: 36.0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 0.5),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Container(
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: SizedBox(
                                    height: SizeConfig.blockSizeVertical * 0),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical * 2,
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate('stamps')
                                        .toUpperCase(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xff6081E2))),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical * 40,
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 100,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 20,
                                        child: Image(
                                          image: new AssetImage(
                                              'assets/img/Stamps/Stamp_1.png'),
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ]),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: new Icon(Icons.beach_access,
                                      color: Colors.blue, size: 36.0),
                                  onPressed: () {
                                    cardKey.currentState.toggleCard();
                                  },
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
