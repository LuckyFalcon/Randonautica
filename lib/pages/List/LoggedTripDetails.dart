import 'dart:convert';
import 'dart:io';

import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

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
    for(int i = 0; i < this.widget.tagList.length; i ++){
      if(this.widget.tagList[i] != null){
        tagList.add(this.widget.tagList[i]);
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [0, 1],
                colors: [Color(0xff6081E3), Color(0xff44CBDB)])),
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
                          child:   Text(
                            title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),  ///Todo use sizeconfig to make responsive
                          width: 48.0,
                          height: 48.0,
                          child: Expanded(
                            child: Text(
                              text,
                              overflow: TextOverflow.clip,
                              style: TextStyle(color: Colors.white),

                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),  ///Todo use sizeconfig to make responsive
                          width: 48.0,
                          height: 48.0,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('trip_tags'),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),  ///Todo use sizeconfig to make responsive
                          width: 48.0,
                          height: 48.0,
                          child: Tags(
                            key: _tagStateKey,
                            symmetry: _symmetry,
                            columns: _column,
                            horizontalScroll: _horizontalScroll,
                            heightHorizontalScroll: 60 * (_fontSize / 14),
                            itemCount: tagList.length,
                            itemBuilder: (index) {
                              final item = tagList[index];
                              return ItemTags(
                                key: Key(index.toString()),
                                index: index,
                                title: item,
                                pressEnabled: true,
                                activeColor: Color(0xff6080E2),
                                singleItem: _singleItem,
                                splashColor: Colors.green,
                                combine: ItemTagsCombine.withTextBefore,
                                icon: (item == '0' || item == '1' || item == '2')
                                    ? ItemTagsIcon(
                                  icon: _icon[int.parse(item)],
                                )
                                    : null,
                                removeButton: _removeButton
                                    ? ItemTagsRemoveButton(
                                  onRemoved: () {
                                    setState(() {
                                      _items.removeAt(index);
                                    });
                                    return true;
                                  },
                                )
                                    : null,
                                textScaleFactor:
                                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
                                textStyle: TextStyle(
                                  fontSize: _fontSize,
                                ),
                                onPressed: (item) => print(item),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 50), ///Todo use sizeconfig to make responsive
                        Container(
                            width: 50, ///Todo use sizeconfig to make responsive
                            height: 60, ///Todo use sizeconfig to make responsive
                            decoration: BoxDecoration(
                                color: Color(0xff5D7FE0),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      offset: Offset(0, 15),
                                      color: Colors.black.withOpacity(.6),
                                      spreadRadius: -9)
                                ]),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.zero,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(width: 6),
                                    Text(
                                        AppLocalizations.of(context)
                                            .translate('submit_report')
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {},
                              color: Color(0xff44C5DB),
                            ))
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
