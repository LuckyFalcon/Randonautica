import 'package:app/helpers/Dialogs.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/AppLocalizations.dart';

class HelpButton extends StatefulWidget {
  State<StatefulWidget> createState() => new _HelpButton();
}

class _HelpButton extends State<HelpButton> {
  bool waterPointsEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
        height: 150.0,
        width: 60,
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeHorizontal * 5), ///Todo Sizeconfig responsive
            IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                setState(() {
                  setSliderDialog(context);
                });
              },
            ),

            SizedBox(height: SizeConfig.blockSizeHorizontal * 5), ///Todo Sizeconfig responsive
          ],
        ));
  }
}
