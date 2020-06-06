import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

void inviteFriends(BuildContext context) {

  //Render share function
  final RenderBox box = context.findRenderObject();

  //Subject
  final String shareSubject =
  AppLocalizations.of(context).translate('share_subject');

  //Description
  final String shareDescription =
  AppLocalizations.of(context).translate('share_text_description');

  //Init share
  Share.share(
    shareDescription,
    subject: shareSubject,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}