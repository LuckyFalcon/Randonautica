import 'dart:ui' as ui;

import 'package:fatumbot/helpers/Dialogs.dart';
import 'package:fatumbot/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';
import 'package:fatumbot/utils/currentUser.dart' as globals;

class SetRandomness extends StatefulWidget {
  Function callback;

  SetRandomness(this.callback);

  State<StatefulWidget> createState() => new _SetRandomness();
}

class _SetRandomness extends State<SetRandomness> {

  bool pressAttention1 = true;
  bool pressAttention2 = false;
  bool pressAttention3 = false;

  ///Attractor buttons
  bool pressRandomButton = true;
  bool pressQauntuMButton = false;
  bool pressVoidButton = false;

  int selectedRandomness = 0; //0 = Random, 1 = Quantum, 2 = Bias, 3 = Void. Random is selected as standard

  @override
  void initState() {
    super.initState();
  }

  void setButtonClicked() {
    this.widget.callback(selectedRandomness);
  }

  void buttonCheck(int selected) {
    if (selected == 1) {
      setState(() {
        selectedRandomness = 1;
        pressAttention1 = true;
        pressAttention2 = false;
        pressAttention3 = false;
      });
      setButtonClicked();
    }
    if (selected == 2) {
      setState(() {
        selectedRandomness = 2;
        pressAttention1 = false;
        pressAttention2 = true;
        pressAttention3 = false;
      });
      setButtonClicked();
    }
    if (selected == 3) {
      setState(() {
        selectedRandomness = 3;
        pressAttention1 = false;
        pressAttention2 = false;
        pressAttention3 = true;
      });
      setButtonClicked();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.1,
          width: SizeConfig.blockSizeHorizontal * 29,
          child: new ButtonTheme(
            minWidth: SizeConfig.blockSizeHorizontal * 29,
            height: SizeConfig.blockSizeVertical * 3.1,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention1 ? Color(0xffA2D0FF) : Color(0xff769BE3),
              onPressed: () => buttonCheck(1),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),),
              child: AutoSizeText(
                  AppLocalizations.of(context)
                      .translate('random')
                      .toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.1,
          width: SizeConfig.blockSizeHorizontal * 29,
          child: new ButtonTheme(
            minWidth: SizeConfig.blockSizeHorizontal * 29,
            height: SizeConfig.blockSizeVertical * 3.1,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention2 ? Color(0xffA2D0FF) : Color(0xff769BE3),
              onPressed: () => buttonCheck(2),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),),
              child: AutoSizeText(
                  AppLocalizations.of(context)
                      .translate('quantum')
                      .toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
      ],
    );
  }
}
