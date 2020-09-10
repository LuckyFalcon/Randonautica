import 'package:randonautica/helpers/AppLocalizations.dart';
import 'package:randonautica/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShareLocationButton extends StatelessWidget {
  Function callback;
  bool pressShareLocationButton = false;

  ShareLocationButton(this.callback, this.pressShareLocationButton);

  void _togglePressShareLocationButton() {
    if (pressShareLocationButton) {
      pressShareLocationButton = false;
    } else {
      pressShareLocationButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 3.1,
      width: SizeConfig.blockSizeHorizontal * 33,
      child: new ButtonTheme(
        height: SizeConfig.blockSizeVertical * 3.1,
        minWidth: SizeConfig.blockSizeHorizontal * 32,
        child: RaisedButton(
          elevation: 0,
          color: Color(0xff6BE5FE),
          onPressed: () {
            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
            _togglePressShareLocationButton();
            callback(pressShareLocationButton); //Callback to Main
          },
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Color(0xff6BE5FE))),
          child: AutoSizeText(
              AppLocalizations.of(context).translate('share_location').toUpperCase(),
              maxLines: 1,
              style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
