import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> visitTrip(String gid) async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");

  print(gid);
  final response = await http.get(
    'http://192.168.1.217:7071/trips/visitTrip?GID=$gid',
    // 'https://randonautica-v2.azure-api.net/trip/saveTrip?GID=$gid',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ).timeout(const Duration(seconds: 60));

  if (response.statusCode == 200) {
    return 200;
  } else {
    throw Exception('Failed to load album');
  }
}



