import 'dart:convert';
import 'dart:io';

import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;

class LoggedTripDetails extends StatefulWidget {

  String location;
  String dateTime;
  String title;
  String imagelocation;
  String text;
  List tagList;

  LoggedTripDetails(
      this.location,
      this.dateTime,
      this.title,
      this.imagelocation,
      this.text,
      this.tagList);

  @override
  State<LoggedTripDetails> createState() => LoggedTripDetailsState();
}

class LoggedTripDetailsState extends State<LoggedTripDetails> {

  String location;
  String dateTime;
  String title;
  String imagelocation;
  String text;
  List tagList = [];

  @override
  void initState() {
    super.initState();
    location = this.widget.location;
    dateTime = this.widget.dateTime;
    title = this.widget.title;
    imagelocation = this.widget.imagelocation;
    text = this.widget.text;
    if(this.widget.tagList != null){
      for(int i = 0; i < this.widget.tagList.length; i ++){
        if(this.widget.tagList[i] != null){
          tagList.add(this.widget.tagList[i]);
        }
      }
    }

  }

  List _items = ['0'];
  double _fontSize = 14;

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];


  var _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: backgrounds.dark,
        child: new Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TopBar(),
              Expanded(
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text(
                          location + ' ' + dateTime,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                    ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        Container(
                          height: 240.0,
                          width: 120.0,
                          child: Image.file(File(imagelocation), width: 128, height: 128),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),  ///Todo use sizeconfig to make responsive
                          width: 48.0,
                          height: 48.0,
                          child:   AutoSizeText(
                            title,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),  ///Todo use sizeconfig to make responsive
                          width: 48.0,
                          height: 180.0,
                          child: Expanded(
                            child: AutoSizeText(
                              text,
                              maxLines: 8,
                              overflow: TextOverflow.clip,
                              style: TextStyle(color: Colors.white,  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// Allows you to get a list of all the ItemTags
_getAllItem() {
  List<Item> lst = _tagStateKey.currentState?.getAllItem;
  if (lst != null)
    lst.where((a) => a.active == true).forEach((a) => print(a.title));
}
