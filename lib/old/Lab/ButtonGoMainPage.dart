//import 'package:app/utils/size_config.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//import '../../helpers/AppLocalizations.dart';
//
//class ButtonGoLab extends StatefulWidget {
//  Function callback;
//  bool pressGoButton = false;
//
//  ButtonGoLab(this.callback, this.pressGoButton);
//
//  State<StatefulWidget> createState() => new _ButtonGoLab();
//}
//
//class _ButtonGoLab extends State<ButtonGoLab> {
//  bool pressGoButton = false;
//  AudioCache _audioCache;
//
//  @override
//  void initState() {
//    super.initState();
//
//    ///Todo do some audio stuff or something
//    _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
//  }
//  void _toggleGoPressButton() {
//    setState(() {
//      if (pressGoButton) {
//        pressGoButton = false;
//      } else {
//        pressGoButton = true;
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SizeConfig().init(context);
//
//    return Container(
//
//        height: SizeConfig.blockSizeVertical * 9,
//        width: SizeConfig.blockSizeHorizontal * 30,
//        decoration: BoxDecoration(
//            color: Color(0xff5D7FE0),
//            borderRadius: BorderRadius.circular(90),
//            boxShadow: [
//              BoxShadow(
//                  blurRadius: 14,
//                  offset: Offset(10, 10),
//                  color: Colors.black.withOpacity(.6),
//                  spreadRadius: -15)
//            ]),
//        child: RaisedButton(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(90.0),
//          ),
//          padding: EdgeInsets.zero,
//          child: Center(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(AppLocalizations.of(context).translate('go').toUpperCase(),
//                    style: TextStyle(
//                        fontSize: 40,
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold)),
//              ],
//            ),
//          ),
//
//          onPressed: () {
//            //_audioCache.play('inceptionbutton.mp3');
//            _toggleGoPressButton();
//            //Rebuild state with the selectedNavigationIndex that was tapped in bottom navbar
//            return setState(() {
//              this.widget.pressGoButton = this.widget.pressGoButton;
//              this.widget.callback(pressGoButton); //Callback to Main
//            });
//          },
//          color: Color(0xff5987E3),
//        ));
//  }
//}
