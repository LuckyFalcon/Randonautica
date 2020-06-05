import 'package:app/pages/start/CreateAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../helpers/AppLocalizations.dart';

class SignInCreateAccountButton extends StatefulWidget {
  State<StatefulWidget> createState() => new _SignInCreateAccountButtonState();
}

class _SignInCreateAccountButtonState extends State<SignInCreateAccountButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 70,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
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
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateAccount()),
            );
          },
          color: Color(0xff43CCDB),
        ));
  }
}
