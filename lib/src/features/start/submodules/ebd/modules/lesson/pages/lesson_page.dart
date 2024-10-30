import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/widgets/body_lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lições',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.EBD),
        ),
      ),
      body: const BodyLesson(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.LESSON_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
