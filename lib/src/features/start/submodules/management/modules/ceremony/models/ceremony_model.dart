
import '../../../../../../../shared/utils/pagination_model.dart';
import '../../notice/models/notice_model.dart';
import '../../prayer/models/prayer_model.dart';
import '../../visitors/models/visitor_model.dart';

class ResponseCeremonies {
  late List<CeremonyModel> ceremonies;
  late PaginationModel pagination;
  ResponseCeremonies({required this.ceremonies, required this.pagination});

  ResponseCeremonies.fromJson(Map<String, dynamic> json) {
    ceremonies = <CeremonyModel>[];
    json['ceremonies'].forEach((v) {
      ceremonies.add(CeremonyModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class CeremonyModel {
  String? sId;
  String? name;
  String? description;
  DateTime? date;
  List<VisitorModel>? visitors;
  List<NoticeModel>? notices;
  List<PrayerModel>? prayers;

  CeremonyModel({
    this.sId,
    this.name,
    this.description,
    this.date,
    this.visitors,
    this.notices,
    this.prayers,
  });

  CeremonyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    date = json["date"] == null ? null : DateTime.parse(json["date"]);
    if (json['visitors'] != null && json['visitors'].isNotEmpty) {
      visitors = <VisitorModel>[];
      json['visitors'].forEach((v) {
        visitors!.add(VisitorModel.fromJson(v));
      });
    }
    if (json['notices'] != null && json['notices'].isNotEmpty) {
      notices = <NoticeModel>[];
      json['notices'].forEach((v) {
        notices!.add(NoticeModel.fromJson(v));
      });
    }
    if (json['prayers'] != null && json['prayers'].isNotEmpty) {
      prayers = <PrayerModel>[];
      json['prayers'].forEach((v) {
        prayers!.add(PrayerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    if (date == null) {
      data["date"] = null;
    } else {
      data["date"] = date?.toIso8601String();
    }
    if (visitors != null) {
      data['visitors'] = visitors!.map((v) => v.toJson()).toList();
    }
    if (notices != null) {
      data['notices'] = notices!.map((v) => v.toJson()).toList();
    }
    if (prayers != null) {
      data['prayers'] = prayers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
