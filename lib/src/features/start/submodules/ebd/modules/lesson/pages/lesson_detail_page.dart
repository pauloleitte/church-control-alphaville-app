import 'package:church_control/src/core/config/app_routes.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/controllers/lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../shared/utils/multiselect-params.dart';
import '../../group/models/group_model.dart';
import '../models/lesson_model.dart';

class LessonDetailPage extends StatefulWidget {
  final LessonModel? lesson;
  const LessonDetailPage({super.key, this.lesson});

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState
    extends ModularState<LessonDetailPage, LessonController> {
  @override
  void initState() {
    if (widget.lesson != null) {
      controller.lesson = widget.lesson!;
    }
    super.initState();
  }

  Widget getCardAttendance() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: _showMultiSelectStudents,
          child: Card(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Realizar Chamada",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget getCardGroup(
      {required String title,
      required String optionalText,
      GroupModel? model,
      required double height,
      required Icon icon}) {
    return SizedBox(
        height: height / 6,
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 8.0),
            model != null
                ? Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: icon,
                      ),
                      title: Text(
                        model.name!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        model.sId!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Text(optionalText),
          ],
        ));
  }

  Widget getCard(String title, String optionalText, UserModel? model,
      double height, Icon icon) {
    return SizedBox(
        height: height / 6,
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 8.0),
            model != null
                ? Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: icon,
                      ),
                      title: Text(
                        model.name!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        model.phone!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Text(optionalText),
          ],
        ));
  }

  void _showMultiSelectStudents() async {
    await controller.getStudents();
    final data = MultiSelectParams<Attendance>(
        initialValue: controller.lesson.attendance ?? [],
        items: controller.students,
        title: "Alunos");
    final results = await Modular.to
        .pushNamed(AppRoutes.LESSON_ATTENDANCE, arguments: data);
    if (results != null) {
      final attendance = results as List<dynamic>;
      controller.lesson.attendance = [];
      for (var student in controller.students) {
        final isStudentPresent = attendance
            .where((element) => element.sId == student.sId)
            .isNotEmpty;
        if (isStudentPresent) {
          controller.lesson.attendance!.add(Attendance(
              studentId: student.sId!,
              studentName: student.name!,
              isPresent: true));
        } else {
          controller.lesson.attendance!.add(Attendance(
              studentId: student.sId!,
              studentName: student.name!,
              isPresent: false));
        }
      }
      await controller.updateLesson(true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson!;
    final secretary = lesson.secretary!;
    final teacher = lesson.teacher!;
    final group = lesson.group!;
    final dateLesson = DateFormat('dd/MM/yyyy').format(lesson.date!);
    final offerValue = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(lesson.offerValue ?? 0.0);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson!.name!), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () =>
              {Modular.to.navigate(AppRoutes.LESSON_FORM, arguments: lesson)},
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(lesson.description!,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text(dateLesson,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16.0),
              Text(offerValue,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24.0),
              getCardGroup(
                  title: "Sala",
                  optionalText: "Nenhuma sala vinculada a esta aula",
                  model: group,
                  height: deviceSize.height,
                  icon: Icon(Icons.class_,
                      color: Theme.of(context).colorScheme.secondary)),
              getCard(
                  "Professor",
                  "Nenhum professor vinculado a esta aula",
                  teacher,
                  deviceSize.height,
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
              getCard(
                  "Secretário",
                  "Nenhum secretário vinculado a esta aula",
                  secretary,
                  deviceSize.height,
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
              const SizedBox(height: 24.0),
              controller.lesson.attendance!.isEmpty
                  ? getCardAttendance()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
