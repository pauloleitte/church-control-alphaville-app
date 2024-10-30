// ignore_for_file: unnecessary_new, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';
import '../widgets/body_visitor_form.dart';

class VisitorPageForm extends StatefulWidget {
  final VisitorModel? visitor;
  const VisitorPageForm({Key? key, this.visitor}) : super(key: key);

  @override
  State<VisitorPageForm> createState() => _VisitorPageFormState();
}

class _VisitorPageFormState
    extends ModularState<VisitorPageForm, VisitorController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.visitor?.name}"),
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
                controller.visitor = widget.visitor!;
                await controller.deleteVisitor();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.VISITOR);
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
          title: const Text(
            'Visitante',
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.VISITOR),
          ),
          actions: [
            ...(widget.visitor?.name != null
                ? [
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onClickDelete),
                  ]
                : [])
          ]),
      body: BodyVisitorForm(
        visitor: widget.visitor,
      ),
    );
  }
}
