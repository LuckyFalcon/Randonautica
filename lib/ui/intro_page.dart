import 'package:app/models/page_view_model.dart';
import 'package:flutter/material.dart';

import 'intro_content.dart';

class IntroPage extends StatelessWidget {
  final PageViewModel page;

  const IntroPage({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              stops: [0, 1],
              colors: [Color(0xff383B46), Color(0xff5E80E0)])),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (page.image != null)
//              Expanded(
//                flex: page.decoration.imageFlex,
//                child: Padding(
//                  padding: page.decoration.imagePadding,
//                  child: page.image,
//                ),
//              ),
            Expanded(
              flex: page.decoration.bodyFlex,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: IntroContent(page: page),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
