import 'dart:convert';
import 'dart:io';
import 'package:app/models/Attractors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Attractors> logMyTrip() async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");

  final response = await http.post(
    'http://192.168.1.217:7071/getattractors?',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'UUID': 'placeholder',
      'GID': 'placeholder',
      'location': 'placeholder',
      'datetime': 'placeholder',
      'latitude': 'placeholder',
      'longitude': 'placeholder',
      'radius': 'placeholder',
      'type': 'placeholder',
      'power': 'placeholder',
      'z_score': 'placeholder',
      'favorite': 'placeholder',
      'reportedtime': 'placeholder',
      'title': 'placeholder',
      'text': 'placeholder',
      'imagelocation': 'placeholder',
      'tag1': 'placeholder',
      'tag2': 'placeholder',
      'tag3': 'placeholder',
      'tag4': 'placeholder',
      'tag5': 'placeholder',
      'tag6': 'placeholder',
      'tag7': 'placeholder',
      'tag8': 'placeholder',
      'tag9': 'placeholder',
      'tag10': 'placeholder',
      'tag11': 'placeholder',
      'tag12': 'placeholder',
      'tag13': 'placeholder',
      'tag14': 'placeholder',
      'tag15': 'placeholder'
    }),
  );
  print(response);
  if (response.statusCode == 200) {
    return Attractors.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}



