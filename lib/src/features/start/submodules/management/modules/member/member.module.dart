import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/member_controller.dart';
import 'pages/member_detail_page.dart';
import 'pages/member_form_page.dart';
import 'pages/member_page.dart';
import 'repositories/member_repository.dart';
import 'services/member_service.dart';

class MemberModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => MemberRepository(i.get())),
    Bind.factory((i) => MemberService(i.get())),
    Bind.factory((i) => MemberController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const MemeberPage(),
    ),
    ChildRoute(
      '/detail',
      child: (_, args) => MemberDetailPage(member: args.data),
    ),
    ChildRoute('/form',
        child: (_, args) => MemberFormPage(
              member: args.data,
            )),
  ];
}
