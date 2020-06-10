import 'dart:convert';
import 'dart:io';

import 'package:app/components/SubmitReportButton.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';

class UnloggedTripDetails extends StatefulWidget {

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

  UnloggedTripDetails(this.gid, this.location, this.datetime, this.latitude,
      this.longitude, this.radius, this.type, this.power, this.zScore,
      this.pseudo, this.report);

  @override
  State<UnloggedTripDetails> createState() => UnloggedTripDetailsState();
}

class UnloggedTripDetailsState extends State<UnloggedTripDetails> {
  String location;
  String datetime;

  @override
  void initState() {
    super.initState();
    location = this.widget.location;
    datetime = this.widget.datetime;


  }

  void submiteReport(){

//    //Log trips
//    final fido = LoggedTrip(
//      gid: value.points[0].gID.toString(),
//      location: location[0].administrativeArea.toString(),
//      datetime: DateTime.now().toIso8601String(),
//      latitude: attractorCoordinates.latitude.toString(),
//      longitude: attractorCoordinates.longitude.toString(),
//      radius: value.points[0].radiusM.toString(),
//      type: value.points[0].type.toString(),
//      power: value.points[0].radiusM.toString(),
//      zScore: value.points[0].zScore.toString(),
//      pseudo: 0.toString(),
//      report: 0.toString(),
//    );
//    await insertUnloggedTrip(fido);

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


  var _controller = TextEditingController();
  var _text = TextEditingController();

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
              FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
              GestureDetector(
                onTap: () => getImage,
                child: Image.asset('assets/img/add_media.png'),
              ),
              _image == null
                ? Image(image: AssetImage('assets/img/add_media.png'))
                : Image.file(_image, width: 96, height: 96),
              Container(
                  height: 60,
                  padding: EdgeInsets.only(bottom: 25, left: 50, right: 45),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7BBFFE),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
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
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: null,
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
                          controller: _controller,
                          onFieldSubmitted: (String str) {
                            // Add item to the data source.

                            setState(() {
                              // required
                              _items.add(str);
                              _controller.clear();
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => _controller.clear(),
                                icon: Icon(Icons.clear),
                              ),
                              contentPadding: const EdgeInsets.all(20.0),
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
              SubmitReportButton()
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
