import 'dart:io';

import 'package:app/api/signInBackend.dart';
import 'package:app/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../helpers/AppLocalizations.dart';
import 'dart:io' show Platform;

class SignInAppleAccountButton extends StatefulWidget {
  Function GoogleSignIncallback;
  SignInAppleAccountButton(this.GoogleSignIncallback);

  State<StatefulWidget> createState() => new _SignInAppleAccountButtonState();
}

class _SignInAppleAccountButtonState extends State<SignInAppleAccountButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
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
                        .translate('sign_in_with_apple')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                ImageIcon(
                  AssetImage('assets/img/Apple_icon.png'),
                  color: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          ),
          onPressed: () async {
            if (Platform.isAndroid) {
              signInWithAppleAndroid().then((statusCode) async {
                if (statusCode == 1337) {
                  ///User canceledd login, do nothing
                } else {
                  ///Return statusCode to login widget
                  this.widget.GoogleSignIncallback(statusCode);
                }
              }).catchError((error) {
                ///Return statusCode 500 to login widget
                this.widget.GoogleSignIncallback(500);
              });
            } else if (Platform.isIOS) {
              signInWithAppleIOS().then((statusCode) async {
                if (statusCode == 1337) {
                  ///User canceledd login, do nothing
                } else {
                  ///Return statusCode to login widget
                  this.widget.GoogleSignIncallback(statusCode);
                }
              }).catchError((error) {
                ///Return statusCode 500 to login widget
                this.widget.GoogleSignIncallback(500);
              });
            }
          },
          color: Color(0xff43CCDB),
        ));
  }

  Future<int> signInWithAppleAndroid() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.randonautica.app.signinwithapple',
        redirectUri: Uri.parse(
          'https://randonautica-v2.azure-api.net/apple/callbacks/sign_in_with_apple',
        ),
      ),
    );

    final oAuthProvider = OAuthProvider(providerId: 'apple.com');
    final credential = oAuthProvider.getCredential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    try {
      final authResult = await _auth.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      var token = await currentUser.getIdToken();

      print('reachedsofar');
      ///Send request to back-end
      return await signBackendApple(token.token.toString());
    } catch (error) {
      return 500;
    }

  }

  Future<int> signInWithAppleIOS() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider(providerId: 'apple.com');
    final credential = oAuthProvider.getCredential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
    try {
      final authResult = await _auth.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      var token = await currentUser.getIdToken();

      ///Send request to back-end
      return await signBackendApple(token.token.toString());

    } catch (error) {
      return 500;
    }
  }
}
