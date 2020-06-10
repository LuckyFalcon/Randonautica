import 'dart:convert';
import 'package:app/models/Attractors.dart';
import 'package:http/http.dart' as http;

Future<Attractors> fetchAttractors(int radius, double x, double y) async {

  final response = await http.get('http://192.168.1.217:3000/getattractors?radius='+radius.toString() + '&x='+x.toString() + '&y='+y.toString()+'&raw=false');

  if (response.statusCode == 200) {
    return Attractors.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
