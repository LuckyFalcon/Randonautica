import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/AppLocalizations.dart';

class CreateAccountButton extends StatefulWidget {
  State<StatefulWidget> createState() => new _CreateAccountButtonState();
}

class _CreateAccountButtonState extends State<CreateAccountButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 275,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
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
                        .translate('create_account_button')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {},
          color: Colors.white,
        ));
  }
}
