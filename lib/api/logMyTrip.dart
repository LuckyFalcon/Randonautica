import 'dart:convert';
import 'dart:io';
import 'package:app/models/Attractors.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Attractors> logMyTrip(UnloggedTrip unloggedTrip, String title, String report, String base64image) async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");

  print(unloggedTrip.gid);

//  var jsonli = jsonEncode(items.map((e) => e.toJson()).toList());
  print(base64image);

  final response = await http.post(
    'http://192.168.1.217:7071/logmytrip?',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'GID': unloggedTrip.gid,
      'favorite': unloggedTrip.is_favorite.toString(),
      'title': title,
      'report': report,
      'image': base64image,
    }),
  );

  if (response.statusCode == 200) {
    return Attractors.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}



