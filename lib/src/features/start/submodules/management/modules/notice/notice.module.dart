import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/notice_controller.dart';
import 'pages/notice_detail_page.dart';
import 'pages/notice_form_page.dart';
import 'pages/notice_page.dart';
import 'repositories/notice_repository.dart';
import 'services/notice_service.dart';

class NoticeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => NoticeRepository(i.get())),
    Bind((i) => NoticeService(i.get())),
    Bind((i) => NoticeController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const NoticePage()),
    ChildRoute('/detail',
        child: (_, args) => NoticeDetailPage(notice: args.data)),
    ChildRoute('/form', child: (_, args) => NoticeFormPage(notice: args.data)),
  ];
}
