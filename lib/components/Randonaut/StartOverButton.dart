import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../helpers/AppLocalizations.dart';

class StartOverButton extends StatefulWidget {
  Function callback;
  bool pressStartOverButton = false;

  StartOverButton(this.callback, this.pressStartOverButton);

  State<StatefulWidget> createState() => new _StartOverButton();
}

class _StartOverButton extends State<StartOverButton> {
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
    return SizedBox(
      height: 30.0,
      width: 110.0,
      child: new ButtonTheme(
        minWidth: 120.0,
        height: 10.0,
        child: FlatButton(
          color: Color(0xff6080E2),
          onPressed: () {
            _toggleGoPressButton();
            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            return setState(() {
              this.widget.pressStartOverButton =
                  this.widget.pressStartOverButton;
              this.widget.callback(
                  pressStartOverButton); //Callback to Main
            });
          },
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                  color:
                  Color(0xff6080E2))),
          child: Text(
              AppLocalizations.of(context).translate('start_over').toUpperCase(),
              style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
