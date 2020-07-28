import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/size_config.dart';

import '../../helpers/AppLocalizations.dart';

class PointsButtons extends StatefulWidget {
  Function callback;

  PointsButtons(this.callback);


  State<StatefulWidget> createState() => new _PoinstButtons();
}

class _PoinstButtons extends State<PointsButtons> {

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
          height: SizeConfig.blockSizeVertical * 3.1,
          width: 120.0,
          child: new ButtonTheme(
            minWidth: 120.0,
            height: 10.0,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention1 ? Color(0xff5987E3) : Color(0xff6BE5FE),
              onPressed: () => buttonCheck(1),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),),
              child: Text(
                  AppLocalizations.of(context)
                      .translate('anomaly')
                      .toUpperCase(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.1,
          width: 120.0,
          child: new ButtonTheme(
            minWidth: 120.0,
            height: 10.0,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention2 ? Color(0xff5987E3) : Color(0xff6BE5FE),
              onPressed: () => buttonCheck(2),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),),
              child: Text(
                  AppLocalizations.of(context)
                      .translate('attractor')
                      .toUpperCase(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3.1,
          width: 120.0,
          child: new ButtonTheme(
            minWidth: 120.0,
            height: 10.0,
            child: RaisedButton(
              elevation: 0,
              color: pressAttention3 ? Color(0xff5987E3) : Color(0xff6BE5FE),
              onPressed: () => buttonCheck(3),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),),
              child: Text(
                  AppLocalizations.of(context)
                      .translate('void')
                      .toUpperCase(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }
}
