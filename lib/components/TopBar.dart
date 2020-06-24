import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/pages/News/News.dart';
import 'package:app/pages/Profile.dart';
import 'package:app/pages/Shop/Shop.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              iconSize: 32,
              icon: ImageIcon(
                AssetImage('assets/img/Profile.png'),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(new CupertinoPageRoute<bool>(
                  builder: (BuildContext context) => new profile(),
                ));
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 15),
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
//                openAlertBox(context);
                Navigator.of(context, rootNavigator: true)
                    .push(new CupertinoPageRoute<bool>(
                  builder: (BuildContext context) => new Shop(),
                ));
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute() : super(builder: (BuildContext context) => new profile());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new profile());
  }
}

////Create route to profile
//Route _createProfileRoute() {
//  return PageRouteBuilder(
//    transitionDuration: Duration(milliseconds: 500),
//    pageBuilder: (context, animation, secondaryAnimation) => profile(),
//    transitionsBuilder: (context, animation, secondaryAnimation, child) {
//      var begin = Offset(0.0, 1.0);
//      var end = Offset.zero;
//      var curve = Curves.ease;
//      var tween = Tween(begin: begin, end: end);
//      var curvedAnimation = CurvedAnimation(
//        parent: animation,
//        curve: curve,
//      );
//
//      return SlideTransition(
//        position: Tween<Offset>(
//          begin: const Offset(-1, 0),
//          end: Offset.zero,
//        ).animate(animation),
//        child: child,
//      );
//    },
//  );
//}

//Create route to profile
Route _createInboxRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => News(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
