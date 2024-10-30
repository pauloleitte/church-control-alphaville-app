import 'package:church_control/src/shared/utils/pagination_model.dart';

class ResponseUsers {
  late List<UserModel> users;
  late PaginationModel pagination;
  ResponseUsers({required this.users, required this.pagination});

  ResponseUsers.fromJson(Map<String, dynamic> json) {
    users = <UserModel>[];
    json['users'].forEach((v) {
      users.add(UserModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class UserModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? genre;
  String? avatarUrl;
  List<String>? roles = [];
  List<String>? tokens = [];

  UserModel(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.avatarUrl,
      this.genre,
      this.roles,
      this.tokens});

  UserModel.fromJson(Map<String, dynamic> json) {
    json.removeWhere((key, value) => value == null);
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    genre = json['genre'];
    password = json['password'];
    avatarUrl = json['avatarUrl'];
    json['roles'] != null ? roles = json['roles'].cast<String>() : roles = [];
    json['tokens'] != null
        ? tokens = json['tokens'].cast<String>()
        : tokens = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['avatarUrl'] = avatarUrl;
    data['genre'] = genre;
    data['roles'] = roles;
    data['tokens'] = tokens;
    return data;
  }
}
