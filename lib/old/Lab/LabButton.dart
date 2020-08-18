//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//
//import '../../helpers/AppLocalizations.dart';
//
//class LabButton extends StatefulWidget {
//  Function callback;
//  bool pressPurchaseKey = false;
//
//  LabButton(this.callback, this.pressPurchaseKey);
//
//  State<StatefulWidget> createState() => new _LabButtonState();
//}
//
//class _LabButtonState extends State<LabButton> {
//  bool pressPurchaseKey = false;
//
//  void callback(bool pressPurchaseKey) {
//    setState(() {
//      this.pressPurchaseKey = pressPurchaseKey;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        width: 250,
//        height: 60,
//        decoration: BoxDecoration(
//            color: Color(0xff5D7FE0),
//            borderRadius: BorderRadius.circular(30),
//            boxShadow: [
//              BoxShadow(
//                  blurRadius: 8,
//                  offset: Offset(0, 15),
//                  color: Colors.black.withOpacity(.6),
//                  spreadRadius: -9)
//            ]),
//        child: RaisedButton(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(30.0),
//          ),
//          padding: EdgeInsets.zero,
//          child: Center(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SizedBox(width: 6),
//                Text(
//                    AppLocalizations.of(context)
//                        .translate('purchase_the_key')
//                        .toUpperCase(),
//                    style: TextStyle(
//                        fontSize: 14,
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold)),
//                SizedBox(width: 10),
//                Icon(
//                  Icons.shopping_cart,
//                  size: 12,
//                ),
//              ],
//            ),
//          ),
//          onPressed: () {},
//          color: Color(0xff5D7FE0),
//        ));
//  }
//}
