import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/prayer_controller.dart';
import 'pages/prayer_detail_page.dart';
import 'pages/prayer_form_page.dart';
import 'pages/prayer_page.dart';
import 'repositories/prayer_repository.dart';
import 'services/prayer_service.dart';

class PrayerModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PrayerRepository(i.get())),
    Bind((i) => PrayerService(i.get())),
    Bind((i) => PrayerController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PrayerPage()),
    ChildRoute('/detail',
        child: (_, args) => PrayerDetailPage(prayer: args.data)),
    ChildRoute('/form', child: (_, args) => PrayerFormPage(prayer: args.data)),
  ];
}
