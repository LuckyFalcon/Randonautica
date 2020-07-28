import 'package:app/models/slide.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {

  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            child: new Column(
              children: <Widget>[
                Text(
                  returnSlide(index, context).descriptionone,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                )
              ],
            )),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            child: new Column(
              children: <Widget>[
                Text(
                  slideList[index].descriptiontwo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                ),
              ],
            )),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            child: new Column(
              children: <Widget>[
                Text(
                  slideList[index].descriptionthree,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                ),
              ],
            )),
      ],
    );
  }
}
