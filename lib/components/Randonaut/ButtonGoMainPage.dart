import 'package:randonautica/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class ButtonGoMainPage extends StatefulWidget {
  Function callback;
  bool pressGoButton = false;

  ButtonGoMainPage(this.callback, this.pressGoButton);

  State<StatefulWidget> createState() => new _ButtonGoMainPage();
}

class _ButtonGoMainPage extends State<ButtonGoMainPage> {
  bool pressGoButton = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleGoPressButton() {
    setState(() {
      if (pressGoButton) {
        pressGoButton = false;
      } else {
        pressGoButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.blockSizeHorizontal * 30,
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
                AutoSizeText(AppLocalizations.of(context).translate('go').toUpperCase(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onPressed: () {
            //_audioCache.play('inceptionbutton.mp3');
            _toggleGoPressButton();
            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            return setState(() {
              this.widget.pressGoButton = this.widget.pressGoButton;
              this.widget.callback(pressGoButton); //Callback to Main
            });
          },
          color: Color(0xff3B4B6C),
        ));
  }
}
