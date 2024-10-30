import 'package:brasil_fields/brasil_fields.dart';
import 'package:church_control/src/core/config/app_constants.dart';
import 'package:church_control/src/core/config/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../controllers/member_controller.dart';
import '../models/member_model.dart';

class BodyMemberForm extends StatefulWidget {
  final MemberModel? member;
  const BodyMemberForm({Key? key, this.member}) : super(key: key);

  @override
  State<BodyMemberForm> createState() => _BodyMemberFormState();
}

class _BodyMemberFormState
    extends ModularState<BodyMemberForm, MemberController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      controller.member = widget.member!;
      dateinput.text =
          DateFormat('dd/MM/yyyy').format(widget.member!.birthday!);
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.member.sId == null) {
        await controller.createMember();
      } else {
        await controller.updateMember();
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
              child: Column(children: [
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.member.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Nome', 'Insira o nome do membro'),
                    onSaved: (value) {
                      controller.member.name = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    child: DropdownButtonFormField(
                      value: controller.member.genre,
                      items: AppConstants.GENRE_LIST
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        controller.member.genre = val as String;
                      },
                      validator: (val) {
                        if ((val == null)) {
                          return "Escolha uma opcão";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        controller.member.genre = val as String;
                      },
                      decoration: ThemeHelper()
                          .textInputDecoration('Sexo', 'Escolha seu sexo'),
                    )),
                const SizedBox(height: 30.0),
                Container(
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    child: DropdownButtonFormField(
                      value: controller.member.job,
                      items: AppConstants.JOB_LIST
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {},
                      onSaved: (val) {
                        controller.member.job = val as String;
                      },
                      decoration: ThemeHelper()
                          .textInputDecoration('Cargo', 'Escolha um cargo'),
                    )),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.member.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Telefone é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Telefone', 'Insira um telefone'),
                    onSaved: (value) {
                      controller.member.phone = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.member.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-mail é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('E-mail', 'Insira um e-mail'),
                    onSaved: (value) {
                      controller.member.email = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.member.address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Endereço é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Endereço', 'Insira um endereço'),
                    onSaved: (value) {
                      controller.member.address = value;
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
                    decoration: ThemeHelper().textInputDecoration(
                        'Data de nascimento', 'Insira uma data'),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                          initialDate:
                              controller.member.birthday ?? DateTime.now());
                      if (pickedDate != null) {
                        setState(() {
                          dateinput.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        });
                      }
                    },
                    onSaved: (value) {
                      controller.member.birthday =
                          DateFormat('dd/MM/yyyy').parse(value!);
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context: context),
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
