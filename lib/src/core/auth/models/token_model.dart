class TokenModel {
  String? accessToken;
  String? refreshToken;
  String? expiresAt;

  TokenModel({this.accessToken, this.refreshToken, this.expiresAt});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['expiresAt'] = expiresAt;
    return data;
  }

  Map<String, dynamic> toJsonAccessToken() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    return data;
  }
}
