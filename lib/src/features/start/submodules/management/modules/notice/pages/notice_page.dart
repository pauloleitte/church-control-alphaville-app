import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../widgets/body_notice.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Avisos',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.MANAGEMENT),
        ),
      ),
      body: const BodyNotice(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.NOTICE_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
