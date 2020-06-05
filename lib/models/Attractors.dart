class Attractors {
  List<Points> points;

  Attractors({this.points});

  Attractors.fromJson(Map<String, dynamic> json) {
    if (json['points'] != null) {
      points = new List<Points>();
      json['points'].forEach((v) {
        points.add(new Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.points != null) {
      data['points'] = this.points.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  int gID;
  int tID;
  int lID;
  int type;
  double x;
  double y;
  Center center;
  int side;
  double distanceErr;
  double radiusM;
  int n;
  double mean;
  int rarity;
  double powerOld;
  double power;
  double zScore;
  double probabilitySingle;
  double integralScore;
 // double significance;
  double probability;

  Points(
      {this.gID,
        this.tID,
        this.lID,
        this.type,
        this.x,
        this.y,
        this.center,
        this.side,
        this.distanceErr,
        this.radiusM,
        this.n,
        this.mean,
        this.rarity,
        this.powerOld,
        this.power,
        this.zScore,
        this.probabilitySingle,
        this.integralScore,
      //  this.significance,
        this.probability});

  Points.fromJson(Map<String, dynamic> json) {
    gID = json['GID'];
    tID = json['TID'];
    lID = json['LID'];
    type = json['Type'];
    x = json['X'];
    y = json['Y'];
    center =
    json['Center'] != null ? new Center.fromJson(json['Center']) : null;
    side = json['Side'];
    distanceErr = json['DistanceErr'];
    radiusM = json['RadiusM'];
    n = json['N'];
    mean = json['Mean'];
    rarity = json['Rarity'];
    powerOld = json['Power_old'];
    power = json['Power'];
    zScore = json['Z_score'];
    probabilitySingle = json['Probability_single'];
    integralScore = json['Integral_score'];
    //significance = json['Significance'];
    probability = json['Probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GID'] = this.gID;
    data['TID'] = this.tID;
    data['LID'] = this.lID;
    data['Type'] = this.type;
    data['X'] = this.x;
    data['Y'] = this.y;
    if (this.center != null) {
      data['Center'] = this.center.toJson();
    }
    data['Side'] = this.side;
    data['DistanceErr'] = this.distanceErr;
    data['RadiusM'] = this.radiusM;
    data['N'] = this.n;
    data['Mean'] = this.mean;
    data['Rarity'] = this.rarity;
    data['Power_old'] = this.powerOld;
    data['Power'] = this.power;
    data['Z_score'] = this.zScore;
    data['Probability_single'] = this.probabilitySingle;
    data['Integral_score'] = this.integralScore;
   // data['Significance'] = this.significance;
    data['Probability'] = this.probability;
    return data;
  }

  //For bublesort
  compareTo(Points point) {
    return 0;
  }
}

class Center {
  Point point;
  Bearing bearing;

  Center({this.point, this.bearing});

  Center.fromJson(Map<String, dynamic> json) {
    point = json['Point'] != null ? new Point.fromJson(json['Point']) : null;
    bearing =
    json['Bearing'] != null ? new Bearing.fromJson(json['Bearing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.point != null) {
      data['Point'] = this.point.toJson();
    }
    if (this.bearing != null) {
      data['Bearing'] = this.bearing.toJson();
    }
    return data;
  }
}

class Point {
  double latitude;
  double longitude;

  Point({this.latitude, this.longitude});

  Point.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}

class Bearing {
  double distance;
  double initialBearing;
  double finalBearing;

  Bearing({this.distance, this.initialBearing, this.finalBearing});

  Bearing.fromJson(Map<String, dynamic> json) {
    distance = json['Distance'];
    initialBearing = json['InitialBearing'];
    finalBearing = json['FinalBearing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Distance'] = this.distance;
    data['InitialBearing'] = this.initialBearing;
    data['FinalBearing'] = this.finalBearing;
    return data;
  }
}