import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadeRoute.dart';
import '../../pages/Invite/Invite.dart';
import 'package:app/utils/currentUser.dart' as user;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TokenInfo extends StatefulWidget {

  @override
  State<TokenInfo> createState() => TokenInfoState();
}

class TokenInfoState extends State<TokenInfo> {
  var AutoSizeTextGroupTop = AutoSizeGroup();
  var AutoSizeTextGroupItems = AutoSizeGroup();


  @override
  void initState() {
    super.initState();
  }

  updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          height: SizeConfig.blockSizeVertical * 10,
          child: Row(children: [
            Container(width: SizeConfig.blockSizeHorizontal * 33.3),
            Container(
              width: SizeConfig.blockSizeHorizontal * 33.3,
              child: IconButton(
                iconSize: 64,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 64.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(width: SizeConfig.blockSizeHorizontal * 10.3),
            IconButton(
              iconSize: 64,
              icon: ImageIcon(AssetImage('assets/img/Home.png'),
                  size: 64.0, color: Colors.white),
              onPressed: () {},
            ),
          ]),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 10,
          child: Row(children: [
            Container(width: SizeConfig.blockSizeHorizontal * 33.3),
            Container(
                width: SizeConfig.blockSizeHorizontal * 33.3,
                child: Image.asset('assets/img/Owl_Token.png')),
          ]),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                  AppLocalizations.of(context)
                      .translate('owl_tokens')
                      .toUpperCase(),
                  group: AutoSizeTextGroupTop,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  )),
              SizedBox(width: 10),
              AutoSizeText(user.currentUser.points.toString(),
                  group: AutoSizeTextGroupTop,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),

        ///Owl Tokens
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                    AppLocalizations.of(context)
                        .translate('daily_allowence')
                        .toUpperCase(),
                    group: AutoSizeTextGroupTop,
                    maxLines: 1,
                    style: TextStyle(fontSize: 23, color: Colors.white)),
                SizedBox(width: 10),
                AutoSizeText('20',
                    group: AutoSizeTextGroupTop,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            )),

        ///Daily Allowence
        SizedBox(height: 20),

        Container(
          height: SizeConfig.blockSizeVertical * 5,
          child: AutoSizeText(
              AppLocalizations.of(context).translate('owl_token_info'),
              maxLines: 1,
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),

        ///Owl Token Info
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('random_point'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('1',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        ///Random Point
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('quantum_random_point'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('2',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        ///Quantum Random Point
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('amplification_bias'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('2',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        /// Amplification Bias
        SizedBox(height: 30),
        Container(
          height: SizeConfig.blockSizeVertical * 5,
          child: AutoSizeText(
              AppLocalizations.of(context)
                  .translate('ways_to_earn')
                  .toUpperCase(),
              maxLines: 1,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),

        ///Owl Token Info
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('5_day_streak'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/img/double_arrow.png'),
                              size: 64.0,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('5',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.green,
                                )),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        /// Share with friends
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context)
                                .translate('share_with_friends'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/img/double_arrow.png'),
                              size: 64.0,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                FadeRoute(page: Invite()));
                          },
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('5',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.green,
                                )),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        /// Watch ad
        Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        AutoSizeText(
                            AppLocalizations.of(context).translate('watch_ad'),
                            group: AutoSizeTextGroupItems,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/img/double_arrow.png'),
                              size: 64.0,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            AutoSizeText('5',
                                group: AutoSizeTextGroupItems,
                                style: TextStyle(
                                    fontSize: 23, color: Colors.green)),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),

        /// Watch An AD
      ],
    ));
  }
}
