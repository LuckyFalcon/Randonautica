import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class GoPremiumButton extends StatefulWidget {
  Function callback;

  GoPremiumButton(this.callback);

  State<StatefulWidget> createState() => new _GoPremiumButton();
}

class _GoPremiumButton extends State<GoPremiumButton> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        height: SizeConfig.blockSizeVertical * 8,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(60), boxShadow: [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 15),
              color: Colors.black.withOpacity(.6),
              spreadRadius: -9)
        ]),
        child: RaisedButton(
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
                  Text(
                      AppLocalizations.of(context)
                          .translate('go_premium')
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                  ImageIcon(AssetImage('assets/img/double_arrow.png'),
                      size: 24, color: Colors.white),
                ],
              ),
            ),
          ),
          onPressed: () {
            this.widget.callback(true);
          },
        ));
  }
}
