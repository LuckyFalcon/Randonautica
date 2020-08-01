class User {
  int id;
  int platform;
  int points;
  int isIapSkipWaterPoints;
  int isIapExtendRadius;
  int isIapLocationSearch;
  int isIapInappGooglePreview;
  int isSharedWithFriends;
  int isAgreementAccepted;
  String startedSignedInStreakDatetime;
  int currentSignedInStreak;


  User(
      {this.id, this.platform,
        this.points,
        this.isIapSkipWaterPoints,
        this.isIapExtendRadius,
        this.isIapLocationSearch,
        this.isIapInappGooglePreview,
        this.isSharedWithFriends,
        this.isAgreementAccepted,
        this.startedSignedInStreakDatetime,
        this.currentSignedInStreak
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    platform = json['platform'];
    points = json['points'];
    isIapSkipWaterPoints = json['is_iap_skip_water_points'];
    isIapExtendRadius = json['is_iap_extend_radius'];
    isIapLocationSearch = json['is_iap_location_search'];
    isIapInappGooglePreview = json['is_iap_inapp_google_preview'];
    isSharedWithFriends = json['is_shared_with_friends'];
    isAgreementAccepted = json['is_agreement_accepted'];
    startedSignedInStreakDatetime = json['started_signedin_streak_datetime'];
    currentSignedInStreak = json['current_signedin_streak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['platform'] = this.platform;
    data['points'] = this.points;
    data['is_iap_skip_water_points'] = this.isIapSkipWaterPoints;
    data['is_iap_extend_radius'] = this.isIapExtendRadius;
    data['is_iap_location_search'] = this.isIapLocationSearch;
    data['is_iap_inapp_google_preview'] = this.isIapInappGooglePreview;
    data['is_shared_with_friends'] = this.isSharedWithFriends;
    data['is_agreement_accepted'] = this.isAgreementAccepted;
    data['started_signedin_streak_datetime'] = this.startedSignedInStreakDatetime;
    data['current_signedin_streak'] = this.currentSignedInStreak;
    return data;
  }


  // Convert a UnloggedTrip into a Map. The keys must correspond to the names of the
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'platform': platform,
      'points': points,
      'isIapSkipWaterPoints': isIapSkipWaterPoints,
      'isIapExtendRadius': isIapExtendRadius,
      'isIapLocationSearch': isIapLocationSearch,
      'isIapInappGooglePreview': isIapInappGooglePreview,
      'isSharedWithFriends': isSharedWithFriends,
      'isAgreementAccepted': isAgreementAccepted,
      'startedSignedInStreakDatetime': startedSignedInStreakDatetime,
      'currentSignedInStreak': currentSignedInStreak,
    };
  }
}