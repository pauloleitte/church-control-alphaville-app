import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../shared/utils/pagination_model.dart';
import '../../lesson/models/lesson_model.dart';
import '../../student/models/student_model.dart';

class ResponseGroups {
  late List<GroupModel> groups;
  late PaginationModel pagination;

  ResponseGroups({required this.groups, required this.pagination});

  ResponseGroups.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <GroupModel>[];
      json['groups'].forEach((v) {
        groups.add(GroupModel.fromJson(v));
      });
    }
    pagination = PaginationModel.fromJson(json);
  }
}

class GroupModel {
  String? sId;
  String? name;
  String? description;
  List<StudentModel>? students;
  List<UserModel>? teachers;
  List<UserModel>? secretaries;
  List<LessonModel>? lessons;
  String? createdAt;
  String? updatedAt;

  GroupModel(
      {this.sId,
      this.name,
      this.description,
      this.students,
      this.teachers,
      this.secretaries,
      this.lessons,
      this.createdAt,
      this.updatedAt});

  GroupModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    if (json['students'] != null) {
      students = <StudentModel>[];
      json['students'].forEach((v) {
        students!.add(StudentModel.fromJson(v));
      });
    }
    if (json['teachers'] != null) {
      teachers = <UserModel>[];
      json['teachers'].forEach((v) {
        teachers!.add(UserModel.fromJson(v));
      });
    }
    if (json['secretaries'] != null) {
      secretaries = <UserModel>[];
      json['secretaries'].forEach((v) {
        secretaries!.add(UserModel.fromJson(v));
      });
    }
    if (json['lessons'] != null) {
      lessons = <LessonModel>[];
      json['lessons'].forEach((v) {
        lessons!.add(LessonModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    if (teachers != null) {
      data['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    if (secretaries != null) {
      data['secretaries'] = secretaries!.map((v) => v.toJson()).toList();
    }
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
