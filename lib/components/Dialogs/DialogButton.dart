import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {

  DialogButton(this.callback, this.localizationString);

  Function callback;
  String localizationString;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        width: SizeConfig.blockSizeHorizontal * 65,
        height: SizeConfig.blockSizeVertical * 8,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(60),
           ),
        child: RaisedButton(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          padding: EdgeInsets.zero,
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0, 1],
                    colors: [Color(0xff5F7FDF), Color(0xff44CADB)]),
                borderRadius: BorderRadius.circular(60.0)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                  AutoSizeText(
                      AppLocalizations.of(context)
                          .translate(localizationString)
                          .toUpperCase(),
                      maxLines: 1,
                      maxFontSize: 14,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                ],
              ),
            ),
          ),
          onPressed: () {
            this.callback();
          },
        ));
  }
}