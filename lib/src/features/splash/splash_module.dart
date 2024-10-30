import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/splash_controller.dart';
import 'pages/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SplashController(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SplashPage()),
  ];
}
