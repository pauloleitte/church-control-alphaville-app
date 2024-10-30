import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../core/config/theme_helper.dart';
import '../controllers/prayer_controller.dart';
import '../models/prayer_model.dart';

class BodyPrayerForm extends StatefulWidget {
  final PrayerModel? prayer;
  const BodyPrayerForm({Key? key, this.prayer}) : super(key: key);

  @override
  State<BodyPrayerForm> createState() => _BodyPrayerFormState();
}

class _BodyPrayerFormState
    extends ModularState<BodyPrayerForm, PrayerController> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.prayer != null) {
      controller.prayer = widget.prayer!;
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.prayer.sId == null) {
        await controller.createPrayer();
      } else {
        await controller.updatePrayer();
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
                          initialValue: controller.prayer.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Nome', 'Insira o nome da oração'),
                          onSaved: (value) {
                            controller.prayer.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          maxLines: 8,
                          initialValue: controller.prayer.description,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Descrição é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Descrição', 'Insira uma descrição'),
                          onSaved: (value) {
                            controller.prayer.description = value;
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
