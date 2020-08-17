import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadeRoute.dart';
import 'package:app/utils/currentUser.dart' as user;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;

import '../../pages/Invite/Invite.dart';

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: backgrounds.normal,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: SizeConfig.blockSizeVertical * 90,
            width: SizeConfig.blockSizeHorizontal * 80,
            child: Stack(
              children: <Widget>[
                Container(
                    height: SizeConfig.blockSizeVertical * 90,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            offset: Offset(0, 15),
                            color: Colors.black.withOpacity(.6),
                            spreadRadius: -9)
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                       Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(width: SizeConfig.blockSizeHorizontal * 20),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 33.3,
                              child: IconButton(
                                iconSize: 64,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff5988E3),
                                  size: 64.0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            IconButton(
                              iconSize: 64,
                              icon: ImageIcon(AssetImage('assets/img/Home.png'),
                                  size: 64.0, color: Color(0xff5988E3)),
                              onPressed: () {},
                            ),
                          ]),
                          Row(
                            children: <Widget>[
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
                              Container(
                                height: SizeConfig.blockSizeVertical * 10,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Container(
                                      child: Image.asset('assets/img/Owl_Token.png', color: Color(0xff5988E3),
                                          height: 128, width: 128)),
                                ]),
                              ),
                              Container(
                                  height: SizeConfig.blockSizeVertical * 6,
                                  child: AutoSizeText(user.currentUser.points.toString(),
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 64, color: Color(0xff37CDDC), fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),

                          ///Daily Allowence
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
                                      style: TextStyle(fontSize: 23, color: Color(0xff37CDDC), fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  AutoSizeText('20',
                                      group: AutoSizeTextGroupTop,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 20, color: Color(0xff37CDDC), fontWeight: FontWeight.bold)),
                                ],
                              )),

                          Container(
                              height: SizeConfig.blockSizeVertical * 35,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              child: Image.asset('assets/img/Prices.png')),


                          ///Ways to earn
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
                                    color: Color(0xff37CDDC))),
                          ),

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
                                                color: Color(0xff37CDDC),
                                              )),
                                          IconButton(
                                            icon: ImageIcon(
                                                AssetImage('assets/img/double_arrow.png'),
                                                size: 64.0,
                                                color: Color(0xff37CDDC)),
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
                                              AutoSizeText('5 ',
                                                  group: AutoSizeTextGroupItems,
                                                  style: TextStyle(
                                                      fontSize: 15, color: Color(0xff37CDDC))),
                                              Image.asset(
                                                  'assets/img/Owl_Token.png',
                                                  color: Color(0xff37CDDC),
                                                  width: 28,
                                                  height: 28
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
                                                fontSize: 15,
                                                color: Color(0xff37CDDC),
                                              )),
                                          IconButton(
                                            icon: ImageIcon(
                                                AssetImage('assets/img/double_arrow.png'),
                                                size: 64.0,
                                                color: Color(0xff37CDDC)),
                                            onPressed: () {
                                              Navigator.push(context, FadeRoute(page: Invite()));
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
                                              AutoSizeText('5 ',
                                                  group: AutoSizeTextGroupItems,
                                                  style: TextStyle(
                                                      fontSize: 23, color: Color(0xff37CDDC))),
                                              Image.asset(
                                                  'assets/img/Owl_Token.png',
                                                  color: Color(0xff37CDDC),
                                                  width: 28,
                                                  height: 28
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
