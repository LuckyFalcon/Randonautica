import 'dart:ui';

import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppLocalizations.dart';
import 'RadiusSlider.dart';

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

setSliderDialog(BuildContext context) {
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
                        RadiusSlider()
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
                      height: SizeConfig.blockSizeVertical * 30,
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
                            Text(
                                AppLocalizations.of(context)
                                    .translate('uh_oh')
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('access_when_premium')
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blue)),
                            Container(
                                width: 250,
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
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xff44C5DB),
                                ))
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 250,
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
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {},
                            color: Color(0xff44C5DB),
                          )))
                ],
              ),
            ),
          ),
        );
      });
}
