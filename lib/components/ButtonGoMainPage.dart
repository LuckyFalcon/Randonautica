import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/AppLocalizations.dart';

class ButtonGoMainPage extends StatefulWidget {
  Function callback;
  bool pressGoButton = false;

  ButtonGoMainPage(this.callback, this.pressGoButton);

  State<StatefulWidget> createState() => new _ButtonGoMainPage();
}

class _ButtonGoMainPage extends State<ButtonGoMainPage> {
  bool pressGoButton = false;

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
    return Container(
        width: 130,
        height: 78,
        decoration: BoxDecoration(
            color: Color(0xff5D7FE0),
            borderRadius: BorderRadius.circular(90),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 15),
                  color: Colors.black.withOpacity(.6),
                  spreadRadius: -9)
            ]),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          padding: EdgeInsets.zero,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    AppLocalizations.of(context)
                        .translate('go')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),

              ],
            ),
          ),
          onPressed: () {
            _toggleGoPressButton();
            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            return setState(() {
              this.widget.pressGoButton =
                  this.widget.pressGoButton;
              this.widget.callback(
                  pressGoButton); //Callback to Main
            });
          },
          color: Color(0xff45C5DB),
        ));
  }

}
