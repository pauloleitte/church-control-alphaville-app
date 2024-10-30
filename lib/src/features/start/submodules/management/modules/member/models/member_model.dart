import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseBirthdayOfMonth {
  List<MemberModel>? members;

  ResponseBirthdayOfMonth({this.members});

  ResponseBirthdayOfMonth.fromJson(List<dynamic> json) {
    members = <MemberModel>[];
    for (var node in json) {
      members!.add(MemberModel.fromJson(node));
    }
  }
}

class ResponseFindAllMembers {
  List<MemberModel>? members;
  int? total;

  ResponseFindAllMembers({this.members, this.total});

  ResponseFindAllMembers.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(MemberModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ResponseMembers {
  late List<MemberModel> members;
  late PaginationModel pagination;
  ResponseMembers({required this.members, required this.pagination});

  ResponseMembers.fromJson(Map<String, dynamic> json) {
    members = <MemberModel>[];
    json['members'].forEach((v) {
      members.add(MemberModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class MemberModel {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? job;
  DateTime? birthday;
  String? genre;

  MemberModel(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.job,
      this.genre,
      this.birthday});

  MemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    job = json['job'];
    genre = json['genre'];
    birthday =
        json["birthday"] == null ? null : DateTime.parse(json["birthday"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['job'] = job;
    data['genre'] = genre;
    if (birthday == null) {
      data["birthday"] = null;
    } else {
      data["birthday"] = birthday?.toIso8601String();
    }
    return data;
  }
}
