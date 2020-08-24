import 'dart:convert';
import 'dart:io';

import 'package:app/api/logTrip.dart';
import 'package:app/components/Dialogs/DialogButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/Dialogs.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/pages/Randonaut/Trip/TripSuccessfullyReported.dart';
import 'package:app/storage/loggedTripsDatabase.dart';
import 'package:app/storage/unloggedTripsDatabase.dart';
import 'package:app/utils/BackgroundColor.dart' as backgrounds;
import 'package:app/utils/size_config.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FinishTrip extends StatefulWidget {
  Function callback;
  int id;
  String location;
  String datetime;

  FinishTrip(
      this.callback,
      this.id,
      this.location,
      this.datetime,
      );

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

  final picker = ImagePicker();

  UnloggedTrip unloggedTrip;

  int id;

  String location;
  String datetime;

  bool labButtonPress = false;
  bool unloggedTriploaded = false;


  bool _validateTitle = false;
  bool _TitleFocused = false;
  String base64Image;

  File _image;

  @override
  initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _items = _list.toList();

    Future<List<UnloggedTrip>> _futureOfList =
    RetrieveCurrentUnloggedTrip(this.widget.id);
    _futureOfList.then((retrievedUnloggedTrip) {
      unloggedTrip = retrievedUnloggedTrip[0];
      id = this.widget.id;
      location = this.widget.location;
      datetime = this.widget.datetime;
      setState(() {
        unloggedTriploaded = true;
      });
    });

  }

//  finishTripButtonCallback() {
////    Navigator.of(context).pushReplacement(
////      MaterialPageRoute(
////        builder: (context) {
////          return TripReported();
////        },
////      ),
////    );
//  }

  writeTitle(String text) {
    if(text != ''){
      setState(() {
        _title = text;
      });
    }
  }

  finishTripButtonCallback() async {
    await submiteReport();
    await logTrip(unloggedTrip, _title, _text.text, base64Image)
        .then((value) => {
      DeleteUnloggedTrip(id),
      this.widget.callback(),
      Navigator.pop(context)
    })
        .catchError((onError) => {
//    DeleteUnloggedTrip(id),
//        this.widget.callback(),
//    Navigator.pop(context)
    });

//    setState(() {
//      _text.text.isEmpty ? _validateText = true : _validateText = false;
//      _title.text.isEmpty && !_TitleFocused ? _validateTitle = true : _validateTitle = false;
//    });
//
//    if(_text.text.isNotEmpty && _title.text.isNotEmpty){
//      setState(() {
//        this.labButtonPress = labButtonPress;
//        submiteReport();
//        DeleteUnloggedTrip(id);
//        Navigator.pop(context);
//      });
//    }
  }

  Future<void> submiteReport() async {
    // getting a directory path for saving
    print('reached');
    final Directory directory = await getApplicationDocumentsDirectory();
    print('reached');
    final String path = directory.path;
    print('reached');

    var id = new DateTime.now().millisecondsSinceEpoch;
    File newImage;
    if (_image != null) {
      // copy the file to a new path
      newImage = await _image.copy('$path/$id.png');
    }
    print('sucess' + newImage.toString());

    newImage.readAsBytesSync();

    base64Image = base64Encode(newImage.readAsBytesSync());

    final fido = LoggedTrip(
      is_visited: 1,
      is_logged: 1,
      is_favorite: 0,
      rng_type: 0,
      point_type: 0,
      title: _title.toString(),
      report: _text.text.toString(),
      what_3_words_address: null,
      what_3_nearest_place: null,
      what_3_words_country: null,
      center: unloggedTrip.center,
      latitude: unloggedTrip.latitude,
      longitude: unloggedTrip.longitude,
      location: unloggedTrip.location,
      gid: 3333.toString(),
      tid: unloggedTrip.tid,
      lid: unloggedTrip.lid,
      type: unloggedTrip.type,
      x: unloggedTrip.x,
      y: unloggedTrip.y,
      distance: unloggedTrip.distance,
      initial_bearing: unloggedTrip.initial_bearing,
      final_bearing: unloggedTrip.final_bearing,
      side: unloggedTrip.side,
      distance_err: unloggedTrip.distance_err,
      radiusM: unloggedTrip.radiusM,
      number_points: unloggedTrip.number_points,
      mean: unloggedTrip.mean,
      rarity: unloggedTrip.rarity,
      power_old: unloggedTrip.power_old,
      power: unloggedTrip.power,
      z_score: unloggedTrip.z_score,
      probability_single: unloggedTrip.probability_single,
      integral_score: unloggedTrip.integral_score,
      significance: unloggedTrip.significance,
      probability: unloggedTrip.probability,
      created: DateTime.now().toIso8601String(),
      imagelocation: newImage.path.toString(),
    );

    await insertLoggedTrip(fido);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
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
                          GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                            height: SizeConfig.blockSizeVertical * 50,
                            width: SizeConfig.blockSizeHorizontal * 73,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              image:  DecorationImage(
                                  image: (_image == null ? new AssetImage(
                                      'assets/img/Trip/Trip_1.jpg') : new FileImage(_image)),
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
                                                setTitleDialog(
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
                                          DateFormat('yyyy/MM/dd, hh:mm a').format(DateTime.parse(this.widget.datetime)),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ),),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 10,
                                right: SizeConfig.blockSizeHorizontal * 10),
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 25,
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
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
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),

//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: SizeConfig.blockSizeHorizontal * 10,
//                                  right: SizeConfig.blockSizeHorizontal * 10),
//                              child: Container(
//                                  height: SizeConfig.blockSizeVertical * 17,
//                                  width: SizeConfig.blockSizeHorizontal * 90,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Row(
//                                        children: <Widget>[
//                                          MaterialButton(
//                                            height: 25.5,
//                                            color: Color(0xffE0E0E0),
//                                            shape: new RoundedRectangleBorder(
//                                                borderRadius:
//                                                new BorderRadius.circular(
//                                                    60.0)),
//                                            textColor: Colors.white,
//                                            disabledTextColor: Colors.black,
//                                            splashColor: Colors.blueAccent,
//                                            onPressed: () {
//                                              /*...*/
//                                            },
//                                            child: AutoSizeText(
//                                              'ADD TAGS +',
//                                              style: TextStyle(
//                                                  fontSize: 14.0,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      Tags(
//                                        key: _tagStateKey,
//                                        symmetry: _symmetry,
//                                        columns: _column,
//                                        horizontalScroll: _horizontalScroll,
//                                        heightHorizontalScroll:
//                                        60 * (_fontSize / 14),
//                                        itemCount: _items.length,
//                                        itemBuilder: (index) {
//                                          final item = _items[index];
//                                          return ItemTags(
//                                            key: Key(index.toString()),
//                                            index: index,
//                                            title: item,
//                                            pressEnabled: true,
//                                            activeColor: Color(0xff6080E2),
//                                            singleItem: _singleItem,
//                                            splashColor: Colors.green,
//                                            combine:
//                                            ItemTagsCombine.withTextBefore,
//                                            removeButton: _removeButton
//                                                ? ItemTagsRemoveButton(
//                                              onRemoved: () {
//                                                setState(() {
//                                                  _items.removeAt(index);
//                                                });
//                                                return true;
//                                              },
//                                            )
//                                                : null,
//                                            textScaleFactor: utf8
//                                                .encode(item.substring(
//                                                0, 1))
//                                                .length >
//                                                2
//                                                ? 0.8
//                                                : 1,
//                                            textStyle: TextStyle(
//                                              fontSize: _fontSize,
//                                            ),
//                                            onPressed: (item) => print(item),
//                                          );
//                                        },
//                                      ),
//                                    ],
//                                  ))),
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
