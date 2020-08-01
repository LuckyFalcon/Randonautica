import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/models/SyncUnloggedTrips.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/storage/unloggedTripsDatabase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> syncTripReports() async {

  //Set SharedPreferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Await SharedPreferences future object
  final SharedPreferences prefs = await _prefs;

  //Get Token
  String token = prefs.getString("authToken");

  try {
    final response = await http.get(
      'http://192.168.1.217:7071/api/syncReports',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout

    //Successfully got a success from sharing
    if (response.statusCode == 200) {

      final syncUnloggedTrips = syncUnloggedTripsFromJson(response.body);

      if(syncUnloggedTrips.length > 0) {
        for (int i = 0; i < syncUnloggedTrips[0].length; i++) {

          var location;

          try {
            location = await Geolocator().placemarkFromCoordinates(
              syncUnloggedTrips[0][i].latitude,
              syncUnloggedTrips[0][i].longitude,

              ///Locale for Local GeoLocator
              //  localeIdentifier: "fi_FI"
            );
          } catch (error) {
            location = null;
          }

          //Log trips
          final unloggedTrip = UnloggedTrip(
            is_visited: syncUnloggedTrips[0][i].isVisited,
            is_logged: syncUnloggedTrips[0][i].isLogged,
            is_favorite: syncUnloggedTrips[0][i].isFavorite,
            rng_type: syncUnloggedTrips[0][i].rngType,
            point_type: syncUnloggedTrips[0][i].pointType,
            title: null,
            report: 0.toString(),
            what_3_words_address: null,
            what_3_nearest_place: null,
            what_3_words_country: null,
            center: '3333',
            latitude: syncUnloggedTrips[0][i].longitude.toString(),
            longitude: syncUnloggedTrips[0][i].longitude.toString(),
            location: (location != null ? location[0].administrativeArea.toString() : ''),
            gid: '3333',
            tid: '3333',
            lid: '3333',
            type: '3333',
            x: '3333',
            y: '3333',
            distance: '3333',
            initial_bearing: '3333',
            final_bearing: '3333',
            side: '3333',
            distance_err: '3333',
            radiusM: '3333',
            number_points: '3333',
            mean: '3333',
            rarity: '3333',
            power_old: '3333',
            power: '3333',
            z_score: '3333',
            probability_single: '3333',
            integral_score: '3333',
            significance: '3333',
            probability: '3333',
            created: DateTime.parse(syncUnloggedTrips[0][i].created).toIso8601String(),
          );

          await insertUnloggedTrip(unloggedTrip);

        }
      } else {
        return 200;
      }
      return 200;
    } else {
      //Error from API call
      throw Exception('Failed to accept agreement');
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500;
  } on SocketException catch (_) {
    // Other exception
    return 500;
  }
}
