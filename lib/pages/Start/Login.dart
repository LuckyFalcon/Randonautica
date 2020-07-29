import 'dart:io';

import 'package:app/api/acceptAgreement.dart';
import 'package:app/api/syncTripReports.dart';
import 'package:app/components/FadingCircleLoading.dart';
import 'package:app/components/Login/SignInAccountButton.dart';
import 'package:app/components/Login/SignInAppleAccountButton.dart';
import 'package:app/components/Login/SignInGoogleAccountButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/pages/Failed/FailedToLogin.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/currentUser.dart' as user;
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool signingIn = false;

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  void signingInCallback(bool currentlySigningIn) {
    setState(() {
      signingIn = currentlySigningIn;
    });
  }

  void googleSignInCallback(int statusCode) async {
    //Await SharedPreferences future object
    final SharedPreferences prefs = await _prefs;

    if (statusCode == 409 || statusCode == 200) {
      //Status codes: 409 Account Already exists, 200 Account successfully created
      if (user.currentUser.isAgreementAccepted == 0) {
        showAgreementDialog(context, prefs);
      } else {

        ///Continue this later
        if(prefs.getBool("SyncedReports") != true){
          await syncTripReports().then((value) => {
            prefs.setBool("SyncedReports", true),
            prefs.setBool("Account", true)


          });
        }


//        if(statusCode == 409){
//          await syncTripReports().then((value) =>
//              print(value)
//          );
//        }


      }
    } else if (statusCode == 500) {
      //Error
      prefs.setBool("Account", false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return FailedToLogin();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.yellow[200],
      body: Container(
          decoration: backgrounds.normal,
          child: (signingIn
              ? Center(
                  child: Column(children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 25),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('signing_in'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(height: 50),
                    FadingCircleLoading(
                      color: Colors.white,
                      size: 75.0,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    Text(
                        AppLocalizations.of(context)
                            .translate('please_be_patient'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ]),
                )
              : Center(
                  child: Column(children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: new EdgeInsets.only(
                              left: SizeConfig.blockSizeVertical * 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('welcome_randonaut_1'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: new EdgeInsets.only(
                              left: SizeConfig.blockSizeVertical * 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('welcome_randonaut_2'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(height: 50),
                    Container(
                        height: SizeConfig.blockSizeVertical * 37,
                        width: SizeConfig.blockSizeHorizontal * 85,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 15),
                                  color: Colors.black.withOpacity(.6),
                                  spreadRadius: -9)
                            ]),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.blockSizeVertical * 4),
                            (Platform.isAndroid
                                ? SignInGoogleAccountButton(
                                    this.signingInCallback,
                                    this.googleSignInCallback)
                                : SignInAppleAccountButton(
                                    this.googleSignInCallback)),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            (Platform.isAndroid
                                ? SignInAppleAccountButton(
                                    this.googleSignInCallback)
                                : SignInGoogleAccountButton(
                                    this.signingInCallback,
                                    this.googleSignInCallback)),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            SignInCreateAccountButton(),
                          ],
                        )),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  ]),
                ))),
    );
  } //Functions
}
