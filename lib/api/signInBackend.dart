import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/storage/userDatabase.dart';
import 'package:app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:app/utils/currentUser.dart' as globals;

Future<int> signBackendApple(String token) async {
  //Platform id
  int platform;

  //iOS is 1, Android = 2
  if(Platform.isIOS){
    platform = 1;
  } else {
    platform = 2;
  }

  try {
    final response = await http.get(
      'https://randonautica-v2.azure-api.net/user/signInUser?platform=$platform',
      //  'http://192.168.1.217:7071/api/signInUser?platform=$platform',

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout
    if (response.statusCode == 200 || response.statusCode == 409) {
      User user = User.fromJson(json.decode(response.body));
      if (user != null) {
        try {
          await insertUser(user);
        } catch (err){
          return 500;
        }
        user = await RetrieveUser();
        globals.currentUser = user;
        return response.statusCode;
      }
    }
    return 500; //Return Status Code 500
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500; //Return Status Code 500
  } on SocketException catch (_) {
    // Other exception
    return 500; //Return Status Code 500
  }
}

Future<int> signBackendGoogle(String token) async {
  //Platform id
  int platform;

  //Android = 2, iOS is 1
  if(Platform.isAndroid){
    platform = 2;
  } else {
    platform = 1;
  }

  try {
    final response = await http.get(
      'https://randonautica-v2.azure-api.net/user/signInUser?platform=$platform',
     //'http://192.168.1.217:7071/api/signInUser?platform=$platform',

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout
    if (response.statusCode == 200 || response.statusCode == 409) {
      User user = User.fromJson(json.decode(response.body));
      if (user != null) {
        try {
          await insertUser(user);
        } catch (err){
          return 500;
        }
        user = await RetrieveUser();
        globals.currentUser = user;
        return response.statusCode;
      }
    }
    return 500; //Return Status Code 500
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500; //Return Status Code 500
  } on SocketException catch (_) {
    // Other exception
    return 500; //Return Status Code 500
  }
}
