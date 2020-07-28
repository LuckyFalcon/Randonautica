import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/currentUser.dart' as user;

class TokenInfo extends StatefulWidget {
  Function callbackGoPremium;
  TokenInfo(this.callbackGoPremium);

  @override
  State<TokenInfo> createState() => TokenInfoState();
}

class TokenInfoState extends State<TokenInfo> {

  goToShop(bool goToShopButtonClicked){
    this.widget.callbackGoPremium(true);
  }

  @override
  void initState() {
    super.initState();
  }

  updateState() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 80),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.center,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 64,
                        icon: ImageIcon(AssetImage('assets/img/Home.png'),
                            size: 64.0, color: Colors.white),
                        onPressed: () {
//                openAlertBox(context);
                          goToShop(true);
                        },
                      ),
                    ),
                  ),
                ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 150, bottom: 15),
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/img/Owl_Token.png')
                ),
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    AppLocalizations.of(context)
                        .translate('owl_tokens')
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                    )),
                SizedBox(width: 10),
                Text(
                    user.currentUser.points.toString(),
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ), ///Owl Tokens
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    AppLocalizations.of(context)
                        .translate('daily_allowence')
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white)),
                SizedBox(width: 10),
                Text('20',
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white)),
              ],
            ), ///Daily Allowence
            SizedBox(height: 30),
            Text(AppLocalizations.of(context).translate('owl_token_info'),
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)), ///Owl Token Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate('random_point'),
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 30),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('1',
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
            ), ///Random Point
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate('quantum_random_point'),
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('2',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white)),
                            Image.asset(
                              'assets/img/Owl_Token.png',
                              width: 40,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ), ///Quantum Random Point
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate('amplification_bias'),
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('5',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.green,
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
            ), /// Amplification Bias
            SizedBox(height: 30),
            Text(AppLocalizations.of(context).translate('ways_to_earn').toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)), /// Ways to Earn
            SizedBox(height: 30),
            Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: <Widget>[
                  Text( AppLocalizations.of(context)
                      .translate('5_day_streak'),
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                         )),
                  IconButton(
                    icon: ImageIcon(AssetImage('assets/img/double_arrow.png'),
                        size: 64.0, color: Colors.white),
                    onPressed: (){

                    },
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child:
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 30),
                  child: Row(
                    children: <Widget>[
                      Text('5',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.green,
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
      ), /// 5 Day Streak
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: <Widget>[
                        Text( AppLocalizations.of(context)
                            .translate('share_with_friends'),
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: ImageIcon(AssetImage('assets/img/double_arrow.png'),
                              size: 64.0, color: Colors.white),
                          onPressed: (){

                          },
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('5',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.green,
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
            ), /// Share With Friends
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: <Widget>[
                        Text( AppLocalizations.of(context)
                            .translate('watch_ad'),
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: ImageIcon(AssetImage('assets/img/double_arrow.png'),
                              size: 64.0, color: Colors.white),
                          onPressed: (){

                          },
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30),
                        child: Row(
                          children: <Widget>[
                            Text('5',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.green,
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
            ), /// Watch An AD
          ],
        )
    );
  }

}
