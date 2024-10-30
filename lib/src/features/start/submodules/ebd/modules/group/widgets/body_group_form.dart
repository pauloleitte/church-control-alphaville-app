import 'package:church_control/src/features/start/submodules/ebd/modules/group/controllers/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../../../../core/config/theme_helper.dart';
import '../models/group_model.dart';

class BodyGroupForm extends StatefulWidget {
  final GroupModel? group;
  const BodyGroupForm({Key? key, this.group}) : super(key: key);

  @override
  State<BodyGroupForm> createState() => _BodyGroupFormState();
}

class _BodyGroupFormState extends ModularState<BodyGroupForm, GroupController> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final double SIZE_BOX = 100.0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (widget.group != null) {
      controller.group = widget.group!;
      await controller.getTeachers();
      await controller.getSecretaries();
    } else {
      controller.group = GroupModel();
      controller.group.secretaries = [];
      controller.group.teachers = [];
      controller.group.students = [];
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.group.sId == null) {
        await controller.createGroup();
      } else {
        await controller.updateGroup();
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
                        initialValue: controller.model.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                        decoration: ThemeHelper().textInputDecoration(
                            'Nome', 'Insira o nome da sala de aula'),
                        onSaved: (value) {
                          controller.model.name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        maxLines: 8,
                        initialValue: controller.model.description,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Descrição é obrigatório';
                          }
                          return null;
                        },
                        decoration: ThemeHelper().textInputDecoration(
                            'Descrição', 'Insira a descrição da sala de aula'),
                        onSaved: (value) {
                          controller.model.description = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    controller.group.sId != null
                        ? Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: DropDownMultiSelect(
                              onChanged: (List<String?>? selectedValues) {
                                controller.model.teachers = controller.teachers
                                    .where((teacher) =>
                                        selectedValues!.contains(teacher.name))
                                    .toList();
                              },
                              options: controller.teachers
                                  .map((teacher) => teacher.name)
                                  .toList(),
                              selectedValues: controller.model.teachers!
                                  .map((teacher) => teacher.name)
                                  .toList(),
                              whenEmpty: 'Selecione os professores',
                              decoration: ThemeHelper()
                                  .dropDownMultiselectDecoration('Professores'),
                              hintStyle: ThemeHelper().hintTextStyle(),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30.0),
                    controller.group.sId != null
                        ? Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: DropDownMultiSelect(
                              onChanged: (List<String?>? selectedValues) {
                                controller.model.secretaries = controller
                                    .secretaries
                                    .where((secretary) => selectedValues!
                                        .contains(secretary.name))
                                    .toList();
                              },
                              options: controller.secretaries
                                  .map((secretary) => secretary.name)
                                  .toList(),
                              selectedValues: controller.model.secretaries!
                                  .map((secretary) => secretary.name)
                                  .toList(),
                              decoration: ThemeHelper()
                                  .dropDownMultiselectDecoration('Secretários'),
                              hintStyle: ThemeHelper().hintTextStyle(),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20.0),
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
