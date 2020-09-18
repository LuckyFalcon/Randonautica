import 'dart:io';

import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:fatumbot/helpers/FadeRoute.dart';
import 'package:fatumbot/pages/Bot/bot_webview.dart';
import 'package:fatumbot/utils/BackgroundColor.dart' as backgrounds;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _dark;

  //Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email;

  _reportABug() async {
    var currentUser = await _auth.currentUser();
    var platform;

    if(Platform.isAndroid){
      platform = "Android";
    } else {
      platform = "Apple";
    }

    Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'funxcorp@gmail.com',
        queryParameters: {
          'subject': "Bug report",
          'body': 'Type your report here ' +
              '<br></br>' +
              '<br></br>'
    });

    email =  _emailLaunchUri.toString().replaceAll("+", "%20");

    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not open repot a bug.';
    }
  }

  _privacyEnquiry() async {
    var currentUser = await _auth.currentUser();
    var platform;

    if(Platform.isAndroid){
      platform = "Android";
    } else {
      platform = "Apple";
    }

    Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'funxcorp@gmail.com',
        queryParameters: {
          'subject': AppLocalizations.of(context)
              .translate('navigate_to_bot'),
          'body': 'Type your privacy request here ' +
              '<br></br>' +
              '<br></br>'
        });

    email =  _emailLaunchUri.toString().replaceAll("+", "%20");

    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not open repot a bug.';
    }
  }

  _OpenPrivacyPolicy() async {

    String privacyPolicyUrl = "https://bot.fp2.dev/privacy-and-terms.html";

    if (await canLaunch(privacyPolicyUrl)) {
      await launch(privacyPolicyUrl);
    } else {
      throw 'Could not open privacy policy.';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[],
        ),
        body: Container(
          decoration: backgrounds.dark,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.lock_outline,
                              color: Colors.purple,
                            ),
                            title: AutoSizeText(
                              AppLocalizations.of(context)
                                  .translate('navigate_to_bot'),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              ///Include this in here so purchases are enabled within the bot
                              InAppPurchaseConnection.enablePendingPurchases();

                              //Open Bot
                              Navigator.push(
                                  context,
                                  FadeRoute(page: BotWebView())
                              );
                            },
                          ),
 //                         _buildDivider(),
//                          ListTile(
//                            leading: Icon(
//                              Icons.arrow_forward_ios,
//                              color: Colors.purple,
//                            ),
//                            title: AutoSizeText(
//                              AppLocalizations.of(context)
//                                  .translate('bug_report'),
//                            ),
//                            trailing: Icon(Icons.keyboard_arrow_right),
//                            onTap: () {
//                              _reportABug();
//                            },
//                          ),
//                          _buildDivider(),
//                          ListTile(
//                            leading: Icon(
//                              Icons.location_on,
//                              color: Colors.purple,
//                            ),
//                            title: AutoSizeText(
//                              AppLocalizations.of(context)
//                                  .translate('privacy_enquiry'),
//                            ),
//                            trailing: Icon(Icons.keyboard_arrow_right),
//                            onTap: () {
//                              //open email
//                              _privacyEnquiry();
//                            },
//                          ),
//                          _buildDivider(),
//                          ListTile(
//                            leading: Icon(
//                              Icons.location_on,
//                              color: Colors.purple,
//                            ),
//                            title: AutoSizeText(
//                              AppLocalizations.of(context)
//                                  .translate('privacy_policy'),
//                            ),
//                            trailing: Icon(Icons.keyboard_arrow_right),
//                            onTap: () {
//                              //open privacy policy
//                              _OpenPrivacyPolicy();
//                            },
//                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
