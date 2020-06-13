import 'ListSearchBar.dart';
import 'file:///E:/Randonautica/randonautica/lib/components/Shop/subscriptionDialog.dart';
import 'package:app/pages/News.dart';
import 'package:app/pages/Profile.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/AppLocalizations.dart';

class SearchBar extends StatelessWidget {
  var _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Container(
          height: 60,
          padding: EdgeInsets.only(bottom: 25, left: 50, right: 45),
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff7BBFFE),
                borderRadius: BorderRadius.circular(30),
              ),
              child: GestureDetector(
                onTap: () {
                  print('test');
                  Navigator.of(context, rootNavigator: true)
                      .push(new CupertinoPageRoute<bool>(
                      builder: (BuildContext context) => new SearchPage()));
                },
                child:  Text(
                  'Hello,  How are you?',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )

              )),
        ));
  }
}

//class SecondPageRoute extends CupertinoPageRoute {
//  SecondPageRoute()
//      : super(builder: (BuildContext context) => new ListSearchBar());
//
//  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
//  @override
//  Widget buildPage(BuildContext context, Animation<double> animation,
//      Animation<double> secondaryAnimation) {
//    return new FadeTransition(opacity: animation, child: new ListSearchBar());
//  }
//}

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
