import 'package:app/helpers/AppLocalizations.dart';
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
      height: 30.0,
      width: 110.0,
      child: new ButtonTheme(
        minWidth: 120.0,
        height: 10.0,
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
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xff6BE5FE))),
          child: Text(
              AppLocalizations.of(context).translate('share_location').toUpperCase(),
              style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
