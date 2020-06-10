import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

void inviteFriends(BuildContext context) {

  //Render share function
  final RenderBox box = context.findRenderObject();

  final String shareSubject =
  AppLocalizations.of(context).translate('share_subject');

  final String shareDescription =
  AppLocalizations.of(context).translate('share_text_description');

  Share.share(
    shareDescription,
    subject: shareSubject,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  ).then((value) =>
  //Share successfull
  ///Todo at this point remove previous navigation items
  Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute<bool>(builder: (context) => HomePage()),
      ModalRoute.withName("/Home")
  ));
}