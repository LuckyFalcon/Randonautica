import 'package:app/helpers/FadeRoute.dart';
import 'package:app/pages/Profile/Profile.dart';
import 'package:app/pages/Profile/Settings.dart';
import 'package:app/pages/Randonaut/Trip/FinishTrip.dart';
import 'package:app/pages/Shop/Shop.dart';
import 'package:app/pages/Token/TokenInfo.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBarV2 extends StatefulWidget {

  State<StatefulWidget> createState() => new _TopBarState();
}


class _TopBarState extends State<TopBarV2> {

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    print(statusBarHeight);
    SizeConfig().init(context);
    return Padding(
        padding: new EdgeInsets.only(top: statusBarHeight, left: 0),
    child: Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Row(children: [
        Container(
          height: SizeConfig.blockSizeVertical * 10,
          width: SizeConfig.blockSizeHorizontal * 33.3,
          child: Padding(
            padding: new EdgeInsets.only(top: statusBarHeight, left: 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 5,
                  child:
                    Stack(
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,

                          decoration: BoxDecoration(
                            color: const Color(0xff5F6676),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: new Image.asset('assets/img/Owl_Token.png'),
                              onPressed: () {
                                Navigator.push(
                                    context, FadeRoute(page: TokenInfo()));
                              },
                            ),
                            Container(
                                child: AutoSizeText(
                                    '∞',
                                    maxLines: 1,
                                    minFontSize: 12,
                                    maxFontSize: 23,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: '')))
                          ],
                        )
                      ],
                    ),
                  )),
          ),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 10,
          width: SizeConfig.blockSizeHorizontal * 33.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 0),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                iconSize: SizeConfig.blockSizeVertical * 100,
                icon: ImageIcon(
                  AssetImage('assets/img/Owl.png'),
                  color: Colors.white,
                ),
                onPressed: () {
                },
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
