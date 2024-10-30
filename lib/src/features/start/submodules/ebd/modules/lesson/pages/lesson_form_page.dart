// ignore_for_file: use_build_context_synchronously

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/controllers/lesson_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/models/lesson_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/widgets/body_lesson_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LessonFormPage extends StatefulWidget {
  final LessonModel? lesson;
  const LessonFormPage({Key? key, this.lesson}) : super(key: key);

  @override
  State<LessonFormPage> createState() => _LessonFormPageState();
}

class _LessonFormPageState
    extends ModularState<LessonFormPage, LessonController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir a lição ${widget.lesson?.name}"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                controller.lesson = widget.lesson!;
                await controller.deleteLesson();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.LESSON);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Lição',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.LESSON),
          ),
          actions: [
            ...(widget.lesson?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyLessonForm(lesson: widget.lesson),
    );
  }
}
