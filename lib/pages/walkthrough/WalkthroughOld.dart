//import 'package:app/models/page_decoration.dart';
//import 'package:app/models/page_view_model.dart';
//import 'package:app/pages/Randonaut.dart';
//import 'package:dots_indicator/dots_indicator.dart';
//
//import 'package:app/helpers/AppLocalizations.dart';
//import 'package:flutter/material.dart';
//
//import '../../introduction_screen.dart';
//
//class Walkthrough extends StatefulWidget {
//  @override
//  State<Walkthrough> createState() => WalkthroughState();
//}
//
//class WalkthroughState extends State<Walkthrough> {
//  final introKey = GlobalKey<IntroductionScreenState>();
//
//  void _onIntroEnd(context) {
//    Navigator.of(context).push(
//      MaterialPageRoute(builder: (_) => Randonaut()),
//    );
//  }
//
//  Widget _buildImage(String assetName) {
//    return Align(
//      child: Image.asset('assets/$assetName.jpg', width: 350.0),
//      alignment: Alignment.bottomCenter,
//    );
//  }
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    const bodyStyle = TextStyle(fontSize: 19.0);
//    const pageDecoration = const PageDecoration(
//      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//      bodyTextStyle: bodyStyle,
//      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//      pageColor: Colors.white,
//      imagePadding: EdgeInsets.zero,
//    );
//    return IntroductionScreen(
//      key: introKey,
//      decoration: BoxDecoration(
//          gradient: LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.center,
//              stops: [0, 1],
//              colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
//      pages: [
//        PageViewModel(
//          gradientDecoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomRight,
//                  stops: [0, 1],
//                  colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
//          title: "Fractional shares",
//          column: Column(
//            children: <Widget>[
//              Text(
//                  AppLocalizations.of(context)
//                      .translate('walktrhough_1_1'),
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//              SizedBox(height: 20),
//              Text(
//                  AppLocalizations.of(context)
//                      .translate('walktrhough_1_2'),
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//              SizedBox(height: 20),
//              Text(
//                  AppLocalizations.of(context)
//                      .translate('walktrhough_1_3'),
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//            ],
//          ),
//          image: _buildImage('img1'),
//          decoration: pageDecoration,
//        ),
//      ],
//      onDone: () => _onIntroEnd(context),
//      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//      showSkipButton: false,
//      showNextButton: false,
//      skipFlex: 0,
//      nextFlex: 0,
//      skip: const Text('Skip'),
//      next: const Icon(Icons.arrow_forward),
//      done: const Text('', style: TextStyle(fontWeight: FontWeight.w600)),
//      dotsDecorator: const DotsDecorator(
//        size: Size(10.0, 10.0),
//        color: Color(0xFFBDBDBD),
//        activeSize: Size(22.0, 10.0),
//        activeShape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(Radius.circular(25.0)),
//        ),
//      ),
//    );
//  }
////Functions
//}
