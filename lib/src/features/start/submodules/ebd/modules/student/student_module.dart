import '../group/services/group_service.dart';
import '../group/repositories/group_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'controllers/student_controller.dart';
import 'pages/student_page.dart';
import 'pages/student_detail_page.dart';
import 'pages/student_form_page.dart';
import 'repositories/student_repository.dart';
import 'services/student_service.dart';

class StudentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => GroupRepository(i.get())),
    Bind.factory((i) => GroupService(i.get())),
    Bind.factory((i) => StudentRepository(i.get())),
    Bind.factory((i) => StudentService(i.get())),
    Bind.factory((i) => StudentController(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const StudentPage(),
    ),
    ChildRoute(
      '/detail',
      child: (_, args) => StudentDetailPage(student: args.data),
    ),
    ChildRoute('/form',
        child: (_, args) => StudentFormPage(
              student: args.data,
            )),
  ];
}
