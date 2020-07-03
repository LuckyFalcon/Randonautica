import 'package:app/helpers/Dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/AppLocalizations.dart';
import 'package:app/utils/currentUser.dart' as globals;

class SetRadius extends StatefulWidget {

  State<StatefulWidget> createState() => new _SetRadius();

}

class _SetRadius extends State<SetRadius> {

  var radius = 3;

  @override
  void initState() {
    super.initState();
  }

  void setRadiusCallback(String radiusInput) {
    setState(() {
      radius = int.tryParse(radiusInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              AppLocalizations.of(context).translate('radius').toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
          Container(
            height: 40,
            child: Text(
                radius.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white)),
          ),
          Text(
              AppLocalizations.of(context).translate('miles').toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
          Row(
            children: <Widget>[

//              GestureDetector(
//                onTap: () {
//                  setRadiusDialog(context, this.setRadiusCallback);
//                },
//                child: Icon(
//                  Icons.create,
//                  color: Colors.white,
//                  size: 20.0,
//                  semanticLabel: 'Text to announce in accessibility modes',
//                ),
//              ),
            ],
          )
        ],
      );

  }
}
