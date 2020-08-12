import 'dart:convert';

import 'package:app/components/Dialogs/DialogButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/pages/Randonaut/Trip/TripSuccessfullyReported.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class FinishTrip extends StatefulWidget {
  FinishTrip({Key key}) : super(key: key);

  @override
  State<FinishTrip> createState() => FinishTripState();
}

class FinishTripState extends State<FinishTrip>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  String _title;
  var _text = TextEditingController();
  String date;
  bool _validateText = false;

  final List<String> _list = [
    '0',
    'SDK',
    'SDK',
    'SDK',
    'SDK',
    'SDK',
    'SDK',

  ];

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;
  double _fontSize = 14;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];

  List _items;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _items = _list.toList();
  }

  finishTripButtonCallback() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return TripReported();
        },
      ),
    );
  }

  writeTitle(String text) {
    setState(() {
      _title = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: backgrounds.normal,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: SizeConfig.blockSizeVertical * 90,
            width: SizeConfig.blockSizeHorizontal * 80,
            child: Stack(
              children: <Widget>[
                Container(
                    height: SizeConfig.blockSizeVertical * 90,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            offset: Offset(0, 15),
                            color: Colors.black.withOpacity(.6),
                            spreadRadius: -9)
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Container(
                            height: SizeConfig.blockSizeVertical * 50,
                            width: SizeConfig.blockSizeHorizontal * 73,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: new AssetImage(
                                      'assets/img/Trip/Trip_1.jpg'),
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.srcOver),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    offset: Offset(0, 15),
                                    color: Colors.black.withOpacity(.6),
                                    spreadRadius: -9)
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            SizeConfig.blockSizeVertical * 5,
                                        left: SizeConfig.blockSizeHorizontal *
                                            10),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    50,
                                                child: AutoSizeText(
                                                  (_title != null
                                                      ? _title
                                                      : 'Add a Title'),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                            IconButton(
                                              icon: Icon(Icons.create),
                                              tooltip: 'Increase volume by 10',
                                              color: Colors.white,
                                              onPressed: () {
                                                setRadiusDialog(
                                                    context, writeTitle);
                                              },
                                            ),
                                          ],
                                        ))),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 10,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      bottom:
                                          SizeConfig.blockSizeVertical * 2.5,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: AutoSizeText(
                                        'August 20, 2020 1:10pm',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 10,
                                right: SizeConfig.blockSizeHorizontal * 10),
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 10,
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextField(
                                        controller: _text,
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        decoration: InputDecoration(
                                            errorText: _validateText
                                                ? 'Value Can\'t Be Empty'
                                                : null,
                                            border: InputBorder.none,
                                            labelText: AppLocalizations.of(
                                                    context)
                                                .translate('tell_your_story'),
                                            labelStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.bold))))),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 10,
                                  right: SizeConfig.blockSizeHorizontal * 10),
                              child: Container(
                                  height: SizeConfig.blockSizeVertical * 17,
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          MaterialButton(
                                            height: 25.5,
                                            color: Color(0xffE0E0E0),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                new BorderRadius.circular(
                                                    60.0)),
                                            textColor: Colors.white,
                                            disabledTextColor: Colors.black,
                                            splashColor: Colors.blueAccent,
                                            onPressed: () {
                                              /*...*/
                                            },
                                            child: AutoSizeText(
                                              'ADD TAGS +',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Tags(
                                        key: _tagStateKey,
                                        symmetry: _symmetry,
                                        columns: _column,
                                        horizontalScroll: _horizontalScroll,
                                        heightHorizontalScroll:
                                        60 * (_fontSize / 14),
                                        itemCount: _items.length,
                                        itemBuilder: (index) {
                                          final item = _items[index];
                                          return ItemTags(
                                            key: Key(index.toString()),
                                            index: index,
                                            title: item,
                                            pressEnabled: true,
                                            activeColor: Color(0xff6080E2),
                                            singleItem: _singleItem,
                                            splashColor: Colors.green,
                                            combine:
                                            ItemTagsCombine.withTextBefore,
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
                                            textScaleFactor: utf8
                                                .encode(item.substring(
                                                0, 1))
                                                .length >
                                                2
                                                ? 0.8
                                                : 1,
                                            textStyle: TextStyle(
                                              fontSize: _fontSize,
                                            ),
                                            onPressed: (item) => print(item),
                                          );
                                        },
                                      ),
                                    ],
                                  ))),
                          DialogButton(this.finishTripButtonCallback,
                              'finish_trip_report')
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
