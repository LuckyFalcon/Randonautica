import 'package:auto_size_text/auto_size_text.dart';
import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:fatumbot/utils/size_config.dart';
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
                    AppLocalizations.of(context).translate('open_maps').toUpperCase(),
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
            callback(pressOpenMapsButton);
          },
          color: Color(0xff3B4B6C),
        ));
  }
}
