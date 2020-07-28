import 'package:app/helpers/Dialogs.dart';
import 'package:app/utils/size_config.dart';
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
            SizedBox(height: SizeConfig.blockSizeHorizontal * 13), ///Todo Sizeconfig responsive
            IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 35.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                  this.callback();
              },
            ),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 5), ///Todo Sizeconfig responsive
          ],
        );
  }
}
