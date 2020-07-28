import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Overlaytest {
  static Widget show(BuildContext context) {

    final spinkit = SpinKitRipple(
      color: Colors.red,
      size: 150.0,
    );

    return Container(
      child: spinkit,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0),
    );
  }
}