import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/lesson_module.dart';
import 'package:church_control/src/features/start/submodules/management/modules/user/user_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'modules/group/group_module.dart';
import 'modules/student/student_module.dart';
import 'pages/ebd_page.dart';

class EbdModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const EbdPage()),
    ModuleRoute(
      '/student',
      module: StudentModule(),
    ),
    ModuleRoute('/group', module: GroupModule()),
    ModuleRoute('/lesson', module: LessonModule()),
    ModuleRoute('/user', module: UserModule()),
    ModuleRoute('/dashboard', module: DashBoardModule())
  ];
}
