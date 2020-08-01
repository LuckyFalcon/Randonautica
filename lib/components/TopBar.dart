import 'package:app/pages/Profile/Profile.dart';
import 'package:app/pages/Shop/Shop.dart';
import 'package:app/pages/Token/TokenInfo.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class TopBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 33.3,
              child:  Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Align(
                    alignment: Alignment.topLeft,
                    child:
                    Container(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child:
                        Row(
                          children: <Widget>[
                            IconButton(
                              iconSize: 32,
                              icon: ImageIcon(
                                AssetImage('assets/img/Profile.png'),
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(new CupertinoPageRoute<bool>(
                                    builder: (BuildContext context) => new profile()));
                              },
                            ),

                          ],
                        ))
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 33.3,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 0),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    iconSize: SizeConfig.blockSizeVertical * 10,
                    icon: ImageIcon(
                      AssetImage('assets/img/Owl.png'),
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 33.3,
              child:         Padding(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    iconSize: 32,
                    icon: ImageIcon(AssetImage('assets/img/pods.png'),
                        size: 64.0, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(90.0),
                                topRight: const Radius.circular(90.0)),
                          ),
                          useRootNavigator: false,
                          context: context,
                          builder: (context) => Container(
                            height: SizeConfig.blockSizeVertical * 90,
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0,
                                      5.0
                                    ],
                                    colors: [
                                      Color(0xff383B46),
                                      Color(0xff5786E1)
                                    ]),
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(90.0),
                                    topRight: const Radius.circular(90.0))),
                            child: Shop(),
                          )).whenComplete(() async {
                        await FlutterInappPurchase.instance.endConnection;
                      });
                    },
                  ),
                ),
              ),
            ),
      ]),
    );
  }
}