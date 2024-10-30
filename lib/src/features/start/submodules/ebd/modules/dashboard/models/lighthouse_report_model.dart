class LightHouseReport {
  String? group;
  bool? hasAnApperanceAlredyBeenMade;

  LightHouseReport({this.group, this.hasAnApperanceAlredyBeenMade});

  LightHouseReport.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    hasAnApperanceAlredyBeenMade = json['hasAnApperanceAlredyBeenMade'];
  }
}
