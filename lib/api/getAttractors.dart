import 'dart:convert';
import 'package:app/models/Attractors.dart';
import 'package:http/http.dart' as http;

Future<Attractors> fetchAttractors(int radius, double x, double y) async {

  final response = await http.get('https://api2.randonauts.com/v2/getattractors?radius='+radius.toString() + '&x='+x.toString() + '&y='+y.toString()+'&raw=false&selected=attractor&entropy=ANU');
  if (response.statusCode == 200) {
    return Attractors.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
