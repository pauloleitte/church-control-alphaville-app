// ignore_for_file: file_names
import 'package:flutter_modular/flutter_modular.dart';

import 'core/auth/auth_module.dart';
import 'core/auth/repositories/user_repository.dart';
import 'core/auth/services/token_service.dart';
import 'core/auth/services/user_service.dart';
import 'core/auth/stores/token_store.dart';
import 'core/config/app_routes.dart';
import 'features/splash/splash_module.dart';
import 'features/start/start_module.dart';
import 'shared/http/custom_dio.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => createDio()),
    Bind((i) => UserService(i.get(), i.get())),
    Bind((i) => UserRepository(i.get())),
    Bind((i) => TokenService()),
    Bind((i) => TokenStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AppRoutes.AUTH, module: AuthModule()),
    ModuleRoute(AppRoutes.START, module: StartModule()),
    ModuleRoute(AppRoutes.SPLASH, module: SplashModule()),
  ];
}
