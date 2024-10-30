import 'package:brasil_fields/brasil_fields.dart';
import 'package:church_control/src/core/auth/models/user_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/models/group_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/controllers/lesson_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/lesson/models/lesson_model.dart';
import 'package:church_control/src/shared/utils/filter_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/config/theme_helper.dart';

class BodyLessonForm extends StatefulWidget {
  final LessonModel? lesson;
  const BodyLessonForm({super.key, this.lesson});

  @override
  State<BodyLessonForm> createState() => _BodyLessonFormState();
}

class _BodyLessonFormState
    extends ModularState<BodyLessonForm, LessonController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  // ignore: non_constant_identifier_names
  final double SIZE_BOX = 100.0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (widget.lesson != null) {
      controller.lesson = widget.lesson!;
      dateinput.text = DateFormat('dd/MM/yyyy').format(widget.lesson!.date!);
      await controller.getSecretaries();
      await controller.getTeachers();
    } else {
      controller.lesson = LessonModel();
      controller.lesson.group = GroupModel();
      controller.lesson.secretary = UserModel();
      controller.lesson.teacher = UserModel();
      controller.lesson.attendance = [];
    }
    await controller.getGroups(FilterOptions(page: 1, sort: "asc"));
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.lesson.sId == null) {
        await controller.createLesson();
      } else {
        await controller.updateLesson(false);
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
                            'Nome', 'Insira o nome da lição'),
                        onSaved: (value) {
                          controller.model.name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true, casasDecimais: 2)
                        ],
                        keyboardType: TextInputType.number,
                        initialValue: controller.model.offerValue != null
                            ? NumberFormat.currency(
                                    locale: 'pt_BR', symbol: 'R\$')
                                .format(controller.lesson.offerValue ?? 0.0)
                            : "",
                        decoration: ThemeHelper().textInputDecoration(
                            'Oferta', 'Insira o valor da oferta'),
                        onSaved: (value) {
                          if (value!.isEmpty) {
                            controller.model.offerValue = 0.0;
                          } else {
                            final offerValue = value
                                .replaceAll(RegExp(r'[^\d,]'), '')
                                .replaceAll(',', '.');
                            controller.model.offerValue =
                                double.tryParse(offerValue);
                          }
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
                            'Descrição', 'Insira a descrição da lição'),
                        onSaved: (value) {
                          controller.model.description = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Data é obrigatório';
                          }
                          return null;
                        },
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: ThemeHelper()
                            .textInputDecoration('Data', 'Insira uma data'),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              initialDate:
                                  controller.model.date ?? DateTime.now());
                          if (pickedDate != null) {
                            setState(() {
                              dateinput.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                        onSaved: (value) {
                          controller.model.date =
                              DateFormat('dd/MM/yyyy').parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: DropdownButtonFormField(
                          value: controller.model.group?.sId,
                          items: controller.groups
                              .map((e) => DropdownMenuItem(
                                  value: e.sId, child: Text(e.name!)))
                              .toList(),
                          onChanged: (val) async {
                            controller.model.group!.sId = val as String;
                            await controller.getTeachers();
                            await controller.getSecretaries();
                          },
                          onSaved: (val) {
                            controller.model.group!.sId = val as String;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Sala', 'Escolha uma sala'),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: DropdownButtonFormField(
                          value: controller.model.teacher?.sId,
                          items: controller.teachers
                              .map((e) => DropdownMenuItem(
                                  value: e.sId, child: Text(e.name!)))
                              .toList(),
                          onChanged: (val) {
                            controller.model.teacher!.sId = val as String;
                          },
                          onSaved: (val) {
                            controller.model.teacher!.sId = val as String;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Professor', 'Escolha um professor'),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: DropdownButtonFormField(
                          value: controller.model.secretary?.sId,
                          items: controller.secretaries
                              .map((e) => DropdownMenuItem(
                                  value: e.sId, child: Text(e.name!)))
                              .toList(),
                          onChanged: (val) {
                            controller.model.secretary!.sId = val as String;
                          },
                          onSaved: (val) {
                            controller.model.secretary!.sId = val as String;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Secretário', 'Escolha um secretário'),
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
