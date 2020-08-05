// To parse this JSON data, do
//
//     final syncTrips = syncTripsFromJson(jsonString);

import 'dart:convert';

SyncTrips syncTripsFromJson(String str) => SyncTrips.fromJson(json.decode(str));

String syncTripsToJson(SyncTrips data) => json.encode(data.toJson());

class SyncTrips {
  SyncTrips({
    this.trips,
    this.images,
  });

  List<List<Trip>> trips;
  List<Image> images;

  factory SyncTrips.fromJson(Map<String, dynamic> json) => SyncTrips(
    trips: json["trips"] == null ? null : List<List<Trip>>.from(json["trips"].map((x) => List<Trip>.from(x.map((x) => Trip.fromJson(x))))),
    images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trips": trips == null ? null : List<dynamic>.from(trips.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    this.tripId,
    this.blobId,
    this.image,
  });

  String tripId;
  String blobId;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    tripId: json["trip_id"] == null ? null : json["trip_id"],
    blobId: json["blob_id"] == null ? null : json["blob_id"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "trip_id": tripId == null ? null : tripId,
    "blob_id": blobId == null ? null : blobId,
    "image": image == null ? null : image,
  };
}

class Trip {
  Trip({
    this.id,
    this.isVisited,
    this.isLogged,
    this.isFavorite,
    this.rngType,
    this.pointType,
    this.title,
    this.report,
    this.what3WordsAddress,
    this.what3WordsNearestPlace,
    this.what3WordsCountry,
    this.center,
    this.latitude,
    this.longitude,
    this.newtonlibGid,
    this.newtonlibTid,
    this.newtonlibLid,
    this.newtonlibType,
    this.newtonlibX,
    this.newtonlibY,
    this.newtonlibDistance,
    this.newtonlibInitialBearing,
    this.newtonlibFinalBearing,
    this.newtonlibSide,
    this.newtonlibDistanceErr,
    this.newtonlibRadiusM,
    this.newtonlibNumberPoints,
    this.newtonlibMean,
    this.newtonlibRarity,
    this.newtonlibPowerOld,
    this.newtonlibPower,
    this.newtonlibZScore,
    this.newtonlibProbabilitySingle,
    this.newtonlibIntegralScore,
    this.newtonlibSignificance,
    this.newtonlibProbability,
    this.created,
    this.updated,
    this.userId,
  });

  String id;
  int isVisited;
  int isLogged;
  int isFavorite;
  int rngType;
  int pointType;
  String title;
  String report;
  String what3WordsAddress;
  String what3WordsNearestPlace;
  String what3WordsCountry;
  dynamic center;
  double latitude;
  double longitude;
  String newtonlibGid;
  String newtonlibTid;
  String newtonlibLid;
  int newtonlibType;
  double newtonlibX;
  double newtonlibY;
  double newtonlibDistance;
  double newtonlibInitialBearing;
  double newtonlibFinalBearing;
  int newtonlibSide;
  double newtonlibDistanceErr;
  double newtonlibRadiusM;
  int newtonlibNumberPoints;
  double newtonlibMean;
  int newtonlibRarity;
  double newtonlibPowerOld;
  double newtonlibPower;
  double newtonlibZScore;
  double newtonlibProbabilitySingle;
  double newtonlibIntegralScore;
  double newtonlibSignificance;
  double newtonlibProbability;
  DateTime created;
  dynamic updated;
  UserId userId;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"] == null ? null : json["id"],
    isVisited: json["is_visited"] == null ? null : json["is_visited"],
    isLogged: json["is_logged"] == null ? null : json["is_logged"],
    isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
    rngType: json["rng_type"] == null ? null : json["rng_type"],
    pointType: json["point_type"] == null ? null : json["point_type"],
    title: json["title"] == null ? null : json["title"],
    report: json["report"] == null ? null : json["report"],
    what3WordsAddress: json["what_3_words_address"] == null ? null : json["what_3_words_address"],
    what3WordsNearestPlace: json["what_3_words_nearest_place"] == null ? null : json["what_3_words_nearest_place"],
    what3WordsCountry: json["what_3_words_country"] == null ? null : json["what_3_words_country"],
    center: json["center"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    newtonlibGid: json["newtonlib_gid"] == null ? null : json["newtonlib_gid"],
    newtonlibTid: json["newtonlib_tid"] == null ? null : json["newtonlib_tid"],
    newtonlibLid: json["newtonlib_lid"] == null ? null : json["newtonlib_lid"],
    newtonlibType: json["newtonlib_type"] == null ? null : json["newtonlib_type"],
    newtonlibX: json["newtonlib_x"] == null ? null : json["newtonlib_x"].toDouble(),
    newtonlibY: json["newtonlib_y"] == null ? null : json["newtonlib_y"].toDouble(),
    newtonlibDistance: json["newtonlib_distance"] == null ? null : json["newtonlib_distance"].toDouble(),
    newtonlibInitialBearing: json["newtonlib_initial_bearing"] == null ? null : json["newtonlib_initial_bearing"].toDouble(),
    newtonlibFinalBearing: json["newtonlib_final_bearing"] == null ? null : json["newtonlib_final_bearing"].toDouble(),
    newtonlibSide: json["newtonlib_side"] == null ? null : json["newtonlib_side"],
    newtonlibDistanceErr: json["newtonlib_distance_err"] == null ? null : json["newtonlib_distance_err"].toDouble(),
    newtonlibRadiusM: json["newtonlib_radiusM"] == null ? null : json["newtonlib_radiusM"].toDouble(),
    newtonlibNumberPoints: json["newtonlib_number_points"] == null ? null : json["newtonlib_number_points"],
    newtonlibMean: json["newtonlib_mean"] == null ? null : json["newtonlib_mean"].toDouble(),
    newtonlibRarity: json["newtonlib_rarity"] == null ? null : json["newtonlib_rarity"],
    newtonlibPowerOld: json["newtonlib_power_old"] == null ? null : json["newtonlib_power_old"].toDouble(),
    newtonlibPower: json["newtonlib_power"] == null ? null : json["newtonlib_power"].toDouble(),
    newtonlibZScore: json["newtonlib_z_score"] == null ? null : json["newtonlib_z_score"].toDouble(),
    newtonlibProbabilitySingle: json["newtonlib_probability_single"] == null ? null : json["newtonlib_probability_single"].toDouble(),
    newtonlibIntegralScore: json["newtonlib_integral_score"] == null ? null : json["newtonlib_integral_score"].toDouble(),
    newtonlibSignificance: json["newtonlib_significance"] == null ? null : json["newtonlib_significance"].toDouble(),
    newtonlibProbability: json["newtonlib_probability"] == null ? null : json["newtonlib_probability"].toDouble(),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"],
    userId: json["user_id"] == null ? null : userIdValues.map[json["user_id"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "is_visited": isVisited == null ? null : isVisited,
    "is_logged": isLogged == null ? null : isLogged,
    "is_favorite": isFavorite == null ? null : isFavorite,
    "rng_type": rngType == null ? null : rngType,
    "point_type": pointType == null ? null : pointType,
    "title": title == null ? null : title,
    "report": report == null ? null : report,
    "what_3_words_address": what3WordsAddress == null ? null : what3WordsAddress,
    "what_3_words_nearest_place": what3WordsNearestPlace == null ? null : what3WordsNearestPlace,
    "what_3_words_country": what3WordsCountry == null ? null : what3WordsCountry,
    "center": center,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "newtonlib_gid": newtonlibGid == null ? null : newtonlibGid,
    "newtonlib_tid": newtonlibTid == null ? null : newtonlibTid,
    "newtonlib_lid": newtonlibLid == null ? null : newtonlibLid,
    "newtonlib_type": newtonlibType == null ? null : newtonlibType,
    "newtonlib_x": newtonlibX == null ? null : newtonlibX,
    "newtonlib_y": newtonlibY == null ? null : newtonlibY,
    "newtonlib_distance": newtonlibDistance == null ? null : newtonlibDistance,
    "newtonlib_initial_bearing": newtonlibInitialBearing == null ? null : newtonlibInitialBearing,
    "newtonlib_final_bearing": newtonlibFinalBearing == null ? null : newtonlibFinalBearing,
    "newtonlib_side": newtonlibSide == null ? null : newtonlibSide,
    "newtonlib_distance_err": newtonlibDistanceErr == null ? null : newtonlibDistanceErr,
    "newtonlib_radiusM": newtonlibRadiusM == null ? null : newtonlibRadiusM,
    "newtonlib_number_points": newtonlibNumberPoints == null ? null : newtonlibNumberPoints,
    "newtonlib_mean": newtonlibMean == null ? null : newtonlibMean,
    "newtonlib_rarity": newtonlibRarity == null ? null : newtonlibRarity,
    "newtonlib_power_old": newtonlibPowerOld == null ? null : newtonlibPowerOld,
    "newtonlib_power": newtonlibPower == null ? null : newtonlibPower,
    "newtonlib_z_score": newtonlibZScore == null ? null : newtonlibZScore,
    "newtonlib_probability_single": newtonlibProbabilitySingle == null ? null : newtonlibProbabilitySingle,
    "newtonlib_integral_score": newtonlibIntegralScore == null ? null : newtonlibIntegralScore,
    "newtonlib_significance": newtonlibSignificance == null ? null : newtonlibSignificance,
    "newtonlib_probability": newtonlibProbability == null ? null : newtonlibProbability,
    "created": created == null ? null : created.toIso8601String(),
    "updated": updated,
    "user_id": userId == null ? null : userIdValues.reverse[userId],
  };
}

enum UserId { C7_C35742_D1_D5_EA11_9_B05_501_AC510_E786 }

final userIdValues = EnumValues({
  "C7C35742-D1D5-EA11-9B05-501AC510E786": UserId.C7_C35742_D1_D5_EA11_9_B05_501_AC510_E786
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
