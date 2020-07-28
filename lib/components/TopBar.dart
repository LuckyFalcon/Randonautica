import 'package:app/pages/Profile.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/currentUser.dart' as globals;
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';


import '../pages/Shop/ShopModal.dart';

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
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child:
            Container(
                width: SizeConfig.blockSizeHorizontal * 25,
              child:
            Row(
              children: <Widget>[
                IconButton(
                  iconSize: 32,
                  icon: ImageIcon(
                    AssetImage('assets/img/Owl_Token.png'),
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(60.0),
                              topRight: const Radius.circular(60.0)),
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
                              color: Theme.of(context).primaryColor,
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(60.0),
                                  topRight: const Radius.circular(60.0))),
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 90,
                            child: BS(),
                          ),
                        )).whenComplete(() async {
                          await FlutterInappPurchase.instance.endConnection;
                    });
                  },
                ),
                Text(globals.currentUser.points.toString(),
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ))
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 45),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 64,
              icon: ImageIcon(
                AssetImage('assets/img/Owl.png'),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
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
                          child: BS(),
                        )).whenComplete(() async {
                  await FlutterInappPurchase.instance.endConnection;
                });
              },
            ),
          ),
        ),
      ]),
    );
  }
}