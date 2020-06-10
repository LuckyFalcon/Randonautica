import 'package:app/main.dart';
import 'package:app/pages/start/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/AppLocalizations.dart';

class EnterRandonauticaButton extends StatefulWidget {
  EnterRandonauticaButton();

  State<StatefulWidget> createState() => new _EnterRandonauticaButton();
}

class _EnterRandonauticaButton extends State<EnterRandonauticaButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [0, 1],
                colors: [Color(0xff383B46), Color(0xff5E80E0)]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 15),
                  color: Colors.black.withOpacity(.6),
                  spreadRadius: -9)
            ]),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.zero,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 6),
                Text(
                    AppLocalizations.of(context)
                        .translate('enter_randonautica')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                  color: Colors.white
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(new CupertinoPageRoute<bool>(
                builder: (BuildContext context) => new HomePage()));
          },
          color: Color(0xff5D7FE0),
        ));
  }
}
