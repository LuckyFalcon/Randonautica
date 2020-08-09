import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> saveTrip(String gid) async {
  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;
  String token = prefs.getString("authToken");

  final response = await http.get(
    'https://randonautica-v2.azure-api.net/trips/saveTrip?GID=$gid',
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



