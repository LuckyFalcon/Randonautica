import 'dart:ui' as ui;

import 'package:app/helpers/Dialogs.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';
import 'SwitchButton.dart';

class SetWaterPoints extends StatefulWidget {
  Function callback;

  SetWaterPoints(this.callback);

  State<StatefulWidget> createState() => new _SetWater();
}

class _SetWater extends State<SetWaterPoints> {
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.1; // from 0-1.0

  bool waterPointsEnabled = false;
  bool waterPointsBought = false;
  bool status = false;

  @override
  void initState() {
    ///TODO isSubscriptionEnabled
    if (globals.currentUser.isIapSkipWaterPoints != 0) {
      waterPointsBought = true;
    } else {
      waterPointsBought = false;
    }
    super.initState();
  }

  void setWaterPointsEnabled() {
    setState(() {
      if (waterPointsBought) {
        if (waterPointsEnabled) {
          waterPointsEnabled = false;
          this.widget.callback(false);
        } else {
          ///Check if WaterPoints bought
          waterPointsEnabled = true;
          this.widget.callback(true);
        }
      } else {
        setBuyDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(children: <Widget>[
      Container(
          width: SizeConfig.blockSizeHorizontal * 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                  AppLocalizations.of(context).translate('water').toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white)),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              (waterPointsBought
                  ? Container(
                      height: SizeConfig.blockSizeVertical * 7.5,
                      width: SizeConfig.blockSizeHorizontal * 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 12,
                            child: SwitchButton(
                              activeColor: Colors.white,
                              inactiveColor: Color(0xff6FDDFE),
                              value: waterPointsEnabled,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  setWaterPointsEnabled();
                                });
                              },
                            ),
                          ),
                        ],
                      ))
                  : Container(
                      height: SizeConfig.blockSizeVertical * 4.5,
                      width: SizeConfig.blockSizeHorizontal * 15,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 12,
                            child: SwitchButton(
                              activeColor: Colors.white,
                              inactiveColor: Color(0xff6FDDFE),
                              value: waterPointsEnabled,
                              onChanged: (value) {
                                print("VALUE : $value");
                                setState(() {
                                  setWaterPointsEnabled();
                                });
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ClipRect(
                              // <-- clips to the 200x200 [Container] below
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                  sigmaX: 15.0,
                                  sigmaY: 15.0,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                      onTap: () {
                                        setWaterPointsEnabled();
                                      },
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 30.0,
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))),
              SizedBox(height: SizeConfig.blockSizeVertical * 1)
            ],
          )),
    ]);
  }
}
