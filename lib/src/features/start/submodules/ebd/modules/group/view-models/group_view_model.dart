import '../../../../../../../core/auth/models/user_model.dart';
import '../../lesson/models/lesson_model.dart';
import '../../student/models/student_model.dart';

class GroupViewModel {
  String? sId = "";
  String? name = "";
  String? description = "";
  List<StudentModel>? students = [];
  List<UserModel>? teachers = [];
  List<UserModel>? secretaries = [];
  List<LessonModel>? lessons = [];

  GroupViewModel({
    this.sId,
    this.name,
    this.description,
    this.students,
    this.teachers,
    this.secretaries,
    this.lessons,
  });
}
