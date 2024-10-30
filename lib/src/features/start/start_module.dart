import 'package:flutter_modular/flutter_modular.dart';

import '../../core/auth/services/user_service.dart';
import 'pages/start_page.dart';
import 'store/start_store.dart';
import 'submodules/configuration/configuration_module.dart';
import 'submodules/ebd/ebd_module.dart';
import 'submodules/home/home_module.dart';
import 'submodules/management/management_module.dart';

class StartModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => UserService(i.get(), i.get())),
    Bind.singleton((i) => StartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const StartPage(), children: [
      ModuleRoute(
        '/home',
        module: HomeModule(),
      ),
      ModuleRoute('/management', module: ManagementModule()),
      ModuleRoute('/ebd', module: EbdModule()),
      ModuleRoute(
        '/config',
        module: ConfigurationModule(),
      ),
    ]),
  ];
}
