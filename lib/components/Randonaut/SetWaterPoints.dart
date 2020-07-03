import 'package:app/helpers/Dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';
import 'package:app/utils/currentUser.dart' as globals;

class SetWaterPoints extends StatefulWidget {
  State<StatefulWidget> createState() => new _SetWater();
}

class _SetWater extends State<SetWaterPoints> {
  double _sigmaX = 0.0; // from 0-10
  double _sigmaY = 0.0; // from 0-10
  double _opacity = 0.1; // from 0-1.0

  bool waterPointsEnabled = false;
  bool waterPointsBought = false;

  @override
  void initState() {
    super.initState();
  }

  void setWaterPointsEnabled() {
    setState(() {
      if(globals.currentUser.isIapSkipWaterPoints != 0){
        if(waterPointsEnabled){
          waterPointsEnabled = false;
        } else {
          ///Check if WaterPoints bought
          waterPointsEnabled = true;
        }
      } else {
        setBuyDialog(context);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('water').toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white)),


            (waterPointsEnabled
                ? GestureDetector(
                    onTap: () {
                      setWaterPointsEnabled();
                    },
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('on')
                            .toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white)),
                  )
                : GestureDetector(
                    onTap: () {
                      setWaterPointsEnabled();
                    },
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('off')
                            .toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xff64E4FF))),
                  )
            ),
//            Text(AppLocalizations.of(context).translate('points').toUpperCase(),
//                style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 20,
//                    color: Colors.white)),
          ],
        );
  }
}
