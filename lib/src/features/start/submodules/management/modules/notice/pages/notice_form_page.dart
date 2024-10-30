// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';
import '../widgets/body_notice_form.dart';

class NoticeFormPage extends StatefulWidget {
  final NoticeModel? notice;
  const NoticeFormPage({Key? key, this.notice}) : super(key: key);

  @override
  State<NoticeFormPage> createState() => _NoticeFormPageState();
}

class _NoticeFormPageState
    extends ModularState<NoticeFormPage, NoticeController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.notice?.name}"),
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
                controller.notice = widget.notice!;
                await controller.deleteNotice();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.NOTICE);
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
            'Aviso',
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
            onPressed: () => Modular.to.navigate(AppRoutes.NOTICE),
          ),
          actions: [
            ...(widget.notice?.name != null
                ? [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyNoticeForm(notice: widget.notice),
    );
  }
}
