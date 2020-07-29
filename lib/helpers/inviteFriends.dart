import 'package:app/helpers/AppLocalizations.dart';
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
  ).whenComplete(() => {
    print('successcomplete')
  })

      .then((value) => {
  //Share successfull
    print('success')
  });
}