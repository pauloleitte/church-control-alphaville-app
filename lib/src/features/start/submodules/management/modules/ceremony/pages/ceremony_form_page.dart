// ignore_for_file: use_build_context_synchronously

import 'package:church_control/src/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';
import '../widgets/body_ceremony_form.dart';

class CeremonyFormPage extends StatefulWidget {
  final CeremonyModel? ceremony;
  const CeremonyFormPage({Key? key, this.ceremony}) : super(key: key);

  @override
  State<CeremonyFormPage> createState() => _CeremonyFormPageState();
}

class _CeremonyFormPageState
    extends ModularState<CeremonyFormPage, CeremonyController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.ceremony?.name}"),
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
                controller.ceremony = widget.ceremony!;
                await controller.deleteCeremony();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.CEREMONY);
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
            'Culto',
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
            onPressed: () => Modular.to.navigate(AppRoutes.CEREMONY),
          ),
          actions: [
            ...(widget.ceremony?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyCeremonyForm(ceremony: widget.ceremony),
    );
  }
}
