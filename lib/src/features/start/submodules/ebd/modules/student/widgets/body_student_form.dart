import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/config/theme_helper.dart';
import '../../group/models/group_model.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';

class BodyStudentForm extends StatefulWidget {
  final StudentModel? student;
  const BodyStudentForm({Key? key, this.student}) : super(key: key);

  @override
  State<BodyStudentForm> createState() => _BodyStudentFormState();
}

class _BodyStudentFormState
    extends ModularState<BodyStudentForm, StudentController> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final double SIZE_BOX = 100.0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (widget.student != null) {
      controller.student = widget.student!;
    } else {
      controller.student = StudentModel();
      controller.student.group = GroupModel();
    }
    await controller.getGroups();
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.student.sId == null) {
        await controller.createStudent();
      } else {
        await controller.updateStudent();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.student.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                        decoration: ThemeHelper().textInputDecoration(
                            'Nome', 'Insira o nome do aluno'),
                        onSaved: (value) {
                          controller.student.name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.student.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        decoration: ThemeHelper().textInputDecoration(
                            'Telefone', 'Insira um Telefone'),
                        onSaved: (value) {
                          controller.student.phone = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.student.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: ThemeHelper()
                            .textInputDecoration('Email', 'Insira um Email'),
                        onSaved: (value) {
                          controller.student.email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: DropdownButtonFormField(
                          value: controller.student.group?.sId,
                          validator: (value) =>
                              value == null ? 'Escolha uma sala' : null,
                          items: controller.groups
                              .map((e) => DropdownMenuItem(
                                  value: e.sId, child: Text(e.name!)))
                              .toList(),
                          onChanged: (val) {},
                          onSaved: (val) {
                            controller.student.group!.sId = val as String;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Sala', 'Escolha uma sala'),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration:
                          ThemeHelper().buttonBoxDecoration(context: context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(context),
                        onPressed: controller.busy ? null : save,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            "Salvar".toUpperCase(),
                            style: ThemeHelper().buttonTextStyle(context),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ),
      );
    });
  }
}
