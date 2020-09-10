import 'package:randonautica/helpers/Dialogs.dart';
import 'package:randonautica/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/AppLocalizations.dart';

class HelpButton extends StatelessWidget {
  Function callback;

  HelpButton(this.callback);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 35.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                  this.callback();
              },
            ),
          ],
        );
  }
}
