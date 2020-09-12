import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

///Return slide
returnWarningSlide(index, context){
    //Walkthrough 1
  if(index == 0){
    slideWarningList[index].firstLine =  AppLocalizations.of(context)
        .translate('warning_1');
    slideWarningList[index].secondLine =  AppLocalizations.of(context)
        .translate('warning_1_1');
    //Walkthrough 2
  } else if(index == 1){
    slideWarningList[index].firstLine =  AppLocalizations.of(context)
        .translate('warning_2');
    slideWarningList[index].secondLine =  AppLocalizations.of(context)
        .translate('warning_2_1');
    //Walkthrough 3
  } else if(index == 2){
    slideWarningList[index].firstLine =  AppLocalizations.of(context)
        .translate('warning_3_1');
    slideWarningList[index].secondLine =  AppLocalizations.of(context)
        .translate('warning_3_2');
  }

  //Return list
  return slideWarningList[index];
}

class WarningSlide {
  final String imageUrl;
  String firstLine;
  String secondLine;

  WarningSlide({
    @required this.imageUrl,
    @required this.firstLine,
    @required this.secondLine,
  });
}

final slideWarningList = [
  WarningSlide(
    imageUrl: 'assets/img/Warnings/Warning1.png',
  ),
  WarningSlide(
    imageUrl: 'assets/img/Warnings/Warning2.png',
  ),
  WarningSlide(
    imageUrl: 'assets/img/Warnings/Warning3.png',
  ),
];