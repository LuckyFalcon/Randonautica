import 'package:app/api/signInStreak.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/utils/currentUser.dart' as user;

import 'Dialogs.dart';

Future<void> SignInStreak(BuildContext context) async {

  //Get current date
  final currentDate = DateTime.now();

  //Parse the currentSignedInStreak date to valid DateTime
  DateTime currentSignedInStreak = DateTime.parse(user.currentUser.startedSignedInStreakDatetime.toString());

  //Check the difference between the currentSignedInStreak and current date
  final differenceInHours = currentDate.difference(currentSignedInStreak).inHours;

  //When the difference is bigger than 24 hours send request to backend
  if(differenceInHours >= 24){

    //Send request
    await signInStreak().then((value) =>
    {
      if(value == 200){
        //Show Streak Dialog
        randonauticaStreakDialog(context, user.currentUser.currentSignedInStreak+1)
      }
    }
    );

  }

}