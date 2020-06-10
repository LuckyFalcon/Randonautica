class LoggedTrip {

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
  String favorite;
  String reportedtime;
  String title;
  String text;
  String imagelocation;
  String tag1;
  String tag2;
  String tag3;
  String tag4;
  String tag5;
  String tag6;
  String tag7;
  String tag8;
  String tag9;
  String tag10;
  String tag11;
  String tag12;
  String tag13;
  String tag14;
  String tag15;

  LoggedTrip({
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
    this.favorite,
    this.reportedtime,
    this.title,
    this.text,
    this.imagelocation,
    this.tag1,
    this.tag2,
    this.tag3,
    this.tag4,
    this.tag5,
    this.tag6,
    this.tag7,
    this.tag8,
    this.tag9,
    this.tag10,
    this.tag11,
    this.tag12,
    this.tag13,
    this.tag14,
    this.tag15,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
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
      'favorite': favorite,
      'reportedtime': reportedtime,
      'title': title,
      'text': text,
      'imagelocation': imagelocation,
      'tag1': tag1,
      'tag2': tag2,
      'tag3': tag3,
      'tag4': tag4,
      'tag5': tag5,
      'tag6': tag6,
      'tag7': tag7,
      'tag8': tag8,
      'tag9': tag9,
      'tag10': tag10,
      'tag11': tag11,
      'tag12': tag12,
      'tag13': tag13,
      'tag14': tag14,
      'tag15': tag15,
    };
  }
}
