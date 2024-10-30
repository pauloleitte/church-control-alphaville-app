import 'package:brasil_fields/brasil_fields.dart';
import 'package:church_control/src/core/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multiselect/multiselect.dart';
import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/config/theme_helper.dart';
import '../controllers/user_controller.dart';

class BodyUserForm extends StatefulWidget {
  final UserModel? user;
  const BodyUserForm({Key? key, this.user}) : super(key: key);

  @override
  State<BodyUserForm> createState() => _BodyUserFormState();
}

class _BodyUserFormState extends ModularState<BodyUserForm, UserController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.user?.sId != null) {
      controller.model = widget.user!;
    } else {
      controller.model = UserModel();
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.model.sId == null) {
        await controller.createUser();
      } else {
        await controller.updateUser();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Center(
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
                          initialValue: controller.model.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Insira o nome do usuário';
                            }
                            return null;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Nome', 'Insira o nome'),
                          onSaved: (value) {
                            controller.model.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.model.email,
                          decoration: ThemeHelper()
                              .textInputDecoration('E-mail', 'Insira o e-mail'),
                          onSaved: (value) {
                            controller.model.email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.model.phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          decoration: ThemeHelper().textInputDecoration(
                              'Telefone', 'Insira o telefone'),
                          onSaved: (value) {
                            controller.model.phone = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: DropdownButtonFormField(
                            value: controller.model.genre,
                            items: AppConstants.GENRE_LIST
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) {
                              controller.model.genre = val as String;
                            },
                            validator: (val) {
                              if ((val == null)) {
                                return "Escolha uma opcão";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              controller.model.genre = val as String;
                            },
                            decoration: ThemeHelper()
                                .textInputDecoration('Sexo', 'Escolha o sexo'),
                          )),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: DropDownMultiSelect(
                          decoration: ThemeHelper()
                              .dropDownMultiselectDecoration('Permissões'),
                          hintStyle: ThemeHelper().hintTextStyle(),
                          onChanged: (List<dynamic> x) {
                            x = x.map((e) => e.toString()).toList();
                            controller.model.roles = x as List<String>;
                          },
                          options: AppConstants.ROLES,
                          selectedValues: controller.model.roles ?? [],
                        ),
                      ),
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
            )
          ],
        ),
      );
    });
  }
}
