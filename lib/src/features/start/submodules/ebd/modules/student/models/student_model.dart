import '../../group/models/group_model.dart';

import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseStudents {
  late List<StudentModel> students;
  late PaginationModel pagination;
  ResponseStudents({required this.students, required this.pagination});

  ResponseStudents.fromJson(Map<String, dynamic> json) {
    students = <StudentModel>[];
    json['students'].forEach((v) {
      students.add(StudentModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class StudentModel {
  String? sId;
  String? name;
  String? phone;
  String? email;
  GroupModel? group;
  String? createdAt;
  String? updatedAt;

  StudentModel(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.group,
      this.createdAt,
      this.updatedAt});

  StudentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    group = json['group'] != null ? GroupModel.fromJson(json['group']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null && sId!.isNotEmpty) data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}
