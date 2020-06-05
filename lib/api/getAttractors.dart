import 'dart:convert';

import 'package:app/models/Attractors.dart';
import 'package:http/http.dart' as http;


Future<Attractors> fetchAttractors(int radius, double x, double y) async {
  print(x+y);
  final response = await http.get('http://192.168.1.217:3000/getattractors?radius='+radius.toString() + '&x='+x.toString() + '&y='+y.toString()+'&raw=false');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Attractors.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
