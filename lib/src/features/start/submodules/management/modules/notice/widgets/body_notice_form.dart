import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/theme_helper.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';

class BodyNoticeForm extends StatefulWidget {
  final NoticeModel? notice;
  const BodyNoticeForm({Key? key, this.notice}) : super(key: key);

  @override
  State<BodyNoticeForm> createState() => _BodyNoticeFormState();
}

class _BodyNoticeFormState
    extends ModularState<BodyNoticeForm, NoticeController> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.notice != null) {
      controller.notice = widget.notice!;
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.notice.sId == null) {
        await controller.createNotice();
      } else {
        await controller.updateNotice();
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
                          initialValue: controller.notice.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Nome', 'Insira o nome do aviso'),
                          onSaved: (value) {
                            controller.notice.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          maxLines: 8,
                          initialValue: controller.notice.description,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Descrição é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Descrição', 'Insira uma descrição'),
                          onSaved: (value) {
                            controller.notice.description = value;
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
