import 'package:church_control/src/core/auth/models/user_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/models/group_model.dart';

import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseLessons {
  late List<LessonModel> lessons;
  late PaginationModel pagination;

  ResponseLessons({required this.lessons, required this.pagination});

  ResponseLessons.fromJson(Map<String, dynamic> json) {
    if (json['lessons'] != null) {
      lessons = <LessonModel>[];
      json['lessons'].forEach((v) {
        lessons.add(LessonModel.fromJson(v));
      });
    }
    pagination = PaginationModel.fromJson(json);
  }
}

class LessonModel {
  String? sId;
  String? name;
  String? description;
  GroupModel? group;
  UserModel? teacher;
  UserModel? secretary;
  DateTime? date;
  List<Attendance>? attendance;
  String? createdAt;
  String? updatedAt;
  double? offerValue;

  LessonModel(
      {this.sId,
      this.name,
      this.description,
      this.group,
      this.teacher,
      this.secretary,
      this.attendance,
      this.createdAt,
      this.updatedAt,
      this.date,
      this.offerValue});

  LessonModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    date = json["date"] == null ? null : DateTime.parse(json["date"]);
    group = json['group'] != null ? GroupModel.fromJson(json['group']) : null;
    teacher =
        json['teacher'] != null ? UserModel.fromJson(json['teacher']) : null;
    secretary = json['secretary'] != null
        ? UserModel.fromJson(json['secretary'])
        : null;
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    offerValue = json['offerValue'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null && sId!.isNotEmpty) data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    if (date == null) {
      data["date"] = null;
    } else {
      data["date"] = date?.toIso8601String();
    }
    if (group != null) {
      data['group'] = group!.sId.toString();
    }
    if (teacher != null) {
      data['teacher'] = teacher!.sId..toString();
    }
    if (secretary != null) {
      data['secretary'] = secretary!.sId.toString();
    }
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    data['offerValue'] = offerValue;
    return data;
  }
}

class Attendance {
  String? studentId;
  String? studentName;
  bool? isPresent;
  String? sId;

  Attendance({
    this.studentId,
    this.studentName,
    this.isPresent,
    this.sId,
  });

  Attendance.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    isPresent = json['isPresent'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['isPresent'] = isPresent;
    data['_id'] = sId;
    return data;
  }
}
