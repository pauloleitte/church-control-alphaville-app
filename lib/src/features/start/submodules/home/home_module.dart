import 'package:flutter_modular/flutter_modular.dart';

import '../management/modules/ceremony/repositories/ceremony_repository.dart';
import '../management/modules/ceremony/services/ceremony_service.dart';
import '../management/modules/member/repositories/member_repository.dart';
import '../management/modules/member/services/member_service.dart';
import '../management/modules/notice/repositories/notice_repository.dart';
import '../management/modules/notice/services/notice_service.dart';
import 'controllers/home_controller.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => NoticeRepository(i.get())),
    Bind((i) => MemberRepository(i.get())),
    Bind((i) => CeremonyRepository(i.get())),
    Bind((i) => CeremonyService(i.get())),
    Bind((i) => MemberService(i.get())),
    Bind((i) => NoticeService(i.get())),
    Bind((i) => HomeController(i.get(), i.get(), i.get(), i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage())
  ];
}
