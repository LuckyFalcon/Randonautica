import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/inviteFriends.dart';
import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Invite extends StatefulWidget {
  @override
  State<Invite> createState() => InviteState();
}

class InviteState extends State<Invite> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.yellow[200],
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
                SizedBox(height: 50),
                Text(AppLocalizations.of(context).translate('invite_text'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50),
                ImageIcon(
                  AssetImage('assets/img/owls.png'),
                  color: Colors.white,
                  size: 128.0,
                ),
                SizedBox(height: 30),
                Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: []),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 6),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('sure_button')
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      onPressed: () {
                        inviteFriends(context);
                      },
                      color: Colors.white,
                    )),
                SizedBox(height: 20),
                Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xff5D7FE0),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: []),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 6),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('not_right_now')
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      onPressed: () {
                        ///Todo at this point remove previous navigation items
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                            ModalRoute.withName("/Home")
                        );
                      },
                      color: Colors.white,
                    ))
              ])
            ]),
          )),
    );
  } //Functions
}
