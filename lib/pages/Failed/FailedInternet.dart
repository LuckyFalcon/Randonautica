import 'package:app/helpers/AppLocalizations.dart';
import '../../pages/Loading.dart';
import '../../pages/Login.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FailedToInternet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: Center(
            child: Column(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 25),
                ImageIcon(
                  AssetImage('assets/img/Owl.png'),
                  color: Colors.white,
                  size: 128.0,
                ),
                SizedBox(height: 10),
                Text(AppLocalizations.of(context).translate('title'),
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Text( AppLocalizations.of(context)
                    .translate('check_internet')
                    .toUpperCase(),
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: SizeConfig.blockSizeVertical * 5),
                Container(
                  width: SizeConfig.blockSizeHorizontal * (70),
                  height: SizeConfig.blockSizeVertical * (8),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)
                                  .translate('try_again')
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return Loading();
                          },
                        ),
                      );
                    },
                    color: Color(0xff43CCDB),
                  ))
              ])
            ]),
          )),
    );
  } //Functions
}
