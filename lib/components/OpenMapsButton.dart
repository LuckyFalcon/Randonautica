import 'package:app/helpers/AppLocalizations.dart';
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
            _toggleGoPressButton();
            callback(pressOpenMapsButton); //Callback to Main
          },
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Color(0xff6BE5FE))),
          child: Text(
              AppLocalizations.of(context).translate('open_maps').toUpperCase(),
              style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
