import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/configuration/configuration_controller.dart';
import 'controllers/profile/profile_controller.dart';
import 'controllers/security/security_controller.dart';
import 'pages/configuration_page.dart';
import 'pages/profile_page.dart';
import 'pages/security_page.dart';

class ConfigurationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ConfigurationController(i.get(), i.get(), i.get())),
    Bind.factory((i) => SecurityController(i.get())),
    Bind.factory((i) => ProfileController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ConfigurationPage()),
    ChildRoute('/profile',
        child: (_, args) => ProfilePage(
              user: args.data,
            )),
    ChildRoute('/security', child: (_, args) => SecurityPage(user: args.data))
  ];
}
