import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<int> signBackendGoogle(String token) async {
  String platform;

  if (Platform.isAndroid) {
    platform = "Adndroid";
  } else if (Platform.isIOS) {
    platform = "IOS";
  }

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




