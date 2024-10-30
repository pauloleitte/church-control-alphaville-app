class DailyReport {
  String? date;
  String? group;
  String? key;
  int? studentsPresent;
  int? studentsAbsent;
  String? offerValue;

  DailyReport(
      {this.date,
      this.group,
      this.key,
      this.studentsPresent,
      this.studentsAbsent,
      this.offerValue});

  DailyReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    group = json['group'];
    key = json['key'];
    studentsPresent = json['studentsPresent'];
    studentsAbsent = json['studentsAbsent'];
    offerValue = json['offerValue'];
  }
}
