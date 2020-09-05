import 'package:app/helpers/Dialogs.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class SetRadius extends StatefulWidget {
  Function callback;

  SetRadius(this.callback);

  State<StatefulWidget> createState() => new _SetRadius();
}

class _SetRadius extends State<SetRadius> {
  var radius = 3;

  @override
  void initState() {
    super.initState();
  }

  void setRadiusCallback(String radiusInput) {
    setState(() {
      radius = int.tryParse(radiusInput);
      this.widget.callback(radius * 1000);
    });
  }

  void setRadius(String radiusInput) {
    setState(() {
      radius = int.tryParse(radiusInput);
      this.widget.callback(radius * 1000);
    });
  }

  void decreaseRadius(){
    setState(() {
      if(radius != 1){
        radius = radius - 1;
      }
    });
  }

  void increaseRadius(){
    setState(() {
      if(radius != 10){
        radius = radius + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
            AppLocalizations.of(context).translate('radius').toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white)),
        Container(
            height: SizeConfig.blockSizeVertical * 4.5,
            width: SizeConfig.blockSizeHorizontal * 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal * 10,
                  child: Visibility(
                    child: GestureDetector(
                        onTap: () {
                          setRadiusDialog(context, this.setRadiusCallback);
                        },
                        child: IconButton(
                          icon:  Icon(Icons.arrow_back_ios,
                              size: 16.0, color: Colors.white),
                          onPressed: () {
                            decreaseRadius();
                          },
                        )),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: (radius != 1 ? true : false),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 10,
                  child: AutoSizeText(
                      radius.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white)),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 10,
                  child: Visibility(
                    child: GestureDetector(
                        onTap: () {
                          setRadiusDialog(context, this.setRadiusCallback);
                        },
                        child: IconButton(
                          icon:  Icon(Icons.arrow_forward_ios,
                              size: 16.0, color: Colors.white),
                          onPressed: () {
                            increaseRadius();
                          },
                        )),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: (radius != 10 ? true : false),
                  ),
                ),
              ],
            )),
        AutoSizeText(
            AppLocalizations.of(context).translate('miles').toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white)),
      ],
    );
  }
}
