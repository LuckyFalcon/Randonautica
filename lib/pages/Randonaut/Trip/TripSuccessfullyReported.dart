import 'package:app/api/tripSuccessfullyReported.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/models/Attractors.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;

class TripReported extends StatelessWidget {

  var amountOfPointsReceived = 1;

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
            future: tripSuccesfullyReported(),
            builder:
                (BuildContext context, AsyncSnapshot<Attractors> snapshot) {
              if (snapshot.hasData) {
                //A delay so the navigator can pop
            //    Future.delayed(const Duration(milliseconds: 2000), () {
              //    Navigator.pop(context); //Go back to previous navigation item
              //  });
              }
              if(snapshot.hasError){
                //A delay so the navigator can pop
               // Future.delayed(const Duration(milliseconds: 2000), () {
                //  Navigator.pop(context); //Go back to previous navigation item
               // });
              }
              return Center(
                child: Column(children: <Widget>[
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(height: SizeConfig.blockSizeVertical * 3),
                    Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      width: SizeConfig.blockSizeHorizontal * 33.3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, right: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            iconSize: SizeConfig.blockSizeVertical * 100,
                            icon: ImageIcon(
                              AssetImage('assets/img/Owl.png'),
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 15),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 70,
                      child: AutoSizeText(
                          AppLocalizations.of(context)
                              .translate('trip_successfully_recorded'),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 5),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 55,
                      height: SizeConfig.blockSizeVertical * 10,
                      child: Row(
                        children: <Widget>[
                        AutoSizeText(
                            " +  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 64,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        AutoSizeText(
                            amountOfPointsReceived.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 64,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        ImageIcon(
                          AssetImage('assets/img/Owl_Token.png'),
                          color: Colors.white,
                          size: 100,
                        )
                      ],)
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 30),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                              AppLocalizations.of(context)
                                  .translate('back_to_home').toUpperCase() + "    ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white
                          )
                        ],
                      ),),
                    ),
                  ])
                ]),
              );
            }),
      ),
    );
  } //
}
