import 'dart:async';

import 'package:app/components/Warnings/slide_warning_dots.dart';
import 'package:app/components/Warnings/slide_warning_item.dart';
import 'package:app/helpers/FadingCircleLoading.dart';
import 'package:app/models/slide_warnings.dart';

import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class WarningScreens extends StatefulWidget {
  @override
  _WarningScreensState createState() =>
      _WarningScreensState();
}

class _WarningScreensState
    extends State<WarningScreens> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
      extendBody: true,
      body: Container(
        decoration: backgrounds.normal,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ImageIcon(AssetImage('assets/img/Owl.png'),
                  color: Colors.white, size: 64),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 10, ///Todo
              ),
              Container(
                height: SizeConfig.blockSizeHorizontal * 75,
                width: SizeConfig.blockSizeHorizontal * 80,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                  color: Colors.black.withOpacity(.6),
                                  spreadRadius: -5)
                            ]),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _pageController,
                                onPageChanged: _onPageChanged,
                                itemCount: slideWarningList.length,
                                itemBuilder: (ctx, i) => SlideWarningItem(i),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5, ///Todo
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < slideWarningList.length; i++)
                      if (i == _currentPage)
                        SlideWarningDots(true)
                      else
                        SlideWarningDots(false)
                  ],
                ),
              ),
              SizedBox(
                height: 50, ///Todo
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadingCircleLoading(
                    color: Colors.white,
                    size: 75.0,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
