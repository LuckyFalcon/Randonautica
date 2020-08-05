import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
      height: SizeConfig.blockSizeVertical * 3.1,
      width: SizeConfig.blockSizeHorizontal * 29,
      child: new ButtonTheme(
        height: SizeConfig.blockSizeVertical * 3.1,
        minWidth: SizeConfig.blockSizeHorizontal * 29,
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
          child: AutoSizeText(
              AppLocalizations.of(context).translate('start_over').toUpperCase(),
              style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
