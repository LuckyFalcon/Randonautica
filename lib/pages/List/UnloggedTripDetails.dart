import 'dart:convert';
import 'dart:io';

import 'package:app/components/TopBar.dart';
import 'package:app/components/Trips/SubmitReportButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/helpers/storage/loggedTripsDatabase.dart';
import 'package:app/helpers/storage/unloggedTripsDatabase.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UnloggedTripDetails extends StatefulWidget {

  int id;
  String gid;
  String location;
  String datetime;
  String latitude;
  String longitude;
  String radius;
  String type;
  String power;
  String zScore;
  String pseudo;
  String report;

  UnloggedTripDetails(
      this.id,
      this.gid,
      this.location,
      this.datetime,
      this.latitude,
      this.longitude,
      this.radius,
      this.type,
      this.power,
      this.zScore,
      this.pseudo,
      this.report);

  @override
  State<UnloggedTripDetails> createState() => UnloggedTripDetailsState();
}

class UnloggedTripDetailsState extends State<UnloggedTripDetails> {
  int id;

  String location;
  String datetime;

  bool labButtonPress = false;

  @override
  void initState() {
    super.initState();
    id = this.widget.id;
    location = this.widget.location;
    datetime = this.widget.datetime;
  }

  void callback(bool labButtonPress) {
    setState(() {
      this.labButtonPress = labButtonPress;
      print(true);
      submiteReport();
      DeleteUnloggedTrip(id);
    });
  }

  Future<void> submiteReport() async {
    // getting a directory path for saving
    final Directory directory = await getApplicationDocumentsDirectory();

    final String path = directory.path;

    var id = new DateTime.now().millisecondsSinceEpoch;

    // copy the file to a new path
    final File newImage = await _image.copy('$path/$id.png');

    var tagsLength = _items.length;

    final fido = LoggedTrip(
      gid: this.widget.location,
      location: this.widget.location,
      datetime: this.widget.location,
      latitude: this.widget.location,
      longitude: this.widget.location,
      radius: this.widget.location,
      type: this.widget.location,
      power: this.widget.location,
      zScore: this.widget.location,
      pseudo: 0.toString(),
      favorite: 1.toString(),
      reportedtime: DateTime.now().toIso8601String(),
      title: _title.text.toString(),
      text: _text.text.toString(),
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
    print('success');
  }

  List _items = [];
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

  var _tag = TextEditingController();
  var _text = TextEditingController();
  var _title = TextEditingController();

  File _image;
  final picker = ImagePicker();

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
        child: Center(
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
                        fontWeight: FontWeight.bold, color: Colors.white),
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
                  padding: EdgeInsets.only(bottom: 25, left: 50, right: 45),
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
                                  fontWeight: FontWeight.bold))))),
              Container(
                  height: 150,
                  padding: EdgeInsets.only(bottom: 10, left: 45, right: 45),
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
                  padding: EdgeInsets.only(bottom: 25, left: 50, right: 45),
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
                        utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
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
