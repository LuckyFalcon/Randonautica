import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
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
            child: Text(
                AppLocalizations.of(context).translate('not_complete'),
                textAlign: TextAlign.center,
                maxLines: 4,
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          SizedBox(height: 20),
///Lab button
//          Container(
//              width: SizeConfig.blockSizeHorizontal * 60,
//              height: SizeConfig.blockSizeVertical * 8,
//              decoration: BoxDecoration(
//                  color: Color(0xff5D7FE0),
//                  borderRadius: BorderRadius.circular(60),
//                  boxShadow: [
//                    BoxShadow(
//                        blurRadius: 20,
//                        offset: Offset(10, 5),
//                        color: Colors.black.withOpacity(.6),
//                        spreadRadius: -9)
//                  ]),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(60.0),
//                ),
//                padding: EdgeInsets.zero,
//                child: Center(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      SizedBox(width: 6),
//                      Text(
//                          AppLocalizations.of(context)
//                              .translate('open_the_lab')
//                              .toUpperCase(),
//                          style: TextStyle(
//                              fontSize: 16,
//                              color: Colors.white,
//                              )),
//                      SizedBox(width: 10),
//                      Icon(
//                        Icons.vpn_key,
//                        size: 20,
//                        color: Colors.white,
//
//                      ),
//                    ],
//                  ),
//                ),
//                onPressed: () {
//                  this.widget.callback(true);
//                },
//                color: Color(0xff5D7FE0),
//              ))
        ])
      ]),
    );
  } //Functions
}
