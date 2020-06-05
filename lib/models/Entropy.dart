class Entropy {
  int entropySize;
  int timestamp;
  String gid;

  Entropy({this.entropySize, this.timestamp, this.gid});

  Entropy.fromJson(Map<String, dynamic> json) {
    entropySize = json['EntropySize'];
    timestamp = json['Timestamp'];
    gid = json['Gid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntropySize'] = this.entropySize;
    data['Timestamp'] = this.timestamp;
    data['Gid'] = this.gid;
    return data;
  }
}