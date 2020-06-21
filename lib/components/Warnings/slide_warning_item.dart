import 'package:app/models/slide_warnings.dart';
import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class SlideWarningItem extends StatelessWidget {
  final int index;

  SlideWarningItem(this.index);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Image(image: AssetImage(slideWarningList[index].imageUrl))),
        Container(
            width: SizeConfig.blockSizeHorizontal * 60,
            height: SizeConfig.blockSizeVertical * 10,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Text(
                  returnWarningSlide(index, context).firstLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 16),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text(
                  returnWarningSlide(index, context).secondLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 16),
                )
              ],
            ))
      ],
    );
  }
}
