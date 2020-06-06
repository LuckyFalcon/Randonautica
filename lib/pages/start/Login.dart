import 'package:app/components/SignInAccountButton.dart';
import 'package:app/components/SignInFacebookAccountButton.dart';
import 'package:app/components/SignInGoogleAccountButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/pages/start/Invite.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
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
                  stops: [0, 1],
                  colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
          child: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 50),
              Text(AppLocalizations.of(context).translate('welcome_randonaut'),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              Container(
                  height: 325,
                  width: 350,
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
                      SizedBox(height: 40),
                      SignInCreateAccountButton(),
                      SizedBox(height: 15),
                      SignInGoogleAccountButton(),
                      SizedBox(height: 15),
                      SignInFacebookAccountButton()
                    ],
                  )),
              SizedBox(height: 15),
              Text(
                  AppLocalizations.of(context).translate('login').toUpperCase(),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 45),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Invite()),
                  );
                },
                child: new Text(
                    AppLocalizations.of(context)
                        .translate('continue_without_registering'),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40.0,
              ),
            ]),
          )),
    );
  } //Functions
}
