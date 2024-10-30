import '../../../../../../../shared/utils/pagination_model.dart';

class ResponseFindCreatedAtToday {
  List<VisitorModel>? visitors;
  int? total;

  ResponseFindCreatedAtToday({this.visitors, this.total});

  ResponseFindCreatedAtToday.fromJson(Map<String, dynamic> json) {
    if (json['visitors'] != null) {
      visitors = <VisitorModel>[];
      json['visitors'].forEach((v) {
        visitors!.add(VisitorModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ResponseFindAllVisitors {
  List<VisitorModel>? visitors;
  int? total;

  ResponseFindAllVisitors({this.visitors, this.total});

  ResponseFindAllVisitors.fromJson(Map<String, dynamic> json) {
    if (json['visitors'] != null) {
      visitors = <VisitorModel>[];
      json['visitors'].forEach((v) {
        visitors!.add(VisitorModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ResponseVisitors {
  late List<VisitorModel> visitors;
  late PaginationModel pagination;
  ResponseVisitors({required this.visitors, required this.pagination});

  ResponseVisitors.fromJson(Map<String, dynamic> json) {
    visitors = <VisitorModel>[];
    json['visitors'].forEach((v) {
      visitors.add(VisitorModel.fromJson(v));
    });
    pagination = PaginationModel.fromJson(json);
  }
}

class VisitorModel {
  String? sId;
  String? name;
  String? email;
  String? telephone;
  bool? isChurchgoer;
  String? church;
  String? observations;

  VisitorModel(
      {this.sId,
      this.name,
      this.email,
      this.telephone,
      this.isChurchgoer,
      this.church,
      this.observations});

  VisitorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    isChurchgoer = json['isChurchgoer'];
    church = json['church'];
    observations = json['observations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['telephone'] = telephone;
    data['isChurchgoer'] = isChurchgoer;
    data['church'] = church;
    data['observations'] = observations;
    return data;
  }
}
