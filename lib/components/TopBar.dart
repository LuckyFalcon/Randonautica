//import 'package:app/helpers/FadeRoute.dart';
//import 'package:app/pages/Profile/Profile.dart';
//import 'package:app/pages/Profile/Settings.dart';
//import 'package:app/pages/Randonaut/Trip/FinishTrip.dart';
//import 'package:app/pages/Shop/Shop.dart';
//import 'package:app/pages/Token/TokenInfo.dart';
//import 'package:app/utils/currentUser.dart' as globals;
//import 'package:app/utils/size_config.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//
//class TopBar extends StatefulWidget {
//
//  State<StatefulWidget> createState() => new _TopBarState();
//}
//
//
//class _TopBarState extends State<TopBar> {
//  @override
//  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//    return Container(
//      height: SizeConfig.blockSizeVertical * 10,
//      width: SizeConfig.blockSizeHorizontal * 100,
//      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//        Container(
//          height: SizeConfig.blockSizeVertical * 10,
//          width: SizeConfig.blockSizeHorizontal * 33.3,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 15, left: 15),
//            child: Align(
//                alignment: Alignment.topLeft,
//                child: Container(
//                    width: SizeConfig.blockSizeHorizontal * 100,
//                    child: Row(
//                      children: <Widget>[
//                        IconButton(
//                          iconSize: 32,
//                          icon:
//                          ImageIcon(
//                              AssetImage(
//                                  'assets/img/Profile/Settings.png'),
//                              size: 30.0,
//                              color: Colors.white,),
//                          onPressed: () {
//                            //open settings
//                            Navigator.push(
//                                context,
//                                FadeRoute(page: Settings()));
//                          },
//                        ),
//                      ],
//                    ))),
//          ),
//        ),
//        Container(
//          height: SizeConfig.blockSizeVertical * 10,
//          width: SizeConfig.blockSizeHorizontal * 33.3,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 0.0, right: 0),
//            child: Align(
//              alignment: Alignment.center,
//              child: IconButton(
//                iconSize: SizeConfig.blockSizeVertical * 100,
//                icon: ImageIcon(
//                  AssetImage('assets/img/Owl.png'),
//                  color: Colors.white,
//                ),
//                onPressed: () {
//
//                },
//              ),
//            ),
//          ),
//        ),
//        Container(
//          height: SizeConfig.blockSizeVertical * 10,
//          width: SizeConfig.blockSizeHorizontal * 33.3,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 15, right: 15),
//            child: Align(
//              alignment: Alignment.topRight,
//              child: IconButton(
//                icon: Icon(
//                  Icons.shopping_cart,
//                  color: Colors.white,
//                  size: 32.0,
//                  semanticLabel:
//                  'Text to announce in accessibility modes',
//                ),
//                onPressed: () {
//                  //open shop
//                  Navigator.push(
//                      context,
//                      FadeRoute(page: Shop()));
//                },
//              ),
//            ),
//          ),
//        ),
//      ]),
//    );
//  }
//}
