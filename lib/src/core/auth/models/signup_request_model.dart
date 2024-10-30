class SignupRequestModel {
  String? email;
  String? password;
  String? name;
  String? phone;
  String? genre;

  SignupRequestModel(
      {this.email, this.password, this.name, this.phone, this.genre});

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone'] = phone;
    data['genre'] = genre;
    return data;
  }
}
