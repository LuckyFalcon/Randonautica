import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app/models/LoggedTrip.dart';
import 'package:app/models/SyncTrips.dart';
import 'package:app/models/UnloggedTrip.dart';
import 'package:app/storage/loggedTripsDatabase.dart';
import 'package:app/storage/unloggedTripsDatabase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
     // 'http://192.168.1.217:7071/api/syncReports',
      'https://randonautica-v2.azure-api.net/sync/syncReports',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 60)); //60 Second timeout
print(response.statusCode);
    //Successfully got a success from sharing
    if (response.statusCode == 200) {

      SyncTrips syncUnloggedTrips = syncTripsFromJson(response.body);

      print('length: ' + syncUnloggedTrips.trips[0].length.toString());
      if(syncUnloggedTrips.trips[0].length > 0) {
        for (int i = 0; i < syncUnloggedTrips.trips[0].length; i++) {

          var location;

          try {
            await Future.delayed(const Duration(milliseconds: 500), () async {
              location = await Geolocator().placemarkFromCoordinates(
                syncUnloggedTrips.trips[0][i].latitude,
                syncUnloggedTrips.trips[0][i].longitude,

                ///Locale for Local GeoLocator
                //  localeIdentifier: "fi_FI"
              );
            });
            print(location);
          } catch (error) {
            print(error);
            location = '';
          }

          if(syncUnloggedTrips.trips[0][i].isLogged == 1){

            final Directory directory = await getApplicationDocumentsDirectory();
            print('reached');
            final String path = directory.path;
            print('reached');

            File file = File(
                "$path/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");

            for(var x = 0; x < syncUnloggedTrips.images.length; x++ ){
              if(syncUnloggedTrips.trips[0][i].id == syncUnloggedTrips.images[x].tripId){
                Uint8List decoded = base64Decode(syncUnloggedTrips.images[x].image);
                print(decoded);
                await file.writeAsBytes(decoded);
              }
            }

            final fido = LoggedTrip(
              is_visited: syncUnloggedTrips.trips[0][i].isVisited,
              is_logged: syncUnloggedTrips.trips[0][i].isLogged,
              is_favorite: syncUnloggedTrips.trips[0][i].isFavorite,
              rng_type: syncUnloggedTrips.trips[0][i].rngType,
              point_type: syncUnloggedTrips.trips[0][i].pointType,
              title: syncUnloggedTrips.trips[0][i].title,
              report: syncUnloggedTrips.trips[0][i].report,
              what_3_words_address: null,
              what_3_nearest_place: null,
              what_3_words_country: null,
              center: '3333',
              latitude: syncUnloggedTrips.trips[0][i].latitude.toString(),
              longitude: syncUnloggedTrips.trips[0][i].longitude.toString(),
              location:  (location[0].administrativeArea.toString() != ''
                  ? location[0].administrativeArea
                  : location[0].country.toString()),
              gid: syncUnloggedTrips.trips[0][i].newtonlibGid.toString(),
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
              created: syncUnloggedTrips.trips[0][i].created.toIso8601String(),
              imagelocation: file.path.toString(),
            );

            await insertLoggedTrip(fido);

          }
          //Log trips
          final unloggedTrip = UnloggedTrip(
            is_visited: syncUnloggedTrips.trips[0][i].isVisited,
            is_logged: syncUnloggedTrips.trips[0][i].isLogged,
            is_favorite: syncUnloggedTrips.trips[0][i].isFavorite,
            rng_type: syncUnloggedTrips.trips[0][i].rngType,
            point_type: syncUnloggedTrips.trips[0][i].pointType,
            title: null,
            report: 0.toString(),
            what_3_words_address: null,
            what_3_nearest_place: null,
            what_3_words_country: null,
            center: '3333',
            latitude: syncUnloggedTrips.trips[0][i].longitude.toString(),
            longitude: syncUnloggedTrips.trips[0][i].longitude.toString(),
            location: (location[0].administrativeArea.toString() != ''
                ? location[0].administrativeArea
                : location[0].country.toString()),
            gid: syncUnloggedTrips.trips[0][i].newtonlibGid.toString(),
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
            created: (syncUnloggedTrips.trips[0][i].created).toIso8601String(),
          );

          await insertUnloggedTrip(unloggedTrip);

        }
        return 200;
      } else {
        return 200;
      }
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
    return 500;
  } on SocketException catch (_) {
    // Other exception
    return 500;
  }
}
