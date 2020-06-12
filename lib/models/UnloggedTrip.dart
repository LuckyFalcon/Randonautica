class UnloggedTrip {

  int id;
  String gid;
  String location;
  String datetime;
  String latitude;
  String longitude;
  String radius;
  String type;
  String power;
  String zScore;
  String pseudo;
  String report;


  UnloggedTrip({
    this.id,
    this.gid,
    this.location,
    this.datetime,
    this.latitude,
    this.longitude,
    this.radius,
    this.type,
    this.power,
    this.zScore,
    this.pseudo,
    this.report,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'GID': gid,
      'location': location,
      'datetime': datetime,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'type': type,
      'power': power,
      'z_score': zScore,
      'pseudo': pseudo,
      'report': report,
    };
  }
}
