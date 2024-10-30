// ignore_for_file: unnecessary_new, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../controllers/user_controller.dart';
import '../widgets/body_user_form.dart';

class UserFormPage extends StatefulWidget {
  final UserModel? user;
  const UserFormPage({Key? key, this.user}) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ModularState<UserFormPage, UserController> {
  Future<void> onClickDelete() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: Text("Deseja excluir o ${widget.user?.name}"),
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
                controller.model = widget.user!;
                Navigator.of(context).pop();
                await controller.deleteUser();
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
            'Usuário',
          ),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.USER),
          ),
          actions: [
            ...(widget.user?.name != null
                ? [
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onClickDelete),
                  ]
                : [])
          ]),
      body: BodyUserForm(
        user: widget.user,
      ),
    );
  }
}
