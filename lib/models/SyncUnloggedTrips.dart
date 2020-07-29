// To parse this JSON data, do
//
//     final syncUnloggedTrips = syncUnloggedTripsFromJson(jsonString);

import 'dart:convert';

List<List<SyncUnloggedTrips>> syncUnloggedTripsFromJson(String str) => List<List<SyncUnloggedTrips>>.from(json.decode(str).map((x) => List<SyncUnloggedTrips>.from(x.map((x) => SyncUnloggedTrips.fromJson(x)))));

String syncUnloggedTripsToJson(List<List<SyncUnloggedTrips>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class SyncUnloggedTrips {
  SyncUnloggedTrips({
    this.id,
    this.userId,
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
  });

  String id;
  String userId;
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
  int newtonlibSignificance;
  double newtonlibProbability;
  dynamic created;
  dynamic updated;

  factory SyncUnloggedTrips.fromJson(Map<String, dynamic> json) => SyncUnloggedTrips(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
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
    newtonlibSignificance: json["newtonlib_significance"] == null ? null : json["newtonlib_significance"],
    newtonlibProbability: json["newtonlib_probability"] == null ? null : json["newtonlib_probability"].toDouble(),
    created: json["created"],
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
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
    "created": created,
    "updated": updated,
  };
}
