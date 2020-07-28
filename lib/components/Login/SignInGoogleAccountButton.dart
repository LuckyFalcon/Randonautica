import 'package:app/api/signInBackend.dart';
import 'package:app/pages/Failed/FailedToLogin.dart';
import 'package:app/pages/start/Invite.dart';
import 'package:app/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/AppLocalizations.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignInGoogleAccountButton extends StatefulWidget {
  Function callback;
  Function GoogleSignIncallback;

  SignInGoogleAccountButton(this.callback, this.GoogleSignIncallback);

  State<StatefulWidget> createState() => new _SignInGoogleAccountButtonState();
}

class _SignInGoogleAccountButtonState extends State<SignInGoogleAccountButton> {
  GoogleSignInAccount _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {

    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        print('thisisreached');
        _currentUser = account;
      });
    });
    print('thisisreachedsigninsilently');

    _googleSignIn.signInSilently();
  }

  Future<int> signInWithGoogle() async {



    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return 1337; ///User cancelled the dialog
    }

    this.widget.callback(true); ///Start signing in animation

    print(googleSignInAccount.authentication);
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

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
    print('usertoken: ' + token.token);
    print('usertoken: ' + token.toString());

    ///Send request to back-end
    return await signBackendGoogle(token.token.toString());

  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
                SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                Text(
                    AppLocalizations.of(context)
                        .translate('sign_in_with_google')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                ImageIcon(
                  AssetImage('assets/img/Google_icon.png'),
                  color: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          ),
          onPressed: () {
            // ignore: missing_return
            signInWithGoogle().then((statusCode) async {
              if (statusCode == 1337) {
                ///User canceledd login, do nothing
              } else {
                ///Return statusCode to login widget
                this.widget.GoogleSignIncallback(statusCode);
              }
            }).catchError((error) {
              print(error);
              ///Return statusCode 500 to login widget
              this.widget.GoogleSignIncallback(500);
            });
          },
          color: Color(0xff43CCDB),
        ));
  }
}
