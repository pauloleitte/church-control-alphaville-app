import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/student_model.dart';

class StudentDetailPage extends StatefulWidget {
  final StudentModel? student;
  const StudentDetailPage({super.key, this.student});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final student = widget.student!;
    final group = student.group;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(student.name!), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => {
            Modular.to
                .navigate(AppRoutes.STUDENT_FORM, arguments: widget.student)
          },
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              SizedBox(
                  height: deviceSize.height / 5,
                  child: Column(
                    children: [
                      Text("Sala",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: 16.0),
                      group != null
                          ? Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.class_,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                ),
                              ),
                              title: Text(
                                group.name!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                group.sId!,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          : const Text(
                              "Nenhuma sala vinculado a este aluno"),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
