import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/models/user_model.dart';
import '../../../../../../../core/config/app_routes.dart';
import '../widgets/body_user.dart';



class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuários',
        )
      ),
      body: const BodyUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to
              .navigate(AppRoutes.USER_FORM, arguments: UserModel());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
