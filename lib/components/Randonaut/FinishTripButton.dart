import 'package:auto_size_text/auto_size_text.dart';
import 'package:fatumbot/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class FinishTripButton extends StatefulWidget {
  Function callback;
  bool pressStartOverButton = false;

  FinishTripButton(this.callback, this.pressStartOverButton);

  State<StatefulWidget> createState() => new _FinishTripButton();
}

class _FinishTripButton extends State<FinishTripButton> {
  bool pressStartOverButton = false;

  @override
  void initState() {
    super.initState();
    pressStartOverButton = this.widget.pressStartOverButton;
  }

  void _toggleGoPressButton() {
    setState(() {
      if (pressStartOverButton) {
        pressStartOverButton = false;
      } else {
        pressStartOverButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.blockSizeVertical * 5,
        width: SizeConfig.blockSizeHorizontal * 60,
        decoration: BoxDecoration(
            color: Color(0xff3B4B6C),
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  offset: Offset(10, 10),
                  color: Colors.black.withOpacity(.6),
                  spreadRadius: -15),
            ]),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          padding: EdgeInsets.zero,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                    AppLocalizations.of(context)
                        .translate('finish_trip')
                        .toUpperCase(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onPressed: () {
            _toggleGoPressButton();
//Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            return setState(() {
              this.widget.pressStartOverButton =
                  this.widget.pressStartOverButton;
              this.widget.callback(pressStartOverButton);
            });
          },
          color: Color(0xff3B4B6C),
        ));
  }
}
