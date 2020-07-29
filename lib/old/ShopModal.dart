//import 'package:app/pages/Shop/Shop.dart';
//import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/pages/Token/TokenInfo.dart';
//import 'package:app/utils/size_config.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class BS extends StatefulWidget {
//  _BS createState() => _BS();
//}
//
//class _BS extends State<BS> {
//  bool _showSecond = false;
//
//  navigateToSubscription(goPremium) {
//    setState(() {
//      _showSecond = goPremium;
//    });
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return TokenInfo();
//
//
//      AnimatedCrossFade(
//        firstChild: Container(
//          height: SizeConfig.blockSizeVertical * 90,
//          child: TokenInfo(this.navigateToSubscription),
//        ),
//        secondChild: Container(
//          height: SizeConfig.blockSizeVertical * 90,
//         // child: Shop(this.navigateToSubscription),
//        ),
//        crossFadeState:
//            _showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//        duration: Duration(milliseconds: 400));
//  }
//}
