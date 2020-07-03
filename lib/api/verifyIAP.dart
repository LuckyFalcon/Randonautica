import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/helpers/storage/userDatabase.dart';
import 'package:app/models/User.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:http/http.dart' as http;
import 'package:app/utils/currentUser.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> verifyIAPApple(String token) async {
  //Apple platform id
  int platform = 1;

  try {
    final response = await http.get(
      'https://api2.randonauts.com/auth/createuser?platform=$platform',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout
    return response.statusCode;
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500;
  } on SocketException catch (_) {
    // Other exception
    return 500;
  }
}

Future<int> verifyIAPConsumableGoogle(PurchasedItem productItem) async {
  //Google platform id
  int platform = 2;

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");
  print('usertoken:');
  print('usertokeniap: $token');
  final response = await http.post(
    'http://192.168.1.217:7071/api/IAPurchases?platform=2',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
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
  return response.statusCode;
  //
//  try {
//    final response = await http.post(
//      'http://192.168.1.217:7071/api/IAPurchases?platform=$platform',
//      headers: {
//        'Content-Type': 'application/json',
//        'Accept': 'application/json',
//        'Authorization': 'Bearer $token',
//      },
//      body: jsonEncode(<String, String>{
//        'packageName': 'com.randonautica.app',
//        'productId': productItem.productId.toString(),
//        'purchaseToken': productItem.purchaseToken.toString(),
//        'subscription': "false",
//      }),
//    ); //60 Second timeout
//    print('productId'+ productItem.productId);
//
//    print('purchaseToken'+ productItem.purchaseToken);
//    print('testresponse'+response.toString());
//
//
//    if (response.statusCode == 200 || response.statusCode == 409) {
//      print('test'+response.toString());
////      User user = User.fromJson(json.decode(response.body));
////      if (user != null) {
////        await insertUser(user);
////        user = await RetrieveUser();
////        print('respect'+user.points.toString());
////        globals.currentUser = user;
////        print('respectresec'+globals.currentUser.points.toString());
//        return response.statusCode;
//     // }
//    }
//
//  } catch(error) {
//    print('error'+error);
//  }

}
