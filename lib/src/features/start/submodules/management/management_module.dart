import 'package:flutter_modular/flutter_modular.dart';

import 'modules/ceremony/ceremony_module.dart';
import 'modules/department/department_module.dart';
import 'modules/member/member.module.dart';
import 'modules/notice/notice.module.dart';
import 'modules/prayer/prayer.module.dart';
import 'modules/user/user_module.dart';
import 'modules/visitors/visitor_module.dart';
import 'pages/management_page.dart';

class ManagementModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ManagementPage()),
    ModuleRoute(
      '/ceremony',
      module: CeremonyModule(),
    ),
    ModuleRoute(
      '/visitor',
      module: VisitorModule(),
    ),
    ModuleRoute(
      '/notice',
      module: NoticeModule(),
    ),
    ModuleRoute(
      '/member',
      module: MemberModule(),
    ),
    ModuleRoute(
      '/prayer',
      module: PrayerModule(),
    ),
    ModuleRoute(
      '/department',
      module: DepartmentModule(),
    ),
    ModuleRoute(
      '/user',
      module: UserModule(),
    ),
  ];
}
