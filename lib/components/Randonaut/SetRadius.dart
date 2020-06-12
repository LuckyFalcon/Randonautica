import 'package:app/helpers/Dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/AppLocalizations.dart';

class SetRadius extends StatefulWidget {

  State<StatefulWidget> createState() => new _SetRadius();

}

class _SetRadius extends State<SetRadius> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 110.0,
      child: Column(
        children: <Widget>[
          Text(
              AppLocalizations.of(context).translate('radius').toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
          Text(
            '20',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Text(
                  AppLocalizations.of(context).translate('miles').toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
              GestureDetector(
                onTap: () {
                  setRadiusDialog(context);
                },
                child: Icon(
                  Icons.create,
                  color: Colors.white,
                  size: 20.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
