import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/dashboard_daily_report.dart';
import 'pages/dashboard_lighthouse_report.dart';
import 'pages/dashboard_page.dart';
import 'services/dashboard_service.dart';

class DashBoardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => DashboardController(i.get())),
    Bind.factory((i) => DashBoardService(i.get())),
    Bind.factory((i) => DashBoardRepository(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const DashBoardPage()),
    ChildRoute('/lighthouse-report',
        child: (_, args) => const DashBoardLightHouseReport()),
    ChildRoute('/daily-report', child: (_, args) => const DashBoardDailyReport()),
  ];
}
