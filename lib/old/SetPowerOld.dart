//import 'dart:ui' as ui;
//
//import 'package:app/helpers/Dialogs.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//import '../../helpers/AppLocalizations.dart';
//import 'package:app/utils/currentUser.dart' as globals;
//
//class SetPower extends StatefulWidget {
//  State<StatefulWidget> createState() => new _SetPower();
//}
//
//class _SetPower extends State<SetPower> {
//  double _sigmaX = 0.0; // from 0-10
//  double _sigmaY = 0.0; // from 0-10
//  double _opacity = 0.1; // from 0-1.0
//
//  bool PowerEnabled = false;
//  bool PowerBought = false;
//
//  @override
//  void initState() {
//    ///TODO isSubscriptionEnabled
//    if (globals.currentUser.isIapInappGooglePreview != 0) {
//      PowerBought = true;
//    } else {
//      PowerBought = false;
//    }
//    super.initState();
//  }
//
//  void setWaterPointsEnabled() {
//    setState(() {
//      if (PowerBought) {
//        if (PowerEnabled) {
//          PowerEnabled = false;
//        } else {
//          ///Check if WaterPoints bought
//          PowerEnabled = true;
//        }
//      } else {
//        setBuyDialog(context);
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Column(
//          children: <Widget>[
//            Text(
//                AppLocalizations.of(context)
//                    .translate('power_analysation')
//                    .toUpperCase(),
//                style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 15,
//                    color: Colors.white)),
//            (PowerEnabled
//                ? GestureDetector(
//                    onTap: () {
//                      setWaterPointsEnabled();
//                    },
//                    child: Text(
//                        AppLocalizations.of(context)
//                            .translate('on')
//                            .toUpperCase(),
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 40,
//                            color: Colors.white)),
//                  )
//                : GestureDetector(
//                    onTap: () {
//                      setWaterPointsEnabled();
//                    },
//                    child: Text(
//                        AppLocalizations.of(context)
//                            .translate('off')
//                            .toUpperCase(),
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 40,
//                            color: Color(0xff64E4FF))),
//                  )),
//          ],
//        ),
//      (PowerBought ? SizedBox(height: 0) :  Container(
//            height: 75,
//            width: 75,
//            child: Stack(
//              children: <Widget>[
//                Align(
//                  alignment: Alignment.center,
//                  child: ClipRect(
//                    // <-- clips to the 200x200 [Container] below
//                    child: BackdropFilter(
//                      filter: ui.ImageFilter.blur(
//                        sigmaX: 15.0,
//                        sigmaY: 10.0,
//                      ),
//                      child: Container(
//                        alignment: Alignment.center,
//                        child:
//                        GestureDetector(
//                            onTap: () {
//                              setWaterPointsEnabled();
//                            },
//                            child:  Icon(
//                              Icons.lock,
//                              color: Colors.white,
//                              size: 30.0,
//                            )),
//                      ),
//                    ),
//                  ),
//                )
//              ],
//            )))
//      ],
//    );
//  }
//}
