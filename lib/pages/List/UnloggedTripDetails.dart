import 'dart:convert';
import 'dart:io';

import 'package:app/api/logMyTrip.dart';
import 'package:app/components/TopBar.dart';
import 'package:app/components/Trips/SubmitReportButton.dart';
import 'package:app/helpers/AppLocalizations.dart';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../components/FadingCircleLoading.dart';
import '../../storage/loggedTripsDatabase.dart';
import '../../storage/unloggedTripsDatabase.dart';

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

  var _text = TextEditingController();
  var _title = TextEditingController();

  bool _validateTitle = false;
  bool _TitleFocused = false;
  bool _validateText = false;

  String base64Image;

  File _image;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

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

  callback(bool labButtonPress) async {
    await submiteReport();
    await logMyTrip(unloggedTrip, _title.text, _text.text, base64Image)
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
      title: _title.text.toString(),
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
                          : Image.file(_image, width: 256, height: 256),
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
                                    errorText: _validateTitle
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                  )))),
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
                                      errorText: _validateText
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 10, left: 25, right: 45),
                                      border: InputBorder.none,
                                      labelText: AppLocalizations.of(context)
                                          .translate('tell_your_story'),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))))),
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

}