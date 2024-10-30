// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/config/app_routes.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';
import '../widgets/body_member_form.dart';

class MemberFormPage extends StatefulWidget {
  final MemberModel? member;
  const MemberFormPage({Key? key, this.member}) : super(key: key);

  @override
  State<MemberFormPage> createState() => _MemberFormPageState();
}

class _MemberFormPageState
    extends ModularState<MemberFormPage, MemberController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.member?.name}"),
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
                controller.member = widget.member!;
                await controller.deleteMembers();
                Navigator.of(context).pop();
                Modular.to.navigate(AppRoutes.MEMBER);
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
            'Membro',
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
            onPressed: () => Modular.to.navigate(AppRoutes.MEMBER),
          ),
          actions: [
            ...(widget.member?.name != null
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
      body: BodyMemberForm(member: widget.member),
    );
  }
}
