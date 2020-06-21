
import 'package:app/components/Profile/BadeGrow.dart';
import 'package:app/components/Trips/TripRow.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(

          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 32,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 44.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  SizedBox(height: 30),
                  Image(
                    image: AssetImage('assets/img/Andronaut.png'),
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "Kerry",
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Edit Profile",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context)
                              .translate('badges_earned')
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  BadgeRow(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context)
                              .translate('favorite_trips')
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TripRow(),
                ]),
              ],
            ),
          )),
    );
  }

}
