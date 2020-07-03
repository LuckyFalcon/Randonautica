class UnloggedTrip {

  int id;
  int is_visited;
  int is_logged;
  int is_favorite;
  int rng_type;
  int point_type;
  String title;
  String report;
  String what_3_words_address;
  String what_3_nearest_place;
  String what_3_words_country;
  String center;
  String latitude;
  String longitude;
  String location;
  String gid;
  String tid;
  String lid;
  String type;
  String x;
  String y;
  String distance;
  String initial_bearing;
  String final_bearing;
  String side;
  String distance_err;
  String radiusM;
  String number_points;
  String mean;
  String rarity;
  String power_old;
  String power;
  String z_score;
  String probability_single;
  String integral_score;
  String significance;
  String probability;
  String created;


  UnloggedTrip({this.id, this.is_visited, this.is_logged, this.is_favorite,
      this.rng_type, this.point_type, this.title, this.report,
      this.what_3_words_address, this.what_3_nearest_place,
      this.what_3_words_country, this.center, this.latitude, this.longitude,
      this.location, this.gid, this.tid, this.lid, this.type, this.x, this.y,
      this.distance, this.initial_bearing, this.final_bearing, this.side,
      this.distance_err, this.radiusM, this.number_points, this.mean,
      this.rarity, this.power_old, this.power, this.z_score,
      this.probability_single, this.integral_score, this.significance,
      this.probability,
      this.created});

  // Convert a UnloggedTrip into a Map. The keys must correspond to the names of the
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'is_visited': is_visited,
      'is_logged': is_logged,
      'is_favorite': is_favorite,
      'rng_type': rng_type,
      'point_type': point_type,
      'title': title,
      'report': report,
      'what_3_words_address': what_3_words_address,
      'what_3_nearest_place': what_3_nearest_place,
      'what_3_words_country': what_3_words_country,
      'center': center,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'gid': gid,
      'tid': tid,
      'lid': lid,
      'type': type,
      'x': x,
      'y': y,
      'distance': distance,
      'initial_bearing': initial_bearing,
      'final_bearing': final_bearing,
      'side': side,
      'distance_err': distance_err,
      'radiusM': radiusM,
      'number_points': number_points,
      'mean': mean,
      'rarity': rarity,
      'power_old': power_old,
      'power': power,
      'z_score': z_score,
      'probability_single': probability_single,
      'integral_score': integral_score,
      'significance': significance,
      'probability': probability,
      'created': created,
    };
  }
}
