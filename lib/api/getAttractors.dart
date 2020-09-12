import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fatumbot/models/Attractors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Attractors> fetchAttractors(int radius, double x, double y, selectedPoint, selectedRandomness, bool checkWater) async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;

  //Get Token
  String token = prefs.getString("authToken");

  try {
    //Get Attractors from API
    final response = await http.get(
        'https://fatumproject-getattractors.azurewebsites.net/getAttractors?radius=' + radius.toString() +
            '&x=' + x.toString() + '&y=' + y.toString() +
            '&selected=$selectedPoint&source=$selectedRandomness&checkwater=$checkWater',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    ).timeout(const Duration(seconds: 60));

    //Successfully got attractors
    if (response.statusCode == 200) {
      return Attractors.fromJson(json.decode(response.body));
    } else {
      //Error from
      throw Exception('Failed to get Attractors');
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
    throw Exception('Failed to get Attractors');
  } on SocketException catch (_) {
    // Other exception
    throw Exception('Failed to get Attractors');
  } catch (error) {
    // Error occurred
    throw Exception('Failed to get Attractors');
  }


}



