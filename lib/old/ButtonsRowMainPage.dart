import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../helpers/AppLocalizations.dart';

class ButtonsRowMainPage extends StatefulWidget {
  ButtonsRowMainPage(this.localizationString);

  String localizationString;

  State<StatefulWidget> createState() => new _ButtonsRowMainPage();
}

class _ButtonsRowMainPage extends State<ButtonsRowMainPage> {
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  String localizationString;

  @override
  void initState() {
    super.initState();
    localizationString = this.widget.localizationString;
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
          elevation: pressAttention1 ? 15 : 0,
          color: pressAttention1 ? Colors.white : Color(0xff6BE5FE),
          onPressed: () => setState(() => pressAttention1 = !pressAttention1),
          textColor: pressAttention1 ? Colors.lightBlueAccent : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                  color:
                      pressAttention1 ? Colors.white : Colors.lightBlueAccent)),
          child: Text(
              AppLocalizations.of(context).translate(localizationString).toUpperCase(),
              style: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
