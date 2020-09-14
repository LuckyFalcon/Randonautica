import 'dart:async';

import 'package:app/components/Introduction/EnterRandonauticaButton.dart';
import 'package:app/components/Introduction/slide_dots.dart';
import 'package:app/components/Introduction/slide_item.dart';
import 'package:app/models/slide.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:flutter/material.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 5000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody:true,
      body: Container(
        decoration: backgrounds.dark,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ImageIcon(AssetImage('assets/img/Owl.png'),
                  color: Colors.white, size: 64),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 60,
                child:
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                    ],
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < slideList.length; i++)
                      if (i == _currentPage)
                        SlideDots(true)
                      else
                        SlideDots(false)
                  ],
                ),
              ),
              (_currentPage == 1 ? EnterRandonauticaButton() : SizedBox(
                height: 0,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
