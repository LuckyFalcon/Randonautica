import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/storage/userDatabase.dart';
import 'package:app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:app/utils/currentUser.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> shareWithFriends() async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;

  //Get Token
  String token = prefs.getString("authToken");

  try {
    final response = await http.get(
      'https://192.168.1.217:7071/api/shareWithFriends',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout

    //Successfully got a success from sharing
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      //Error from API call
      throw Exception('Failed to share');
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500;
  } on SocketException catch (_) {
    // Other exception
    return 500;
  }
}
