import 'dart:io';

import 'package:app/pages/Start/Invite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../helpers/AppLocalizations.dart';
import 'dart:io' show Platform;

class SignInAppleAccountButton extends StatefulWidget {
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
                        .translate('sign_in_with_apple')
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
          onPressed: () async {
            if (Platform.isAndroid) {
              signInWithAppleAndroid().whenComplete(() =>
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Invite();
                      },
                    ),
                  )
              );
            } else if (Platform.isIOS) {
              signInWithAppleIOS().whenComplete(() =>
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Invite();
                      },
                    ),
                  )
              );
            }
          },
          color: Color(0xff43CCDB),
        ));
  }

  Future<FirebaseUser> signInWithAppleAndroid() async {
    final appleIdCredential =  await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'com.randonautica.app.signinwithapple',
        redirectUri: Uri.parse(
          'https://api2.randonauts.com/apple/callbacks/sign_in_with_apple',
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
      return authResult.user;

    } catch (error){
      print(error);
    }
  }

  Future<FirebaseUser> signInWithAppleIOS() async {

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
    final authResult = await _auth.signInWithCredential(credential);
    return authResult.user;
  }
}
