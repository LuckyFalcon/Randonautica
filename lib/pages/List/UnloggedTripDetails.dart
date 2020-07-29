import 'dart:convert';
import 'dart:io';

import 'package:app/api/logMyTrip.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/Trips/SubmitReportButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/components/FadingCircleLoading.dart';
import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/storage/loggedTripsDatabase.dart';
import 'file:///C:/Users/David/AndroidStudioProjects/Randonautica/lib/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UnloggedTripDetails extends StatefulWidget {
  Function callback;
  int id;
  String location;
  String datetime;

  UnloggedTripDetails(
    this.callback,
    this.id,
    this.location,
    this.datetime,
  );

  @override
  State<UnloggedTripDetails> createState() => UnloggedTripDetailsState();
}

class UnloggedTripDetailsState extends State<UnloggedTripDetails> {
  UnloggedTrip unloggedTrip;

  int id;

  String location;
  String datetime;

  bool labButtonPress = false;
  bool unloggedTriploaded = false;

  //Tags
  List _items = [];
  double _fontSize = 14;

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _horizontalScroll = false;
  int _column = 0;

  List _icon = [Icons.home, Icons.language, Icons.headset];

  var _tag = TextEditingController();
  var _text = TextEditingController();
  var _title = TextEditingController();
  bool _validateTitle = false;
  bool _TitleFocused = false;
  bool _validateText = false;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    Future<List<UnloggedTrip>> _futureOfList =
        RetrieveCurrentUnloggedTrip(this.widget.id);
    _futureOfList.then((value) {
      unloggedTrip = value[0];
      id = this.widget.id;
      location = this.widget.location;
      datetime = this.widget.datetime;
      setState(() {
        unloggedTriploaded = true;
      });
    });
  }

  void callback(bool labButtonPress) {
    submiteReport();
    logMyTrip(unloggedTrip, _title.text, _text.text);
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
    if(_image != null){
      // copy the file to a new path
      newImage = await _image.copy('$path/$id.png');
    }
    print('sucess'+newImage.toString());

    var tagsLength = _items.length;

    final fido = LoggedTrip(
      is_visited: 1,
      is_logged: 1,
      is_favorite: 0,
      rng_type: 0,
      point_type: 0,
      title: _title.text.toString(),
      report: _text.text.toString(),
      what_3_words_address: null,
      what_3_nearest_place: null,
      what_3_words_country: null,
      center: unloggedTrip.center,
      latitude: unloggedTrip.latitude,
      longitude:  unloggedTrip.longitude,
      location: unloggedTrip.location,
      gid: 3333.toString(),
      tid:  unloggedTrip.tid,
      lid:  unloggedTrip.lid,
      type:  unloggedTrip.type,
      x:  unloggedTrip.x,
      y:  unloggedTrip.y,
      distance:  unloggedTrip.distance,
      initial_bearing:  unloggedTrip.initial_bearing,
      final_bearing:  unloggedTrip.final_bearing,
      side:  unloggedTrip.side,
      distance_err:  unloggedTrip.distance_err,
      radiusM:  unloggedTrip.radiusM,
      number_points:  unloggedTrip.number_points,
      mean: unloggedTrip.mean,
      rarity:  unloggedTrip.rarity,
      power_old:  unloggedTrip.power_old,
      power:  unloggedTrip.power,
      z_score:  unloggedTrip.z_score,
      probability_single:  unloggedTrip.probability_single,
      integral_score:  unloggedTrip.integral_score,
      significance:  unloggedTrip.significance,
      probability:  unloggedTrip.probability,
      created: DateTime.now().toIso8601String(),
      imagelocation: newImage.path.toString(),
      tag1: (tagsLength > 1 ? _items[0] : null),
      tag2: (tagsLength > 2 ? _items[1] : null),
      tag3: (tagsLength > 3 ? _items[2] : null),
      tag4: (tagsLength > 4 ? _items[3] : null),
      tag5: (tagsLength > 5 ? _items[4] : null),
      tag6: (tagsLength > 6 ? _items[5] : null),
      tag7: (tagsLength > 7 ? _items[6] : null),
      tag8: (tagsLength > 8 ? _items[7] : null),
      tag9: (tagsLength > 9 ? _items[8] : null),
      tag10: (tagsLength > 10 ? _items[9] : null),
      tag11: (tagsLength > 11 ? _items[10] : null),
      tag12: (tagsLength > 12 ? _items[11] : null),
      tag13: (tagsLength > 13 ? _items[12] : null),
      tag14: (tagsLength > 14 ? _items[13] : null),
      tag15: (tagsLength > 15 ? _items[14] : null),
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
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0, 100],
                  colors: [Color(0xff5A87E4), Color(0xff37CDDC)])),
          child: (unloggedTriploaded
              ? Center(
                  child: Column(
                    children: <Widget>[
                      TopBar(),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          Text(
                            location + ' ' + datetime,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      _image == null
                          ? FloatingActionButton(
                              onPressed: getImage,
                              tooltip: 'Pick Image',
                              child: Icon(Icons.add_a_photo),
                            )
                          : Image.file(_image, width: 128, height: 128),
                      SizedBox(height: 20),
                      Container(
                          height: 60,
                          padding:
                              EdgeInsets.only(bottom: 25, left: 50, right: 45),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff7BBFFE),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                  controller: _title,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 10, left: 25, right: 45),
                                      border: InputBorder.none,
                                      labelText: AppLocalizations.of(context)
                                          .translate('give_trip_a_name'),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    errorText: _validateTitle ? 'Value Can\'t Be Empty' : null,

                                  )

                              ))),
                      Container(
                          height: 150,
                          padding:
                              EdgeInsets.only(bottom: 10, left: 45, right: 45),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff7BBFFE),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(

                                  controller: _text,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      errorText: _validateText ? 'Value Can\'t Be Empty' : null,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 10, left: 25, right: 45),
                                      border: InputBorder.none,
                                      labelText: AppLocalizations.of(context)
                                          .translate('tell_your_story'),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))))),
                      Container(
                          height: 60,
                          padding:
                              EdgeInsets.only(bottom: 25, left: 50, right: 45),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff7BBFFE),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextFormField(

                                  controller: _tag,
                                  onFieldSubmitted: (String str) {
                                    setState(() {
                                      // required
                                      _items.add(str);
                                      _tag.clear();
                                    });
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () => _tag.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 10, left: 25, right: 45),
                                      border: InputBorder.none,
                                      labelText: AppLocalizations.of(context)
                                          .translate('add_trip_tags'),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))))),
                      Tags(
                        key: _tagStateKey,
                        symmetry: _symmetry,
                        columns: _column,
                        horizontalScroll: _horizontalScroll,
                        heightHorizontalScroll: 60 * (_fontSize / 14),
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
                                utf8.encode(item.substring(0, 1)).length > 2
                                    ? 0.8
                                    : 1,
                            textStyle: TextStyle(
                              fontSize: _fontSize,
                            ),
                            onPressed: (item) => print(item),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      SubmitReportButton(this.callback, labButtonPress)
                    ],
                  ),
                )
              : FadingCircleLoading(
                  color: Colors.white,
                  size: 75.0,
                ))),
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
