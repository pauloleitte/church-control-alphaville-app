import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/login/login_controller.dart';
import 'controllers/signup/signup_controller.dart';
import 'pages/login_page.dart';
import 'pages/signup.page.dart';
import 'repositories/user_repository.dart';
import 'services/token_service.dart';
import 'services/user_service.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => TokenService()),
    Bind.factory((i) => UserService(i.get(), i.get())),
    Bind.factory((i) => UserRepository(i.get())),
    Bind.factory((i) => LoginController(i.get(), i.get())),
    Bind.factory((i) => SignupController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LoginPage()),
    ChildRoute('/signup', child: (_, args) => const SignupPage()),
  ];
}
