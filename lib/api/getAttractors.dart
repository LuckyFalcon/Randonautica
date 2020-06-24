import 'dart:convert';
import 'dart:io';
import 'package:app/models/Attractors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Attractors> fetchAttractors(int radius, double x, double y) async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");
  print('usertoken:');
  print('usertoken: $token');


//  final response = await http.get(
//        'http://192.168.1.217:7071/getattractors?radius='+radius.toString() + '&x='+x.toString() + '&y='+y.toString()+'&raw=false&selected=attractor&entropy=ANU',
//      headers: {
//      'Content-Type': 'application/json',
//      'Accept': 'application/json',
//      'Authorization': 'Bearer $token',
//      },
//  );

  final response = await http.get('https://api2.randonauts.com/v2/getattractors?radius='+radius.toString() + '&x='+x.toString() + '&y='+y.toString()+'&raw=false&selected=attractor&entropy=ANU');

  print(response);
  if (response.statusCode == 200) {
    return Attractors.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}



