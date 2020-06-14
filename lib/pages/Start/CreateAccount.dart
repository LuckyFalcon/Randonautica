import 'package:app/components/Login/CreateAccountButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountSate();
}

class _CreateAccountSate extends State<CreateAccount> {

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
                Text(
                    AppLocalizations.of(context).translate('create_an_account'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50),
                Container(
                    height: 75,
                    padding: EdgeInsets.only(bottom: 25, left: 45, right: 45),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7BBFFE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context).translate('username').toUpperCase(),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                )
                            )))),
                SizedBox(height: 5),
                Container(
                    height: 75,
                    padding: EdgeInsets.only(bottom: 25, left: 45, right: 45),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7BBFFE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context).translate('email').toUpperCase(),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )))),
                SizedBox(height: 5),
                Container(
                    height: 75,
                    padding: EdgeInsets.only(bottom: 25, left: 45, right: 45),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7BBFFE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context).translate('password').toUpperCase(),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )))),
                SizedBox(height: 5),
                Container(
                    height: 75,
                    padding: EdgeInsets.only(bottom: 25, left: 45, right: 45),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff7BBFFE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20.0),
                                border: InputBorder.none,
                                labelText: AppLocalizations.of(context).translate('repeat_password').toUpperCase(),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )))),
                SizedBox(height: 20),
                CreateAccountButton()
              ])
            ]),
          )),
    );
  } //Functions
}
