import '../../group/models/group_model.dart';

class StudentViewModel {
  String? id = "";
  String? name = "";
  String? phone = "";
  String? email = "";
  GroupModel? group = GroupModel();

  StudentViewModel(
      {this.id, this.name, this.phone, this.email, this.group});
}
