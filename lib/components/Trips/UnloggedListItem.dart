import 'dart:io';

import 'package:app/helpers/FadeRoute.dart';
import 'package:app/pages/List/UnloggedTripDetails.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnloggedListWidget extends StatelessWidget {
  final dateFormatter = DateFormat('yyyy/MM/dd, hh:mm a');

  Function callback;
  int id;
  String location;
  String created;

  UnloggedListWidget(
      {Key key,
        this.callback,
        this.id,
        this.location,
        this.created,})
      : super(key: key);

  var AutoSizeTextGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Divider(
          color: Colors.white,
          height: 2,
        ),
      ),
      Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(
                dateFormatter.format(DateTime.parse(created)),
                group: AutoSizeTextGroup,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: AutoSizeText(
                location,
                group: AutoSizeTextGroup,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 0,
              child:  IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                          page: UnloggedTripDetails(
                            this.callback,
                            this.id,
                            this.location,
                            this.created,
                          )),
                    );
                  }),
            ),
          ]))
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
