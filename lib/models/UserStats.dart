class UserStats {
  int id;
  int anomalies;
  int attractors;
  int voids;
  int chains;
  int distance;
  int loggedtrips;
  int maximumpower;
  int sharewithfriends;
  int maximumstreak;


  UserStats(
      {this.id, this.anomalies,
        this.attractors,
        this.voids,
        this.chains,
        this.distance,
        this.loggedtrips,
        this.maximumpower,
        this.sharewithfriends,
        this.maximumstreak
      });

   // Convert a UnloggedTrip into a Map. The keys must correspond to the names of the
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'anomalies': anomalies,
      'attractors': attractors,
      'voids': voids,
      'chains': chains,
      'distance': distance,
      'loggedtrips': loggedtrips,
      'maximumpower': maximumpower,
      'sharewithfriends': sharewithfriends,
      'maximumstreak': maximumstreak,
    };
  }
}