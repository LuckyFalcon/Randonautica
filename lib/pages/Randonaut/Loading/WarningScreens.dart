import 'dart:async';

import 'package:fatumbot/api/getAttractors.dart';
import 'package:fatumbot/components/Warnings/slide_warning_dots.dart';
import 'package:fatumbot/components/Warnings/slide_warning_item.dart';
import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:fatumbot/models/slide_warnings.dart';
import 'package:fatumbot/utils/BackgroundColor.dart' as backgrounds;
import 'package:fatumbot/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WarningScreens extends StatefulWidget {
  Function callback;
  LocationData currentLocation;
  int radius;
  int selectedPoint;
  int selectedRandomness;
  bool checkWater;

  WarningScreens(this.callback, this.radius, this.currentLocation,
      this.selectedPoint, this.selectedRandomness, this.checkWater);

  @override
  _WarningScreensState createState() => _WarningScreensState();
}

class _WarningScreensState extends State<WarningScreens> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _enablePageAnimation();
    _fetchAttractors();
  }

  _enablePageAnimation() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _fetchAttractors() async {
    try {
      await fetchAttractors(
              this.widget.radius,
              this.widget.currentLocation.latitude,
              this.widget.currentLocation.longitude,
              this.widget.selectedPoint,
              this.widget.selectedRandomness,
              this.widget.checkWater)
          .then((value) => {
                this.widget.callback(value),
                //A delay so the navigator can pop
                Future.delayed(const Duration(milliseconds: 2000), () {
                  Navigator.pop(context); //Go back to previous navigation item
                })
              });
    } catch (error) {
      Navigator.pop(context); //Go back to previous navigation item

      //Small delay for popup
      Future.delayed(const Duration(milliseconds: 500), () {
        this.widget.callback(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
            decoration: backgrounds.dark,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  Container(
                    height: SizeConfig.blockSizeVertical * 10,
                    width: SizeConfig.blockSizeHorizontal * 33.3,
//                    child: Padding(
//                      padding: const EdgeInsets.only(top: 0.0, right: 0),
//                      child: Align(
//                        alignment: Alignment.center,
//                        child: IconButton(
//                          iconSize: SizeConfig.blockSizeVertical * 100,
//                          icon: ImageIcon(
//                            AssetImage('assets/img/Owl.png'),
//                            color: Colors.white,
//                          ),
//                          onPressed: () {},
//                        ),
//                      ),
//                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 5),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    child: AutoSizeText(
                        AppLocalizations.of(context)
                            .translate('generating_point'),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 5),
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
                                    itemBuilder: (ctx, i) =>
                                        SlideWarningItem(i),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
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
                ],
              ),
            )),
      ),
    );
  }
}
