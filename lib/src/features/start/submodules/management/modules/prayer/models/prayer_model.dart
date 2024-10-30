import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseFindAllPrayers {
  List<PrayerModel>? prayers;
  int? total;

  ResponseFindAllPrayers({this.prayers, this.total});

  ResponseFindAllPrayers.fromJson(Map<String, dynamic> json) {
    if (json['prayers'] != null) {
      prayers = <PrayerModel>[];
      json['prayers'].forEach((v) {
        prayers!.add(PrayerModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ResponsePrayers {
  late List<PrayerModel> prayers;
  late PaginationModel pagination;
  ResponsePrayers({required this.prayers, required this.pagination});

  ResponsePrayers.fromJson(Map<String, dynamic> json) {
    prayers = <PrayerModel>[];
    json['prayers'].forEach((v) {
      prayers.add(PrayerModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class PrayerModel {
  String? sId;
  String? name;
  String? description;
  DateTime? updatedAt;

  PrayerModel({this.sId, this.name, this.description, this.updatedAt});

  PrayerModel.fromJson(Map<String, dynamic> json) {
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
