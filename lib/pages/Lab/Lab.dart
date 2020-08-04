import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Lab extends StatefulWidget {
  @override
  State<Lab> createState() => LabState();
}

class LabState extends State<Lab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.blockSizeVertical * 70,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 10),
          ImageIcon(
            AssetImage('assets/img/Owlking.png'),
            color: Colors.white,
            size: 128.0,
          ),
          SizedBox(height: 10),
          Text(AppLocalizations.of(context).translate('coming_soon'),
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: AutoSizeText(
                AppLocalizations.of(context).translate('not_complete'),
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(fontSize: 23, color: Colors.white)),
          ),
          SizedBox(height: 20),
        ])
      ]),
    );
  } //Functions
}
