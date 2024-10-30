import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/auth/repositories/user_repository.dart';
import '../../../../../../core/auth/services/user_service.dart';
import 'controllers/user_controller.dart';
import 'pages/user_page.dart';
import 'pages/user_page_form.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => UserRepository(i.get())),
    Bind.factory((i) => UserService(i.get(), i.get())),
    Bind.factory((i) => UserController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const UserPage()),
    ChildRoute('/form',
        child: (_, args) => UserFormPage(
              user: args.data,
            ))
  ];
}
