// ignore_for_file: use_build_context_synchronously

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import '../widgets/body_student_form.dart';

class StudentFormPage extends StatefulWidget {
  final StudentModel? student;
  const StudentFormPage({Key? key, this.student}) : super(key: key);

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState
    extends ModularState<StudentFormPage, StudentController> {
  
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.student?.name}"),
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
                controller.student = widget.student!;
                await controller.deleteStudent();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.STUDENT);
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
            'Aluno',
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
            onPressed: () => Modular.to.navigate(AppRoutes.STUDENT),
          ),
          actions: [
            ...(widget.student?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyStudentForm(student: widget.student),
    );
  }
}
