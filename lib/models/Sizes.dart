class Sizes {
  String type;
  int n;
  int spot;
  int hexsize;

  Sizes({this.type, this.n, this.spot, this.hexsize});

  Sizes.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    n = json['N'];
    spot = json['spot'];
    hexsize = json['hexsize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['N'] = this.n;
    data['spot'] = this.spot;
    data['hexsize'] = this.hexsize;
    return data;
  }
}