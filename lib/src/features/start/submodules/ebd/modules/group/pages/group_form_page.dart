import 'package:church_control/src/features/start/submodules/ebd/modules/group/controllers/group_controller.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/models/group_model.dart';
import 'package:church_control/src/features/start/submodules/ebd/modules/group/widgets/body_group_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';

class GroupFormPage extends StatefulWidget {
  final GroupModel? group;
  const GroupFormPage({Key? key, this.group}) : super(key: key);

  @override
  State<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends ModularState<GroupFormPage, GroupController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir a sala ${widget.group?.name}"),
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
                controller.group = widget.group!;
                await controller.deleteGroup();
                Modular.to.navigate(AppRoutes.GROUP);
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
            'Sala',
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
            onPressed: () => Modular.to.navigate(AppRoutes.GROUP),
          ),
          actions: [
            ...(widget.group?.name != null
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onClickDelete,
                    ),
                  ]
                : [])
          ]),
      body: BodyGroupForm(group: widget.group),
    );
  }
}
