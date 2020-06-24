import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class SetWaterPoints extends StatefulWidget {
  State<StatefulWidget> createState() => new _SetWater();
}

class _SetWater extends State<SetWaterPoints> {
  bool waterPointsEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  void setWaterPointsEnabled() {
    setState(() {
      if(waterPointsEnabled){
        waterPointsEnabled = false;
      } else {
        ///Check if WaterPoints bought
        waterPointsEnabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150.0,
        width: 110.0,
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('water').toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                            fontSize: 46,
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
                            fontSize: 46,
                            color: Color(0xff64E4FF))),
                  )),
            Text(AppLocalizations.of(context).translate('points').toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white)),
          ],
        ));
  }
}
