import 'package:fatumbot/api/getAttractors.dart';
import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:fatumbot/models/Attractors.dart';
import 'package:fatumbot/utils/BackgroundColor.dart' as backgrounds;
import 'package:fatumbot/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:location/location.dart';

class LoadingPoints extends StatefulWidget {
  Function callback;
  LocationData currentLocation;
  int radius;
  int selectedPoint;
  int selectedRandomness;
  bool checkWater;

  LoadingPoints(this.callback, this.radius, this.currentLocation,
      this.selectedPoint, this.selectedRandomness, this.checkWater);

  @override
  State createState() => new LoadingPointsState();
}

class LoadingPointsState extends State<LoadingPoints>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
    _animation = new IntTween(begin: 27, end: 34).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
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
        backgroundColor: Colors.yellow[200],
        body: Container(
          decoration: backgrounds.dark,
          child: FutureBuilder<Attractors>(
              future: fetchAttractors(
                  this.widget.radius,
                  this.widget.currentLocation.latitude,
                  this.widget.currentLocation.longitude,
                  this.widget.selectedPoint,
                  this.widget.selectedRandomness,
                  this.widget.checkWater),
              builder:
                  (BuildContext context, AsyncSnapshot<Attractors> snapshot) {
                if (snapshot.hasData) {
                  this.widget.callback(snapshot.data);

                  //A delay so the navigator can pop
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    Navigator.pop(
                        context); //Go back to previous navigation item
                  });
                }
                if (snapshot.hasError) {
                  Navigator.pop(context); //Go back to previous navigation item

                  //Small delay for popup
                  Future.delayed(const Duration(milliseconds: 500), () {
                    this.widget.callback(snapshot.data);
                  });
                }
                return Center(
                  child: Column(children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.blockSizeVertical * 3),
                          Container(
                            height: SizeConfig.blockSizeVertical * 10,
                            width: SizeConfig.blockSizeHorizontal * 33.3,
//                            child: Padding(
//                              padding:
//                                  const EdgeInsets.only(top: 0.0, right: 0),
//                              child: Align(
//                                alignment: Alignment.center,
//                                child: IconButton(
//                                  iconSize: SizeConfig.blockSizeVertical * 100,
//                                  icon: ImageIcon(
//                                    AssetImage('assets/img/Owl.png'),
//                                    color: Colors.white,
//                                  ),
//                                  onPressed: () {},
//                                ),
//                              ),
//                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 15),
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
                          SizedBox(height: SizeConfig.blockSizeVertical * 10),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeVertical * 10,
                            child: LoadingBouncingGrid.square(
                              borderColor: Colors.cyan,
                              borderSize: 3.0,
                              backgroundColor: Colors.cyanAccent,
                              duration: Duration(milliseconds: 500),
                            )
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 10),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: AutoSizeText(
                                AppLocalizations.of(context)
                                    .translate('use_this_moment'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ])
                  ]),
                );
              }),
        ),
      ),
    );
  } //
}
