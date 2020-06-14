import 'package:app/components/Lab/LabButton.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

import 'LabOpen.dart';

class Lab extends StatefulWidget {
  @override
  State<Lab> createState() => LabState();
}

class LabState extends State<Lab> {

  bool labButtonPress = false;

  @override
  void initState() {
    super.initState();
  }

  void callback(bool labButtonPress) {
    setState(() {
      this.labButtonPress = labButtonPress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LabOpen();

      ///Lab closed
//      Center(
//            child: Column(
//              children: <Widget> [
//                Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      SizedBox(height: 50),
//                      ImageIcon(
//                          AssetImage('assets/img/Owlking.png'),
//                        color: Colors.white,
//                        size: 128.0,
//                      ),
//                      SizedBox(height: 10),
//                      Text(
//                          AppLocalizations.of(context)
//                              .translate('uh_oh'),
//                          style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
//                      SizedBox(height: 10),
//                      SizedBox(
//                        width: 300.0,
//                        height: 100.0,
//                        child: Text(
//                            AppLocalizations.of(context)
//                                .translate('laboratory_lock'),
//                            textAlign: TextAlign.center,
//                            style: TextStyle(fontSize: 20, color: Colors.white)),
//                      ),
//                      SizedBox(height: 20),
//                      LabButton(this.callback, labButtonPress)
//                    ])
//              ]
//            ),
//          );
  } //Functions
}
