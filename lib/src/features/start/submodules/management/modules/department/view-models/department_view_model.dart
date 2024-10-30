

import '../../member/models/member_model.dart';
import '../../notice/models/notice_model.dart';

class DepartmentViewModel {
  String? name = "";
  String? description = "";
  String? id = "";
  List<MemberModel>? members = [];
  List<NoticeModel>? notices = [];

  DepartmentViewModel(
      {this.name, this.description, this.id, this.members, this.notices});
}
