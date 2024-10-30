

import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseWeeksAgenda {
  List<NoticeModel>? notices;

  ResponseWeeksAgenda.fromJson(Map<String, dynamic> json) {
    notices = <NoticeModel>[];
    json['notices'].forEach((v) {
      notices!.add(NoticeModel.fromJson(v));
    });
  }
}

class ResponseFindAllNotices {
  List<NoticeModel>? notices;
  int? total;

  ResponseFindAllNotices({this.notices, this.total});

  ResponseFindAllNotices.fromJson(Map<String, dynamic> json) {
    if (json['notices'] != null) {
      notices = <NoticeModel>[];
      json['notices'].forEach((v) {
        notices!.add(NoticeModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ResponseNotices {
  late List<NoticeModel> notices;
  late PaginationModel pagination;
  ResponseNotices({required this.notices, required this.pagination});

  ResponseNotices.fromJson(Map<String, dynamic> json) {
    notices = <NoticeModel>[];
    json['notices'].forEach((v) {
      notices.add(NoticeModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class NoticeModel {
  String? sId;
  String? name;
  String? description;
  DateTime? updatedAt;

  NoticeModel({this.sId, this.name, this.description, this.updatedAt});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    updatedAt = DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
