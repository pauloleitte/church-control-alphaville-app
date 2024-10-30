import '../../../../../../../core/auth/models/user_model.dart';
import '../../group/models/group_model.dart';
import '../models/lesson_model.dart';

class LessonViewModel {
  String? sId = "";
  String? name = "";
  String? description = "";
  GroupModel? group = GroupModel();
  UserModel? teacher = UserModel();
  UserModel? secretary = UserModel();
  List<Attendance>? attendance = [];
  double? offerValue = 0;
  DateTime? date = DateTime.now();

  LessonViewModel(
      {this.sId,
      this.name,
      this.description,
      this.group,
      this.teacher,
      this.secretary,
      this.attendance,
      this.date,
      this.offerValue});
}
