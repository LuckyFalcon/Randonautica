import 'package:app/models/slide_warnings.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SlideWarningItem extends StatelessWidget {
  final int index;

  SlideWarningItem(this.index);

  var AutoSizeTextGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//        Container(
//            child: Image(image: AssetImage(slideWarningList[index].imageUrl))),
        Container(
            width: SizeConfig.blockSizeHorizontal * 65,
            height: SizeConfig.blockSizeVertical * 10,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                AutoSizeText(
                  returnWarningSlide(index, context).firstLine,
                  textAlign: TextAlign.center,
                  group: AutoSizeTextGroup,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 15),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                AutoSizeText(
                  returnWarningSlide(index, context).secondLine,
                  textAlign: TextAlign.center,
                  group: AutoSizeTextGroup,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 15),
                )
              ],
            ))
      ],
    );
  }
}
