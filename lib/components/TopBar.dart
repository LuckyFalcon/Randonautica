import 'package:app/pages/News.dart';
import 'package:app/pages/Profile.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 32,
              icon: ImageIcon(
                AssetImage('assets/img/Profile.png'),
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(_createProfileRoute());
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 15),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 48,
              icon: ImageIcon(
                AssetImage('assets/img/Owl.png'),
                color: Colors.white,
              ),
              onPressed: () {
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 32,
              icon: ImageIcon(AssetImage('assets/img/pods.png'),
                  size: 64.0, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(_createInboxRoute());
              },
            ),
          ),
        ),

      ]),
    );
  }
}

//Create route to profile
Route _createProfileRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => profile(),
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
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

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
