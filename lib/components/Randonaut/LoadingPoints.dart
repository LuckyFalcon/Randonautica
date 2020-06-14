import 'package:app/api/getAttractors.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/FadingCircleLoading.dart';
import 'package:app/models/Attractors.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

class LoadingPoints extends StatelessWidget {
  Function callback;
  int radius;
  LocationData currentLocation;

  LoadingPoints(this.callback, this.radius, this.currentLocation);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.yellow[200],
      body: Container(
        decoration: backgrounds.normal,
        child: FutureBuilder<Attractors>(
            future: fetchAttractors(
                radius, currentLocation.latitude, currentLocation.longitude),
            builder:
                (BuildContext context, AsyncSnapshot<Attractors> snapshot) {
              if (snapshot.hasData) {
                Navigator.pop(context); //Go back to previous navigation item
                callback(snapshot.data);
              }
              return Center(
                child: Column(children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(height: SizeConfig.blockSizeVertical * 3),
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 15),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Text(
                          AppLocalizations.of(context)
                              .translate('generating_point'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 10),
                    FadingCircleLoading(
                      color: Colors.white,
                      size: 75.0,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 10),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 40,
                      child: Text(
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
    );
  } //
}
