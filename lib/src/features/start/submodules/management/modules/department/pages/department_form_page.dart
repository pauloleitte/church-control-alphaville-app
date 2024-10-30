// ignore_for_file: use_build_context_synchronously

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/department_controller.dart';
import '../models/department_model.dart';
import '../widgets/body_department_form.dart';

class DepartmentFormPage extends StatefulWidget {
  final DepartmentModel? department;
  const DepartmentFormPage({Key? key, this.department}) : super(key: key);

  @override
  State<DepartmentFormPage> createState() => _DepartmentFormPageState();
}

class _DepartmentFormPageState
    extends ModularState<DepartmentFormPage, DepartmentController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.department?.name}"),
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
                controller.department = widget.department!;
                await controller.deleteDepartment();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.DEPARTMENT);
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
            'Departamento',
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
            onPressed: () => Modular.to.navigate(AppRoutes.CEREMONY),
          ),
          actions: [
            ...(widget.department?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyDepartmentForm(department: widget.department),
    );
  }
}
