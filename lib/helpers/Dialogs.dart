import 'package:app/helpers/RadiusInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'AppLocalizations.dart';
import 'RadiusSlider.dart';

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/Andronaut.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Anomaly Found",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Great! Now carefully go to the point. Always procceed with caution. Do not attempt to enter or explore unsafe environments!",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      }).then((exit) {
    if (exit == null) return;

    if (exit) {
      // user pressed Yes button
    } else {
      // user pressed No button
    }
  });
}

setSliderDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/Andronaut.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Anomaly Found",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(height: 15),
                        RadiusSlider()
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      }).then((exit) {
    if (exit == null) return;

    if (exit) {
      // user pressed Yes button
    } else {
      // user pressed No button
    }
  });
}

setRadiusDialog(BuildContext context) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('change_radius'),
          ),
          content: Text(
            AppLocalizations.of(context).translate('change_radius_dialog_text'),
          ),
          actions: <Widget>[
            RadiusInput(),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                AppLocalizations.of(context).translate('ok_button'),
              ),
            ),
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context).translate('cancel_button'),
              ),
            )
          ],
        );
      });
}
