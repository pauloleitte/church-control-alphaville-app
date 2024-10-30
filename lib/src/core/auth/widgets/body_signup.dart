import 'package:brasil_fields/brasil_fields.dart';
import 'package:church_control/src/shared/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../shared/widgets/title_widget.dart';
import '../../config/theme_helper.dart';
import '../controllers/signup/signup_controller.dart';

class BodySignup extends StatefulWidget {
  const BodySignup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodySignupState();
  }
}

class _BodySignupState extends ModularState<BodySignup, SignupController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      controller.signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                buildTitle(title: 'Crie sua conta', context: context),
                subTitle(title: 'É fácil e rápido', context: context),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration('Nome', 'Insira seu nome'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Insira seu nome';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.model.name = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail", "Insiira seu email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Insira um endereço de email válido";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.model.email = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Celular", "Insira o número do seu celular"),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                            validator: (val) {
                              if ((val!.isEmpty)) {
                                return "Insira um número de celular válido";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.model.phone = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Senha", "Insira uma senha"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Insira uma senha";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.model.password = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context: context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(context),
                            onPressed: controller.busy ? null : signup,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Cadastrar".toUpperCase(),
                                style: ThemeHelper().buttonTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
