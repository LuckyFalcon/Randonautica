import 'dart:ui';

import 'package:fatumbot/api/getAttractors.dart';
import 'package:fatumbot/components/Dialogs/DialogButton.dart';
import 'package:fatumbot/helpers/FadeRoute.dart';
import 'package:fatumbot/models/Attractors.dart';
import 'package:fatumbot/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppLocalizations.dart';

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/Andronaut.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Anomaly Found",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Great! Now carefully go to the point. Always procceed with caution. Do not attempt to enter or explore unsafe environments!",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      }).then((exit) {
    if (exit == null) return;

    if (exit) {
      // user pressed Yes button
    } else {
      // user pressed No button
    }
  });
}

setRadiusDialog(BuildContext context, callback) {
  var _radiusInputController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('change_radius'),
          ),
          content: Text(
            AppLocalizations.of(context).translate('change_radius_dialog_text'),
          ),
          actions: <Widget>[
            CupertinoTextField(
                placeholder: AppLocalizations.of(context)
                    .translate('radius_initial_text'),
                controller: _radiusInputController),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                callback(_radiusInputController.text);
              },
              child: Text(
                AppLocalizations.of(context).translate('ok_button'),
              ),
            ),
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context).translate('cancel_button'),
              ),
            )
          ],
        );
      });
}

setBuyDialog(BuildContext context) {
  var AutoSizeTextGroup = AutoSizeGroup();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 33,
                      width: SizeConfig.blockSizeHorizontal * 80,

                      ///This is 70% of the Vertical / Height for this container in this class
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        border: Border.all(width: 10, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 6), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                          border:
                          Border.all(width: 1, color: Color(0xffB1B1B1)),
                        ),
                        child: Column(
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/img/Owl.png'),
                                color: Colors.green, size: 64),
                            Container(
                                height: SizeConfig.blockSizeVertical * 2,
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: Material(
                                    color: Colors.white,
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('uh_oh')
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        group: AutoSizeTextGroup,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)))),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                                height: SizeConfig.blockSizeVertical * 5,
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: Material(
                                    color: Colors.white,
                                    child: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('access_when_premium')
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        group: AutoSizeTextGroup,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue)))),
                            SizedBox(height: SizeConfig.blockSizeVertical * 3),
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 70,
                                height: SizeConfig.blockSizeVertical * 8,
                                decoration: BoxDecoration(
                                    color: Color(0xff5D7FE0),
                                    borderRadius: BorderRadius.circular(60),
                                    boxShadow: []),
                                child: RaisedButton(
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 6),
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('go_to_store')
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10),
                                        Icon(Icons.arrow_forward,
                                            size: 24, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                              const Radius.circular(90.0),
                                              topRight:
                                              const Radius.circular(90.0)),
                                        ),
                                        useRootNavigator: false,
                                        context: context,
                                        builder: (context) =>
                                            Container(
                                              height:
                                              SizeConfig.blockSizeVertical *
                                                  90,
                                              decoration: new BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment
                                                          .topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: [
                                                        0,
                                                        5.0
                                                      ],
                                                      colors: [
                                                        Color(0xff383B46),
                                                        Color(0xff5786E1)
                                                      ]),
                                                  color: Theme
                                                      .of(
                                                      context)
                                                      .primaryColor,
                                                  borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft: const Radius
                                                          .circular(90.0),
                                                      topRight: const Radius
                                                          .circular(90.0))),
                                              child: Container(
                                                height: SizeConfig
                                                    .blockSizeVertical *
                                                    90,
                                                //child: Shop(),
                                              ),
                                            ));
                                  },
                                  color: Color(0xff44C5DB),
                                ))
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 125,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff5D7FE0),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: []),
                          child: RaisedButton(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xff5889E1),
                          )))
                ],
              ),
            ),
          ),
        );
      });
}

showAgreementDialog(BuildContext context, Function callback) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 30,
                      width: SizeConfig.blockSizeHorizontal * 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        border: Border.all(width: 10, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: Offset(0, 6), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                          border:
                          Border.all(width: 1, color: Color(0xffB1B1B1)),
                        ),
                        child: Column(
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/img/Owl.png'),
                                color: Colors.green, size: 64),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('uh_oh')
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue)),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('access_when_premium')
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue)),
                            SizedBox(height: SizeConfig.blockSizeVertical * 3),
                            Container(
                                width: SizeConfig.blockSizeHorizontal * 70,
                                height: SizeConfig.blockSizeVertical * 8,
                                decoration: BoxDecoration(
                                    color: Color(0xff5D7FE0),
                                    borderRadius: BorderRadius.circular(60),
                                    boxShadow: []),
                                child: RaisedButton(
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 6),
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('go_to_store')
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(width: 10),
                                        Icon(Icons.arrow_forward,
                                            size: 24, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    callback(true);
                                  },
                                  color: Color(0xff44C5DB),
                                ))
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 125,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xff5D7FE0),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: []),
                          child: RaisedButton(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back_ios,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {

                            },
                            color: Color(0xff5889E1),
                          )))
                ],
              ),
            ),
          ),
        );
      });
}

findingPointFailedDialog(BuildContext context, Function callback) async {
  dialogRetrievePointCallback() {
    callback(); //Return retry to Randonaut page
  }

  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 32,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 35,
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
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                            Container(
//                              height: SizeConfig.blockSizeVertical * 7.5,
////                              child: ImageIcon(AssetImage('assets/img/Owl.png'),
////                                  color: Color(0xff6081E2), size: 64),
//                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'failed_dialog_description_1')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'failed_dialog_description_2')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            DialogButton(dialogRetrievePointCallback,
                                "failed_dialog_yes"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                            DialogButton(
                                dialogCancelCallback, "failed_dialog_no"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}


loadingpoint(BuildContext context, Function callback, radius, currentLocation,
    selectedPoint, selectedRandomness, checkWater) async {
  dialogRetrievePointCallback() {
    callback(); //Return retry to Randonaut page
  }

  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new BackdropFilter
          (
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 32,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
              Container(
              height: SizeConfig.blockSizeVertical * 35,
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
                  ),
                  child: Column(
                    children: [
                      FutureBuilder<Attractors>(
                          future: fetchAttractors(
                              radius,
                              currentLocation.latitude,
                              currentLocation.longitude,
                              selectedPoint,
                              selectedRandomness,
                              checkWater),
                          builder:
                              (BuildContext context, AsyncSnapshot<Attractors> snapshot) {
                            if (snapshot.hasData) {
                              callback(snapshot.data);

                              //A delay so the navigator can pop
                              Future.delayed(const Duration(milliseconds: 3000), () {
                                Navigator.pop(
                                    context); //Go back to previous navigation item
                              });
                            }
                            if (snapshot.hasError) {
                              Navigator.pop(context); //Go back to previous navigation item

                              //Small delay for popup
                              Future.delayed(const Duration(milliseconds: 500), () {
                                callback(snapshot.data);
                              });
                            }
                            return Center(
                              child: Column(children: <Widget>[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: SizeConfig.blockSizeVertical * 3),
                                      Container(
                                        height: SizeConfig.blockSizeVertical * 5,
                                        width: SizeConfig.blockSizeHorizontal * 33.3,
//                            child: Padding(
//                              padding:
//                                  const EdgeInsets.only(top: 0.0, right: 0),
//                              child: Align(
//                                alignment: Alignment.center,
//                                child: IconButton(
//                                  iconSize: SizeConfig.blockSizeVertical * 100,
//                                  icon: ImageIcon(
//                                    AssetImage('assets/img/Owl.png'),
//                                    color: Colors.white,
//                                  ),
//                                  onPressed: () {},
//                                ),
//                              ),
//                            ),
                                      ),
                                      Material(
                                          color: Colors.white,
                                          child: Container(
                                        width: SizeConfig.blockSizeHorizontal * 70,
                                        child: AutoSizeText(
                                            AppLocalizations.of(context)
                                                .translate('generating_point'),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Color(0xff6081E2),
                                                fontWeight: FontWeight.bold)),
                                      ),),
//                          Container(
//                            width: SizeConfig.blockSizeHorizontal * 70,
//                            child: AutoSizeText(
//                                AppLocalizations.of(context)
//                                    .translate('generating_point_2'),
//                                textAlign: TextAlign.center,
//                                maxLines: 1,
//                                style: TextStyle(
//                                    fontSize: 24,
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold)),
//                          ),
                                      Container(
                                          width: SizeConfig.blockSizeHorizontal * 25,
                                          height: SizeConfig.blockSizeVertical * 10,
                                          child: LoadingBouncingGrid.square(
                                            borderColor: Colors.cyan,
                                            borderSize: 3.0,
                                            backgroundColor: Colors.cyanAccent,
                                            duration: Duration(milliseconds: 500),
                                          )
                                      ),
//                                      Container(
//                                        width: SizeConfig.blockSizeHorizontal * 60,
//                                        child: AutoSizeText(
//                                            AppLocalizations.of(context)
//                                                .translate('use_this_moment'),
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                fontSize: 14,
//                                                color: Colors.white,
//                                                fontWeight: FontWeight.bold)),
//                                      ),
                                    ])
                              ]),
                            );
                          })
                    ],
                  ),),)
                ],
              ),
            )
            ,
          )
          ,
        );
      });
}

gpsDisabledDialog(BuildContext context, Function enableGPSCallback) {
  dialogRetrievePointCallback() {
    enableGPSCallback();
    Navigator.pop(context);
  }

  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 32,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 35,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                            Container(
//                              height: SizeConfig.blockSizeVertical * 9.5,
////                              child: ImageIcon(AssetImage('assets/img/Dialogs/GPSFailed.png'),
////                                  color: Color(0xff6081E2), size: 96),
//                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'gps_not_enabled_description')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            DialogButton(dialogRetrievePointCallback,
                                "gps_not_enabled_description_yes"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                            DialogButton(dialogCancelCallback,
                                "gps_not_enabled_description_no"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

notEnoughTokensDialog(BuildContext context) {
  dialogRetrievePointCallback() {
    Navigator.pop(context);
//
//    //open shop
//    Navigator.push(
//        context,
//        FadeRoute(page: Shop()));

  }

  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 40,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 12.5,
                              child: ImageIcon(AssetImage(
                                  'assets/img/Dialogs/TokensFailed.png'),
                                  color: Color(0xff6081E2), size: 96),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 3,
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Material(
                                  color: Colors.white,
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'not_enough_tokens_description')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            DialogButton(dialogRetrievePointCallback,
                                "not_enough_tokens_description_yes"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                            DialogButton(dialogCancelCallback,
                                "not_enough_tokens_description_no"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

randonauticaStreakDialog(BuildContext context, int currentSignedInStreak) {
  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 35,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 35,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'randonaut_streak')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff6081E2)))),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 7.5,
                              child: ImageIcon(AssetImage('assets/img/Owl.png'),
                                  color: Color(0xff6081E2), size: 64),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'continue_your_streak')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: (currentSignedInStreak == 1
                                              ? Color(0xff6081E2)
                                              : Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45.0)),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        )
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            1),
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'day')
                                                .toUpperCase() + ' 1',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff6081E2)))),
                                    Container(
                                        height: 30,
                                        child: Visibility(
                                          child: ImageIcon(
                                              AssetImage('assets/img/Owl.png'),
                                              color: Color(0xff6081E2),
                                              size: 48),
                                          visible: false,
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal *
                                    1.5),

                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: (currentSignedInStreak == 2
                                              ? Color(0xff6081E2)
                                              : Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45.0)),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        )
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            1),
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'day')
                                                .toUpperCase() + ' 1',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff6081E2)))),
                                    Container(
                                        height: 30,
                                        child: Visibility(
                                          child: ImageIcon(
                                              AssetImage('assets/img/Owl.png'),
                                              color: Color(0xff6081E2),
                                              size: 48),
                                          visible: false,
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal *
                                    1.5),

                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: (currentSignedInStreak == 3
                                              ? Color(0xff6081E2)
                                              : Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45.0)),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        )
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            1),
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'day')
                                                .toUpperCase() + ' 1',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff6081E2)))),
                                    Container(
                                        height: 30,
                                        child: Visibility(
                                          child: ImageIcon(
                                              AssetImage('assets/img/Owl.png'),
                                              color: Color(0xff6081E2),
                                              size: 48),
                                          visible: false,
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal *
                                    1.5),
                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: (currentSignedInStreak == 4
                                              ? Color(0xff6081E2)
                                              : Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45.0)),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        )
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            1),
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'day')
                                                .toUpperCase() + ' 1',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff6081E2)))),
                                    Container(
                                        height: 30,
                                        child: Visibility(
                                          child: ImageIcon(
                                              AssetImage('assets/img/Owl.png'),
                                              color: Color(0xff6081E2),
                                              size: 48),
                                          visible: false,
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal *
                                    1.5),
                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: (currentSignedInStreak == 7
                                              ? Color(0xff6081E2)
                                              : Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45.0)),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        )
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockSizeVertical *
                                            1),
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                'day')
                                                .toUpperCase() + ' 1',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff6081E2)))),
                                    Container(
                                        height: 30,
                                        child: Visibility(
                                          child: ImageIcon(
                                              AssetImage('assets/img/Owl.png'),
                                              color: Color(0xff6081E2),
                                              size: 48),
                                          visible: false,
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                            DialogButton(dialogCancelCallback,
                                "not_enough_tokens_description_no"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

noInternetConnectionDialog(BuildContext context, Function tryAgainCallback) {
  dialogRetrievePointCallback() {
    tryAgainCallback();
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 35,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 35,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 9.5,
                              child: ImageIcon(AssetImage('assets/img/Owl.png'),
                                  color: Color(0xff6081E2), size: 96),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'no_internet_connection_description')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            DialogButton(dialogRetrievePointCallback,
                                "no_internet_connection_try_again"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

loginFailedDailog(BuildContext context, Function isSigningInCallback) {
  dialogTryAgain() {
    isSigningInCallback(false);
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 35,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 35,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 10.5,
                              child: ImageIcon(AssetImage(
                                  'assets/img/Dialogs/LoginFailed.png'),
                                  color: Color(0xff6081E2), size: 96),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 2,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'login_failed_title')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Material(
                                  color: Colors.white,
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'login_failed_description')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            DialogButton(dialogTryAgain,
                                "no_internet_connection_try_again"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

pointReached(BuildContext context) {
  dialogOkButtonCallback() {
    Navigator.pop(context);
  }

  dialogCancelCallback() {
    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 40,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 12.5,
                              child: ImageIcon(AssetImage(
                                  'assets/img/Dialogs/TokensFailed.png'),
                                  color: Color(0xff6081E2), size: 96),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 3,
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Material(
                                  color: Colors.white,
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'not_enough_tokens_description')
                                          .toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            DialogButton(dialogOkButtonCallback,
                                "not_enough_tokens_description_yes"),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                1.5),
                            DialogButton(dialogCancelCallback,
                                "not_enough_tokens_description_no"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

setTitleDialog(BuildContext context, callback) {
  var _TitleInputController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('change_radius'),
          ),
          content: Text(
            AppLocalizations.of(context).translate('change_radius_dialog_text'),
          ),
          actions: <Widget>[
            CupertinoTextField(
                placeholder: AppLocalizations.of(context)
                    .translate('radius_initial_text'),
                controller: _TitleInputController),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
                callback(_TitleInputController.text);
              },
              child: Text(
                AppLocalizations.of(context).translate('ok_button'),
              ),
            ),
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context).translate('cancel_button'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

giveEverything(BuildContext context) {
  dialogRetrievePointCallback() async {
    //Set SharedPreferences
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;

    //Set everything to true
    prefs.setBool("everything", true);

    Navigator.pop(context);
  }

  dialogCancelCallback() async {
    //Set SharedPreferences
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;

    //Set everything to true
    prefs.setBool("everything", true);

    Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.blockSizeVertical * 75,
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Stack(
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 75,
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
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 1),
                            Container(
                              height: SizeConfig.blockSizeVertical * 12.5,
                              child: Material(
                                color: Colors.white,
                                child: AutoSizeText(
                                    '∞',
                                    maxLines: 1,
                                    minFontSize: 12,
                                    maxFontSize: 256,
                                    style: TextStyle(
                                        fontSize: 256,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: '')),),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                0.5),
                            Container(
                              height: SizeConfig.blockSizeVertical * 20,
                              width: SizeConfig.blockSizeHorizontal * 75,
                              child: Material(
                                  color: Colors.white,
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'give_everything'),
                                      //.toUpperCase(),
                                      maxLines: 20,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 12,
                              width: SizeConfig.blockSizeHorizontal * 75,
                              child: Material(
                                  color: Colors.white,
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'give_everything_2'),
                                      //.toUpperCase(),
                                      maxLines: 20,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 3,
                              width: SizeConfig.blockSizeHorizontal * 75,
                              child: Material(
                                  color: Colors.white,
                                  child: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate(
                                          'give_everything_3'),
                                      //.toUpperCase(),
                                      maxLines: 20,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xff6081E2)))),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical *
                                6.5),
                            DialogButton(
                                dialogRetrievePointCallback, "understood"),
                            //  SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                            //    DialogButton(dialogCancelCallback, "understood_and_save"),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      });
}
