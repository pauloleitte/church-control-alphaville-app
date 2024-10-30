import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/controllers/lesson_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/pages/lesson_detail_page.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/pages/lesson_form_page.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/pages/lesson_page.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/reposotories/lesson_repository.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/services/lesson_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../group/repositories/group_repository.dart';
import '../group/services/group_service.dart';
import 'pages/lesson_attendance_page.dart';

class LessonModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => GroupRepository(i.get())),
    Bind.factory((i) => GroupService(i.get())),
    Bind.factory((i) => LessonRepository(i.get())),
    Bind.factory((i) => LessonService(i.get())),
    Bind.factory((i) => LessonController(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LessonPage()),
    ChildRoute('/detail',
        child: (_, args) => LessonDetailPage(
              lesson: args.data,
            )),
    ChildRoute('/form',
        child: (_, args) => LessonFormPage(
              lesson: args.data,
            )),
    ChildRoute('/attendance',
        child: (_, args) => LessonAttendancePage(params: args.data)),
  ];
}
