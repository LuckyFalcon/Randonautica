import 'dart:io';

import 'package:app/helpers/FadeRoute.dart';
import 'package:app/pages/List/LoggedTripDetails.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoggedListItem extends StatelessWidget {
  String gid;
  String location;
  String datetime;
  String latitude;
  String longitude;
  String radius;
  String type;
  String power;
  String zScore;
  String pseudo;
  String report;
  String title;
  String imagelocation;
  String text;
  List tagList;

  LoggedListItem(
      {Key key,
      this.gid,
      this.location,
      this.datetime,
      this.latitude,
      this.longitude,
      this.radius,
      this.type,
      this.power,
      this.zScore,
      this.pseudo,
      this.report,
      this.title,
      this.imagelocation,
      this.text,
      this.tagList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(datetime);
    String dateFormat = DateFormat('EEEE').format(date);

    SizeConfig().init(context);
    return new Container(
        alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Divider(
                color: Colors.white,
                height: 2,
              ),
            ),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 10),
              imagelocation == null
                  ? Text(
                      imagelocation,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  : Container(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      height: SizeConfig.blockSizeVertical * 10,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: FileImage(File(imagelocation)),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    offset: Offset(0, 15),
                                    color: Colors.black.withOpacity(.6),
                                    spreadRadius: -9)
                              ]),
                        ),
                      )),
              SizedBox(width: 10),
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          width: SizeConfig.blockSizeHorizontal * 54,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      this.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      dateFormat,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  this.location,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 9,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Flexible(
                                        child: AutoSizeText(
                                          'hello my name is david hello my name is david  hello my name is david hello my name is david hello my name is david ',
                                          maxLines: 4,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 24.0,
                                          semanticLabel:
                                              'Text to announce in accessibility modes',
                                        ),
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            FadeRoute(
                                                page: LoggedTripDetails(
                                                    this.location,
                                                    this.datetime,
                                                    this.title,
                                                    this.imagelocation,
                                                    this.text,
                                                    this.tagList)),
                                          );
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
            SizedBox(height: 5),
          ],
        ));
  }
}
