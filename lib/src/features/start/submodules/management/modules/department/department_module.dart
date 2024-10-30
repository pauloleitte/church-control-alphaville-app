import 'package:flutter_modular/flutter_modular.dart';

import '../member/repositories/member_repository.dart';
import '../member/services/member_service.dart';
import '../notice/repositories/notice_repository.dart';
import '../notice/services/notice_service.dart';
import 'controllers/department_controller.dart';
import 'pages/department_detail_page.dart';
import 'pages/department_form_page.dart';
import 'pages/department_member_page.dart';
import 'pages/department_notice_page.dart';
import 'pages/department_page.dart';
import 'repositories/department_repository_dart.dart';
import 'services/department_service.dart';

class DepartmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => NoticeRepository(i.get())),
    Bind.factory((i) => NoticeService(i.get())),
    Bind.factory((i) => MemberRepository(i.get())),
    Bind.factory((i) => MemberService(i.get())),
    Bind.lazySingleton((i) => DepartmentRepository(i.get())),
    Bind.lazySingleton((i) => DepartmentService(i.get())),
    Bind.lazySingleton((i) => DepartmentController(i.get(), i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const DepartmentPage(),
    ),
    ChildRoute(
      '/detail',
      child: (_, args) => DepartmentDetailPage(
        department: args.data,
      ),
    ),
    ChildRoute(
      '/member',
      child: (_, args) => DepartmentMemberPage(
        params: args.data,
      ),
    ),
    ChildRoute(
      '/member',
      child: (_, args) => DepartmentNoticePage(
        params: args.data,
      ),
    ),
    ChildRoute('/form',
        child: (_, args) => DepartmentFormPage(
              department: args.data,
            )),
  ];
}
