import 'dart:convert';

import 'package:app/pages/start/Invite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:http/http.dart" as http;

import '../../helpers/AppLocalizations.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignInGoogleAccountButton extends StatefulWidget {
  State<StatefulWidget> createState() => new _SignInGoogleAccountButtonState();
}

class _SignInGoogleAccountButtonState extends State<SignInGoogleAccountButton> {
  GoogleSignInAccount _currentUser;
  String _contactText;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return Future.error("CANCELLED_SIGN_IN");
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    var token = await currentUser.getIdToken();
    print('usertoken: '+ token.token);
    print('usertoken: '+ token.toString());

    signBackendGoogle(token.token.toString());

    print('useruuid: '+ currentUser.uid.toString());
    print('user: $user');
    return 'signInWithGoogle succeeded: $user';
  }

  Future<String>signBackendGoogle(token) async {
    final response = await http.get("http://192.168.1.217:8080/userBasedFunc", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.toString());
    return response.toString();
  }


  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 70,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          padding: EdgeInsets.zero,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 6),
                Text(
                    AppLocalizations.of(context)
                        .translate('sign_in_with_google')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  size: 12,
                ),
              ],
            ),
          ),
          onPressed: () {
            signInWithGoogle().catchError(() {
              /// On cancel or error do Nothing
            }).whenComplete(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Invite();
                  },
                ),
              );
            });
          },
          color: Color(0xff43CCDB),
        ));
  }
}
