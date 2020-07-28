import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/helpers/inviteFriends.dart';
import 'package:app/pages/start/Walkthrough.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Invite extends StatefulWidget {
  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  void initState() {
    super.initState();
  }

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
            child:
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 13),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 75,
                    padding: new EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 10),
                    child: AutoSizeText(
                        AppLocalizations.of(context).translate('invite_text'),
                        textAlign: TextAlign.left,
                        minFontSize: 20,
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5),
              ImageIcon(
                AssetImage('assets/img/owls.png'),
                color: Colors.white,
                size: 128.0,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  height: SizeConfig.blockSizeVertical * 9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: []),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                          Text(
                              AppLocalizations.of(context)
                                  .translate('sure_button')
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: SizeConfig.blockSizeVertical * 1),
                        ],
                      ),
                    ),
                    onPressed: () {
                      inviteFriends(context);
                    },
                    color: Colors.white,
                  )),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  height: SizeConfig.blockSizeVertical * 9,
                  decoration: BoxDecoration(
                      color: Color(0xff5D7FE0),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: []),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                          Text(
                              AppLocalizations.of(context)
                                  .translate('not_right_now')
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                        ],
                      ),
                    ),
                    onPressed: () {
                      ///Todo at this point remove previous navigation items
                      Navigator.pushAndRemoveUntil(
                          context,
                          FadeRoute(page: Walkthrough()),
                          ModalRoute.withName("/Walktrhough"));
                    },
                    color: Colors.white,
                  ))
            ]),
          )),
    );
  } //Functions
}
