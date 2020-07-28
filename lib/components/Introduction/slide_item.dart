import 'package:app/models/slide.dart';
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  var AutoSizeTextGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (index == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              height: SizeConfig.blockSizeVertical * 15,
              width: SizeConfig.blockSizeHorizontal * 68,
              child: AutoSizeText(
                returnSlide(index, context).descriptionone,
                group: AutoSizeTextGroup,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            height: SizeConfig.blockSizeVertical * 20,
            child: AutoSizeText(
              slideList[index].descriptiontwo,
              group: AutoSizeTextGroup,
              textAlign: TextAlign.center,
              maxLines: 5,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            height: SizeConfig.blockSizeVertical * 15,
            child: AutoSizeText(
              slideList[index].descriptionthree,
              group: AutoSizeTextGroup,
              textAlign: TextAlign.center,
              maxLines: 5,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      );
    } else if (index == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              width: SizeConfig.blockSizeHorizontal * 68,
              height: SizeConfig.blockSizeVertical * 27,
              child: AutoSizeText(
                returnSlide(index, context).descriptionone,
                group: AutoSizeTextGroup,
                textAlign: TextAlign.center,
                maxLines: 8,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            height: SizeConfig.blockSizeVertical * 27,
            child: AutoSizeText(
              slideList[index].descriptiontwo,
              group: AutoSizeTextGroup,
              textAlign: TextAlign.center,
              maxLines: 8,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      );
    } else if (index == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              width: SizeConfig.blockSizeHorizontal * 68,
              height: SizeConfig.blockSizeVertical * 15,
              child: AutoSizeText(
                returnSlide(index, context).descriptionone,
                group: AutoSizeTextGroup,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            height: SizeConfig.blockSizeVertical * 20,
            child: AutoSizeText(
              slideList[index].descriptiontwo,
              group: AutoSizeTextGroup,
              textAlign: TextAlign.center,
              maxLines: 8,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: SizeConfig.blockSizeHorizontal * 68,
            height: SizeConfig.blockSizeVertical * 15,
            child: AutoSizeText(
              slideList[index].descriptionthree,
              group: AutoSizeTextGroup,
              textAlign: TextAlign.center,
              maxLines: 5,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      );
    }
  }
}
