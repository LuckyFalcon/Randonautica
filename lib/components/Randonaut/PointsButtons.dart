import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:randonautica/utils/size_config.dart';

import '../../helpers/AppLocalizations.dart';

class PointsButtons extends StatefulWidget {
  Function callback;

  PointsButtons(this.callback);


  State<StatefulWidget> createState() => new _PoinstButtons();
}

class _PoinstButtons extends State<PointsButtons> {

  var AutoSizeTextGroup = AutoSizeGroup();

  bool pressAttention1 = true;
  bool pressAttention2 = false;
  bool pressAttention3 = false;

  ///Attractor buttons
  bool pressAnomalyButton = true;
  bool pressAttractorButton = false;
  bool pressVoidButton = false;

  int selectedPoint = 0; //0 = Point, 1 = Anomaly, 2 = Attractor, 3 = Void

  @override
  void initState() {
    super.initState();
  }

  void setButtonClicked() {
    this.widget.callback(selectedPoint);
  }

  void buttonCheck(int selected) {

      if (selected == 1) {
        setState(() {
          selectedPoint = 1;
          pressAttention1 = true;
          pressAttention2 = false;
          pressAttention3 = false;
        });
        setButtonClicked();

      }
      if (selected == 2) {
        setState(() {
          selectedPoint = 2;
          pressAttention1 = false;
          pressAttention2 = true;
          pressAttention3 = false;
        });
        setButtonClicked();

      }
      if (selected == 3) {
        setState(() {
          selectedPoint = 3;
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
          height: SizeConfig.blockSizeVertical * 3.15,
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
                      .translate('anomaly')
                      .toUpperCase(),
                  maxLines: 1,
                  group: AutoSizeTextGroup,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.15,
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
                      .translate('attractor')
                      .toUpperCase(),
                  maxLines: 1,
                  group: AutoSizeTextGroup,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.15,
          width: SizeConfig.blockSizeHorizontal * 29,
          child: new ButtonTheme(
            minWidth: SizeConfig.blockSizeHorizontal * 29,
            height: SizeConfig.blockSizeVertical * 3.1,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention3 ? Color(0xffA2D0FF) : Color(0xff769BE3),
              onPressed: () => buttonCheck(3),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),),
              child: AutoSizeText(
                  AppLocalizations.of(context)
                      .translate('void')
                      .toUpperCase(),
                  maxLines: 1,
                  group: AutoSizeTextGroup,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }
}
