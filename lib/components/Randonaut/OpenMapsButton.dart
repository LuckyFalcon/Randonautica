import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OpenMapsButton extends StatelessWidget {
  Function callback;
  bool pressOpenMapsButton = false;

  OpenMapsButton(this.callback, this.pressOpenMapsButton);

  void _toggleGoPressButton() {
    if (pressOpenMapsButton) {
      pressOpenMapsButton = false;
    } else {
      pressOpenMapsButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 3.1,
      width: SizeConfig.blockSizeHorizontal * 29,
      child: new ButtonTheme(
        height: SizeConfig.blockSizeVertical * 3.1,
        minWidth: SizeConfig.blockSizeHorizontal * 29,
        child: RaisedButton(
          elevation: 0,
          color: Color(0xff6BE5FE),
          onPressed: () {
            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            _toggleGoPressButton();
            callback(pressOpenMapsButton); //Callback to Main
          },
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Color(0xff6BE5FE))),
          child: AutoSizeText(
              AppLocalizations.of(context).translate('open_maps').toUpperCase(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
