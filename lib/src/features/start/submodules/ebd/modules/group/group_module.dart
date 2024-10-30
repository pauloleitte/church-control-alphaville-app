import 'package:church_control/src/core/auth/services/user_service.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/controllers/group_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/pages/group_detail_page.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/pages/group_form_page.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/pages/group_page.dart';

import '../group/services/group_service.dart';
import '../group/repositories/group_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GroupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => UserService(i.get(), i.get())),
    Bind.factory((i) => GroupRepository(i.get())),
    Bind.factory((i) => GroupService(i.get())),
    Bind.factory((i) => GroupController(i.get(), i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const GroupPage(),
    ),
    ChildRoute(
      '/detail',
      child: (_, args) => GroupDetailPage(group: args.data),
    ),
    ChildRoute('/form',
        child: (_, args) => GroupFormPage(
              group: args.data,
            )),
  ];
}
