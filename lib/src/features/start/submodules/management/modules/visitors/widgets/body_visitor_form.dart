import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/config/theme_helper.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';

class BodyVisitorForm extends StatefulWidget {
  final VisitorModel? visitor;
  const BodyVisitorForm({Key? key, this.visitor}) : super(key: key);

  @override
  State<BodyVisitorForm> createState() => _BodyVisitorFormState();
}

class _BodyVisitorFormState
    extends ModularState<BodyVisitorForm, VisitorController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.visitor != null) {
      controller.visitor = widget.visitor!;
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.visitor.sId == null) {
        await controller.createVisitor();
      } else {
        await controller.updateVisitor();
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
                          initialValue: controller.visitor.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Insira o nome do visitante';
                            }
                            return null;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Nome', 'Insira seu nome'),
                          onSaved: (value) {
                            controller.visitor.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.email,
                          decoration: ThemeHelper().textInputDecoration(
                              'E-mail', 'Insira seu e-mail'),
                          onSaved: (value) {
                            controller.visitor.email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.telephone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          decoration: ThemeHelper().textInputDecoration(
                              'Telefone', 'Insira seu telefone'),
                          onSaved: (value) {
                            controller.visitor.telephone = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.church,
                          decoration: ThemeHelper()
                              .textInputDecoration('Igreja', 'Insira a igreja'),
                          onSaved: (value) {
                            controller.visitor.church = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.observations,
                          minLines:
                              6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: ThemeHelper().textInputDecoration(
                              'Observações', 'Insira alguma observação'),
                          onSaved: (value) {
                            controller.visitor.observations = value;
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
            )
          ],
        ),
      );
    });
  }
}
