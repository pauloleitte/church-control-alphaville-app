import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/body_student.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alunos',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Modular.to.navigate(AppRoutes.EBD),
        ),
      ),
      body: const BodyStudent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.STUDENT_FORM);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
