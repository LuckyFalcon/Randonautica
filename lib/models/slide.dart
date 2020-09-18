import 'package:fatumbot/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';

///Return slide
returnSlide(index, context){
    //Walkthrough 1
  if(index == 0){
    slideList[index].descriptionone =  AppLocalizations.of(context)
        .translate('walktrhough_1_1')
        .toUpperCase();
    slideList[index].descriptiontwo =  AppLocalizations.of(context)
        .translate('walktrhough_1_2')
        .toUpperCase();
    slideList[index].descriptionthree =  AppLocalizations.of(context)
        .translate('walktrhough_1_3')
        .toUpperCase();
    //Walkthrough 2
  } else if(index == 1) {
    slideList[index].descriptionone = AppLocalizations.of(context)
        .translate('walktrhough_2_1')
        .toUpperCase();
    slideList[index].descriptiontwo = AppLocalizations.of(context)
        .translate('walktrhough_2_2')
        .toUpperCase();
    slideList[index].descriptionthree = AppLocalizations.of(context)
        .translate('walktrhough_2_3')
        .toUpperCase();
    //Walkthrough 3
  }
//  } else if(index == 2){
//    slideList[index].descriptionone =  AppLocalizations.of(context)
//        .translate('walktrhough_3_1')
//        .toUpperCase();
//    slideList[index].descriptiontwo =  AppLocalizations.of(context)
//        .translate('walktrhough_3_2')
//        .toUpperCase();
//    slideList[index].descriptionthree =  AppLocalizations.of(context)
//        .translate('walktrhough_3_3')
//        .toUpperCase();
//  }

  //Return list
  return slideList[index];
}

class Slide {
  final String imageUrl;
  final String title;
  String descriptionone;
  String descriptiontwo;
  String descriptionthree;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.descriptionone,
    @required this.descriptiontwo,
    @required this.descriptionthree,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/img/Andronaut.jpg',
    title: 'A Cool Way to Get Start',
    descriptionone: 'You are about to embark on a journey that allows your imagination to collide with the universe.',
    descriptiontwo: 'As a randonaut, you can create your own legend in real time as you venture to a quantumly generated random coordinate.',
    descriptionthree: 'Set your mind out for adventure, what comes next is sure to be magical...',

  ),
  Slide(
    imageUrl: 'assets/img/Andronaut.jpg',
    title: 'Design Interactive App UI',
    descriptionone: 'You are about to embark on a journey that allows your imagination to collide with the universe.',
    descriptiontwo: 'As a randonaut, you can create your own legend in real time as you venture to a quantumly generated random coordinate.',
    descriptionthree: 'Set your mind out for adventure, what comes next is sure to be magical...',  ),
//  Slide(
//    imageUrl: 'assets/img/Andronaut.jpg',
//    title: 'It\'s Just the Beginning',
//    descriptionone: 'You are about to embark on a journey that allows your imagination to collide with the universe.',
//    descriptiontwo: 'As a randonaut, you can create your own legend in real time as you venture to a quantumly generated random coordinate.',
//    descriptionthree: 'Set your mind out for adventure, what comes next is sure to be magical...',  ),
];