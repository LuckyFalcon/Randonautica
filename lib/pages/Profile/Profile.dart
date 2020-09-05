//import 'package:app/helpers/AppLocalizations.dart';
//import 'package:app/helpers/FlipCard.dart';
//import 'package:app/models/UserStats.dart';
//import 'package:app/utils/BackgroundColor.dart' as backgrounds;
//import 'package:app/utils/size_config.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//
//class Profile extends StatefulWidget {
//  Profile({Key key}) : super(key: key);
//
//  @override
//  State<Profile> createState() => ProfileState();
//}
//
//class ProfileState extends State<Profile> {
//
//  //Firebase authentication instance
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
//
//  @override
//  initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        resizeToAvoidBottomPadding: false,
//        extendBodyBehindAppBar: true,
//        extendBody: true,
//        body: Container(
//          height: SizeConfig.blockSizeVertical * 100,
//          width: SizeConfig.blockSizeHorizontal * 100,
//          decoration: backgrounds.normal,
//          child: FlipCard(
//            key: cardKey,
//            flipOnTouch: false,
//            front: Align(
//              alignment: Alignment.center,
//              child: Container(
//                height: SizeConfig.blockSizeVertical * 80,
//                width: SizeConfig.blockSizeHorizontal * 80,
//                child: Stack(
//                  children: <Widget>[
//                    Container(
//                        height: SizeConfig.blockSizeVertical * 80,
//                        width: SizeConfig.blockSizeHorizontal * 80,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
//                          boxShadow: [
//                            BoxShadow(
//                                blurRadius: 8,
//                                offset: Offset(0, 15),
//                                color: Colors.black.withOpacity(.6),
//                                spreadRadius: -9)
//                          ],
//                        ),
//                        child: Container(
//                          decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(45.0)),
//                          ),
//                          child: Column(
//                            children: <Widget>[
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 1),
//                              Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  ImageIcon(
//                                      AssetImage(
//                                          'assets/img/Profile/Settings.png'),
//                                      size: 30.0,
//                                      color: Color(0xff6284C3)),
//                                  IconButton(
//                                    icon: new Image.asset(
//                                        'assets/img/Profile/Down_Arrow.png'),
//                                    iconSize: 30,
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                  ImageIcon(
//                                      AssetImage(
//                                          'assets/img/Profile/Change.png'),
//                                      size: 30.0,
//                                      color: Color(0xff6284C3)),
//                                ],
//                              ),
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 0.5),
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 1),
////                              Container(
////                                  height: SizeConfig.blockSizeVertical * 22,
////                                  width: SizeConfig.blockSizeHorizontal * 80,
////                                  child: Stack(
////                                    children: <Widget>[
////                                      Align(
////                                          alignment: Alignment.bottomCenter,
////                                          child: ImageIcon(
////                                              AssetImage(
////                                                  'assets/img/Profile/Postcard.png'),
////                                              size: 120.0,
////                                              color: Color(0xff6284C3))),
////                                      Container(
////                                        height:
////                                            SizeConfig.blockSizeVertical * 18,
////                                        width:
////                                            SizeConfig.blockSizeHorizontal * 80,
////                                        child: Row(
////                                          mainAxisAlignment:
////                                              MainAxisAlignment.center,
////                                          children: <Widget>[
////                                            Stack(children: <Widget>[
////                                              Container(
////                                                  height: SizeConfig
////                                                          .blockSizeVertical *
////                                                      16,
////                                                  width: SizeConfig
////                                                          .blockSizeHorizontal *
////                                                      30,
////                                                  child: Container(
////                                                    decoration: BoxDecoration(
////                                                      color: Colors.white,
////                                                      borderRadius:
////                                                          BorderRadius.all(
////                                                              Radius.circular(
////                                                                  30.0)),
////                                                      border: Border.all(
////                                                          width: 3,
////                                                          color: Color(
////                                                              0xff6284C3)),
////                                                    ),
////                                                  )),
////                                              Align(
////                                                  alignment: Alignment.center,
////                                                  child: ImageIcon(
////                                                      AssetImage(
////                                                          'assets/img/Profile/Profile.png'),
////                                                      size: 120.0,
////                                                      color:
////                                                          Color(0xff6284C3))),
////                                            ]),
////                                            Column(
////                                              children: <Widget>[
////                                                Container(
////                                                    height: SizeConfig.blockSizeVertical * 4,
////                                                    width: SizeConfig.blockSizeHorizontal * 35,
////                                                    child: AutoSizeText(
////                                                        'Kerry Blanchard',
////                                                        maxLines: 2,
////                                                        textAlign: TextAlign.left,
////                                                        style: TextStyle(
////                                                            fontWeight:
////                                                            FontWeight.bold,
////                                                            fontSize: 18,
////                                                            color:
////                                                            Color(0xff6081E2))) ),
////                                                Container(
////                                                    height: SizeConfig.blockSizeVertical * 4,
////                                                    width: SizeConfig.blockSizeHorizontal * 35,
////                                                    child: AutoSizeText(
////                                                        '@kerryblanchard',
////                                                        maxLines: 2,
////                                                        textAlign: TextAlign.left,
////                                                        style: TextStyle(
////                                                            fontWeight:
////                                                            FontWeight.bold,
////                                                            fontSize: 18,
////                                                            color:
////                                                            Color(0xff6081E2))) ),
////                                                Container(
////                                                    height: SizeConfig.blockSizeVertical * 4,
////                                                    width: SizeConfig.blockSizeHorizontal * 35,
////                                                    child: AutoSizeText(
////                                                        'BOSTON, MA',
////                                                        maxLines: 2,
////                                                        textAlign: TextAlign.left,
////                                                        style: TextStyle(
////                                                            fontWeight:
////                                                            FontWeight.bold,
////                                                            fontSize: 18,
////                                                            color:
////                                                            Color(0xff6081E2))) ),
////                                                Container(
////                                                    height: SizeConfig.blockSizeVertical * 4,
////                                                    width: SizeConfig.blockSizeHorizontal * 35,
////                                                  child:
////
////                                               AutoSizeText(
////                                                    'Randonaut Since May 2020',
////                                                    maxLines: 2,
////                                                    textAlign: TextAlign.left,
////                                                    style: TextStyle(
////                                                        fontWeight:
////                                                            FontWeight.bold,
////                                                        fontSize: 18,
////                                                        color:
////                                                            Color(0xff6081E2))) ),
////                                              ],
////                                            )
////                                          ],
////                                        ),
////                                      )
////                                    ],
////                                  )),
//                              SizedBox(height: SizeConfig.blockSizeVertical * 22),
//                              Container(
//                                  height: SizeConfig.blockSizeVertical * 38,
//                                  width: SizeConfig.blockSizeHorizontal * 80,
//                                  child: Column(
//                                    children: <Widget>[
//                                      SizedBox(height: 10),
//                                      Text(AppLocalizations.of(context).translate('coming_soon'),
//                                          style: TextStyle(
//                                              fontSize: 40,
//                                              color: Color(0xff6081E2),
//                                              fontWeight: FontWeight.bold)),
//                                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                                    ],
//                                  )),
//                          Align(
//                            alignment: Alignment.bottomRight,
//                            child: Container(
//                                  width: SizeConfig.blockSizeHorizontal * 60,
//                                  child: IconButton(
//                                icon: new Image.asset(
//                                    'assets/img/Profile/Arrow_Line.png'),
//                                onPressed: () {
//                                  cardKey.currentState.toggleCard();
//                                },
//                              ))),
//                            ],
//                          ),
//                        )),
//                  ],
//                ),
//              ),
//            ),
//            back: Align(
//              alignment: Alignment.center,
//              child: Container(
//                height: SizeConfig.blockSizeVertical * 80,
//                width: SizeConfig.blockSizeHorizontal * 80,
//                child: Stack(
//                  children: <Widget>[
//                    Container(
//                        height: SizeConfig.blockSizeVertical * 80,
//                        width: SizeConfig.blockSizeHorizontal * 80,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
//                          boxShadow: [
//                            BoxShadow(
//                                blurRadius: 8,
//                                offset: Offset(0, 15),
//                                color: Colors.black.withOpacity(.6),
//                                spreadRadius: -9)
//                          ],
//                        ),
//                        child: Container(
//                          decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius:
//                            BorderRadius.all(Radius.circular(45.0)),
//                          ),
//                          child: Column(
//                            children: <Widget>[
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 1),
//                              Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  ImageIcon(
//                                      AssetImage(
//                                          'assets/img/Profile/Settings.png'),
//                                      size: 30.0,
//                                      color: Color(0xff6284C3)),
//                                  IconButton(
//                                    icon: new Image.asset(
//                                        'assets/img/Profile/Down_Arrow.png'),
//                                    iconSize: 30,
//                                    onPressed: () {
//                                      Navigator.pop(context);
//                                    },
//                                  ),
//                                  ImageIcon(
//                                      AssetImage(
//                                          'assets/img/Profile/Change.png'),
//                                      size: 30.0,
//                                      color: Color(0xff6284C3)),
//                                ],
//                              ),
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 0.5),
//                              SizedBox(
//                                  height: SizeConfig.blockSizeVertical * 1),
//                              SizedBox(height: SizeConfig.blockSizeVertical * 22),
//                              Container(
//                                  height: SizeConfig.blockSizeVertical * 38,
//                                  width: SizeConfig.blockSizeHorizontal * 80,
//                                  child: Column(
//                                    children: <Widget>[
//                                      SizedBox(height: 10),
//                                      Text(AppLocalizations.of(context).translate('coming_soon'),
//                                          style: TextStyle(
//                                              fontSize: 40,
//                                              color: Color(0xff6081E2),
//                                              fontWeight: FontWeight.bold)),
//                                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                                    ],
//                                  )),
//                              Align(
//                                  alignment: Alignment.bottomRight,
//                                  child: Container(
//                                      width: SizeConfig.blockSizeHorizontal * 60,
//                                      child: IconButton(
//                                        icon: new Image.asset(
//                                            'assets/img/Profile/Arrow_Line.png'),
//                                        onPressed: () {
//                                          cardKey.currentState.toggleCard();
//                                        },
//                                      ))),
//                            ],
//                          ),
//                        )),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ));
//  }
//}
